<?php

class Calibration{
    private $db;//condb control box
    private $db_dev;//devdb tool
    private $db_iDas;//iDas db
    private $db_cc;//iDas db

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();
    }


    public function details($mode){

        $details = array();
        if($mode =="controller"){
            $details = array(
                0 => 'GTCS',
                1 => 'TCG',
            );
        }

        if($mode =="torquemeter"){
            $details = array(
                0 => 'KTM-150',
                1 => 'KTM-50',
                2 => 'KTM-100'
            );


        }

        if($mode =="torque"){
            $details  = array(
                1 => 'N.m',
                0 => 'Kgf.m',
                2 => 'Kgf.cm',
                3 => 'In.lbs',
            );
    
        }

        return $details;
    }


    public function datainfo(){

        # 需要job_id 
        $sql =" SELECT * FROM calibrations ORDER BY id ASC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;

    }

    public function datainfo_search($job_id){

        $sql = "SELECT * FROM `calibrations` WHERE  job_id = :job_id  ORDER BY id ASC  ";
        $params[':job_id'] = $job_id;
        $statement = $this->db->prepare($sql);
        $statement->execute($params);
        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }

    public function echarts_data(){

        $sql =" SELECT * FROM calibrations ORDER BY id ASC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        
        $result_charts = $statement->fetchAll(PDO::FETCH_ASSOC);
        return $result_charts;        
    }

    public function getjobid(){
   
        $sql = "SELECT * FROM `job` WHERE job_id != '' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;      
    }

    public function get_job_name($job_id){

        $sql = "SELECT * FROM `job` WHERE  job_id = :job_id ";
        $params[':job_id'] = $job_id;
        $statement = $this->db->prepare($sql);
        $statement->execute($params);
        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }

    public function get_seq_id($job_id){

        $sql = "SELECT * FROM `sequence` WHERE  sequence_enable = '1' AND job_id = :job_id ";
        $params[':job_id'] = $job_id;
        $statement = $this->db->prepare($sql);
        $statement->execute($params);
        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }

     #用job_id及sequence_id 找出對應的task_id
     public function get_task_id($job_id, $seq_id) {

        $sql = "SELECT * FROM `task` WHERE job_id = :job_id AND seq_id = :seq_id ";
        $params[':job_id'] = $job_id;
        $params[':seq_id'] = $seq_id;
        $statement = $this->db->prepare($sql);
        $statement->execute($params);

        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }


    public function meter_info(){

        $temp = array();

        $a = 0.6;
        $b = 0.06;

        $sql ="SELECT 
                (SELECT MAX(torque) FROM calibrations) AS max_torque,
                (SELECT MIN(torque) FROM calibrations) AS min_torque,
                (SELECT SUM(torque) FROM calibrations) AS total_torque,
                *
            FROM
                calibrations 
            ORDER BY
                id ASC;
            ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        #依照KTM 文件裡的算式 
        $hi_limit_torque =  $a+$b;

        $temp['hi_limit_torque'] = $a + $b;
        $temp['low_limit_torque'] = $a - $b;
        $temp['max_torque'] = $result[0]['max_torque'] ?? null; 
        $temp['min_torque'] = $result[0]['min_torque'] ?? null; 
        $temp['avg_torque'] = $result[0]['avg_torque'] ?? null; 

        return  $result;

    } 

    
    public function tidy_data($final) {
        $job_id = 221;
    
        $sql = "SELECT MAX(torque) AS max_torque, MIN(torque) AS min_torque, SUM(torque) AS total_torque,
                (SELECT id FROM calibrations ORDER BY id DESC LIMIT 1) AS latest_id
                FROM calibrations";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);


        $tool_sn_result = $this->get_tool_sn();
        $toolsn = !empty($tool_sn_result) ? $tool_sn_result[0]['tool_sn'] : '00000-00000'; // 假设 'tool_sn' 是所需字段

    

        $sql_total = "SELECT COUNT(*) AS total_records FROM calibrations";
        $statement = $this->db->prepare($sql_total);
        $statement->execute();
        $result_total = $statement->fetchAll(PDO::FETCH_ASSOC);
    
        $count = (int)$result[0]['latest_id'] + 1;
    
        if (isset($result[0])) {
            $max_torque = floatval($result[0]['max_torque']);
            $min_torque = floatval($result[0]['min_torque']);
            $total_torque = floatval($result[0]['total_torque']);
    
            if ($final > $max_torque) {
                $max_torque = $final;
            }
            if ($final < $min_torque) {
                $min_torque = $final;
            }
    
            $average_torque = round(($total_torque + $max_torque) / $count, 2);
            $high_percent = round((($max_torque - $average_torque) / $average_torque) * 100, 2);
            $low_percent = round((($min_torque - $average_torque) / $average_torque) * 100, 2);
            $datatime = date("Ymd H:i:s");
    
            $sql_in = "INSERT INTO `calibrations` (`id`, `job_id`, `controller_type`, `ktm_type`, `operator`, `toolsn`, `torque`, `unit`, `max_torque`, `min_torque`, `avg_torque`, `high_percent`, `low_percent`, `customize`, `datatime`)
                       VALUES (:id, :job_id, :controller_type, :ktm_type, :operator, :toolsn, :torque, :unit, :max_torque, :min_torque, :avg_torque, :high_percent, :low_percent, :customize, :datatime)";
    
            $statement = $this->db->prepare($sql_in);
            if (!$statement) {
                echo "Prepare failed: " . implode(":", $this->db->errorInfo());
                return false; 
            }
    
            // 绑定参数
            $statement->bindValue(':id', $count);
            $statement->bindValue(':job_id', $job_id);
            $statement->bindValue(':controller_type', '0');
            $statement->bindValue(':ktm_type', '0');
            $statement->bindValue(':operator', $_SESSION['user']);
            $statement->bindValue(':toolsn',  $tool_sn_result[0]['tool_sn']);
            $statement->bindValue(':torque', $final);
            $statement->bindValue(':unit', '1');
            $statement->bindValue(':max_torque', $max_torque);
            $statement->bindValue(':min_torque', $min_torque);
            $statement->bindValue(':avg_torque', $average_torque);
            $statement->bindValue(':high_percent', $high_percent);
            $statement->bindValue(':low_percent', $low_percent);
            $statement->bindValue(':customize', '');
            $statement->bindValue(':datatime', $datatime);
    
            // 执行
            $results = $statement->execute();
            if (!$results) {
                echo "Execution failed: " . implode(":", $statement->errorInfo());
                return false; // 处理错误
            }
    
            return true; // 插入成功
        }
    
        return false; // 无结果
    }
    

    public function del_info($lastid) {
        // Step 1: 使用指定的 id 刪除 calibrations 表中的記錄
        $sql_delete = "DELETE FROM `calibrations` WHERE id = :id";
        $statement_delete = $this->db->prepare($sql_delete);
        $statement_delete->bindValue(':id', $lastid);
        $statement_delete->execute();
        
        // Step 2: 更新所有大於被刪除 id 的記錄的 id
        $sql_update_ids = "UPDATE `calibrations` SET id = id - 1 WHERE id > :lastid";
        $statement_update_ids = $this->db->prepare($sql_update_ids);
        $statement_update_ids->bindValue(':lastid', $lastid);
        $statement_update_ids->execute();
    
        // Step 3: 計算並更新資料庫中的 max_torque、min_torque 和 avg_torque
        $sql_select = "SELECT MAX(torque) AS max_torque, MIN(torque) AS min_torque, AVG(torque) AS avg_torque FROM calibrations";
        $stmt_select = $this->db->query($sql_select);
        $result = $stmt_select->fetch(PDO::FETCH_ASSOC);
    
        // Step 4: 更新 max_torque、min_torque 和 avg_torque
        $new_max_torque = $result['max_torque'];
        $new_min_torque = $result['min_torque'];
        $new_avg_torque = $result['avg_torque']; 
    
        $sql_update = "UPDATE calibrations SET max_torque = :new_max_torque, min_torque = :new_min_torque, avg_torque = :new_avg_torque";
        $stmt_update = $this->db->prepare($sql_update);
        $stmt_update->bindParam(':new_max_torque', $new_max_torque, PDO::PARAM_STR);
        $stmt_update->bindParam(':new_min_torque', $new_min_torque, PDO::PARAM_STR);
        $stmt_update->bindParam(':new_avg_torque', $new_avg_torque, PDO::PARAM_STR); // 綁定 avg_torque
        $stmt_update->execute();
    
        // Step 5: 返回結果
        return $result;
    }
    

    
    public function get_tool_sn(){

        $sql = "SELECT * FROM fasten_data ORDER BY id DESC LIMIT 1 ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);
        return $result;

    }


    //在 function tidy_data 中 需要 include function get_tool_sn 的資料
}
