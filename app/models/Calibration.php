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

        $sql =" SELECT * FROM calibrations ORDER BY id ASC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

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

        $sql =" SELECT * FROM job  ORDER BY job_id DESC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);
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

        $sql = "SELECT * FROM `sequence` WHERE  job_id = :job_id ";
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
        $temp['max_torque'] = $result[0]['max_torque'];
        $temp['min_torque'] = $result[0]['min_torque'];
        $temp['avg_torque'] = $result[0]['avg_torque'];

        return  $result;

    } 





    public function tidy_data($final){

        #從資料庫找出最大 最小 平均 扭力 high_percent low_percent
        $sql =" SELECT  MAX(torque) AS max_torque, MIN(torque) AS min_torque,SUM(torque) AS total_torque    FROM  calibrations ORDER BY id DESC LIMIT 1 ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        $sql_total ="SELECT COUNT(*) AS total_records  FROM calibrations";
        $statement = $this->db->prepare($sql_total);
        $statement->execute();
        $result_total = $statement->fetchAll(PDO::FETCH_ASSOC);

        $count = (int)$result_total[0]['total_records'] + 1;
        if(isset($result[0])){

            $max_torque = floatval($result[0]['max_torque']);
            $min_torque = floatval($result[0]['min_torque']);

            $total_torque = floatval($result[0]['total_torque']);
           
            if($final > $max_torque){
                $max_torque = $final;

            }

            if($final < $min_torque){
                $min_torque = $final;
            }

            #平均值
            $average_torque = round(($total_torque + $max_torque) / $count, 2);

            $high_percent = round((($max_torque - $average_torque) / $average_torque) * 100, 2);
            $low_percent  = round((($min_torque - $average_torque) / $average_torque) * 100, 2);


            $datatime = date("Ymd H:i:s");


            $sql_in = "INSERT INTO `calibrations` ('id','operator','toolsn','torque','unit','max_torque','min_torque','avg_torque','high_percent','low_percent','customize','datatime' )
                    VALUES (:id,:operator,:toolsn,:torque,:unit,:max_torque,:min_torque,:avg_torque,:high_percent,:low_percent,:customize,:datatime)";

            $statement = $this->db->prepare($sql_in);



            $statement->bindValue(':id', $count);
            $statement->bindValue(':operator', 'User111');
            $statement->bindValue(':toolsn', '00000-00000');
            $statement->bindValue(':torque', $final);
            $statement->bindValue(':unit', '1');
            $statement->bindValue(':max_torque', $max_torque);
            $statement->bindValue(':min_torque', $min_torque);
            $statement->bindValue(':avg_torque', $average_torque);
            $statement->bindValue(':high_percent', $high_percent);
            $statement->bindValue(':low_percent', $low_percent);
            $statement->bindValue(':customize', '');
            $statement->bindValue(':datatime', $datatime);

    
            $results = $statement->execute();



            var_dump($results);
            die();
             //"(C42-C43)/C43)";
            //$low_percent  = "(C42-C43)/C43)";

            


        }
    

    }



   
  


}
