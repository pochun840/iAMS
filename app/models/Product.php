<?php

class Product{
    private $db;//condb control box

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();
    }

    // 取得所有Job
    public function getJobs()
    {
        $sql = "SELECT
                  job.*,
                  COUNT(DISTINCT seq.seq_id) AS seq_count,
                  COUNT(DISTINCT task.task_id) AS task_count
                FROM
                  job
                LEFT JOIN
                  sequence as seq ON job.job_id = seq.job_id
                LEFT JOIN
                  task ON seq.seq_id = task.seq_id AND seq.job_id = task.job_id
                GROUP BY
                  job.job_id;
                ";
        $statement = $this->db->prepare($sql);
        $statement->execute();

        return $statement->fetchall();
    }

    // 取得Job by job id
    public function getJobById($job_id)
    {
        $sql = "SELECT *  FROM `job` WHERE job_id = :job_id ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetch(PDO::FETCH_ASSOC);
    }

    //編輯or新增job
    public function EditJob($data)
    {
        if( $this->CheckJobExist($data['job_id']) ){ //已存在，用update

            $sql = "UPDATE `job` 
                    SET job_name = :job_name,
                        controller_id = :controller_id,
                        ok_job = :ok_job,
                        ok_job_stop = :ok_job_stop,
                        reverse_direction = :reverse_direction,
                        reverse_rpm = :reverse_rpm,
                        reverse_force = :reverse_force,
                        reverse_cnt_mode = :reverse_cnt_mode,
                        reverse_threshold_torque = :reverse_threshold_torque,
                        point_size = :point_size,
                        barcode_start = :barcode_start,
                        tower_light = :tower_light
                    WHERE job_id = :job_id ";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':job_name', $data['job_name']);
            $statement->bindValue(':controller_id', $data['controller_type']);
            $statement->bindValue(':ok_job', $data['ok_job']);
            $statement->bindValue(':ok_job_stop', $data['ok_job_stop']);
            $statement->bindValue(':reverse_direction', $data['reverse_button']);
            $statement->bindValue(':reverse_rpm', $data['reverse_rpm']);
            $statement->bindValue(':reverse_force', $data['reverse_Force']);
            $statement->bindValue(':reverse_cnt_mode', $data['reverse_count']);
            $statement->bindValue(':reverse_threshold_torque', $data['threshold_torque']);
            $statement->bindValue(':point_size', $data['size']);
            $statement->bindValue(':barcode_start', $data['barcode_start']);
            $statement->bindValue(':tower_light', $data['tower_light']);
            $statement->bindValue(':job_id', $data['job_id']);
            $results = $statement->execute();

        }else{ //不存在，用insert

            $sql = "INSERT INTO `job` ('job_id','job_name','controller_id','ok_job','ok_job_stop','reverse_direction','reverse_rpm','reverse_force','reverse_cnt_mode','reverse_threshold_torque','point_size','barcode_start','tower_light' )
                    VALUES (:job_id,:job_name,:controller_id,:ok_job,:ok_job_stop,:reverse_direction,:reverse_rpm,:reverse_force,:reverse_cnt_mode,:reverse_threshold_torque,:point_size,:barcode_start,:tower_light)";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':job_name', $data['job_name']);
            $statement->bindValue(':controller_id', $data['controller_type']);
            $statement->bindValue(':ok_job', $data['ok_job']);
            $statement->bindValue(':ok_job_stop', $data['ok_job_stop']);
            $statement->bindValue(':reverse_direction', $data['reverse_button']);
            $statement->bindValue(':reverse_rpm', $data['reverse_rpm']);
            $statement->bindValue(':reverse_force', $data['reverse_Force']);
            $statement->bindValue(':reverse_cnt_mode', $data['reverse_count']);
            $statement->bindValue(':reverse_threshold_torque', $data['threshold_torque']);
            $statement->bindValue(':point_size', $data['size']);
            $statement->bindValue(':barcode_start', $data['barcode_start']);
            $statement->bindValue(':tower_light', $data['tower_light']);
            $statement->bindValue(':job_id', $data['job_id']);
            $results = $statement->execute();

        }

        return $results;
    }

    //檢查job id是否已存在
    public function CheckJobExist($job_id)
    {
        $sql = "SELECT count(*) as count FROM job WHERE job_id = :job_id";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $results = $statement->execute();
        $rows = $statement->fetch();

        if ($rows['count'] > 0) {
            return true; // job 已存在
        }else{
            return false; // job 不存在
        }
    }

    public function SetJobImage($job_id,$img_url)
    {
        $sql = "UPDATE `job` 
                    SET img = :img 
                    WHERE job_id = :job_id ";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':job_id', $job_id);
            $statement->bindValue(':img', $img_url);
            $results = $statement->execute();

        return $results;
    }

    public function DeleteJobById($job_id)
    {
        $stmt = $this->db->prepare('DELETE FROM job WHERE job_id = :job_id');
        $stmt->bindValue(':job_id', $job_id);
        $results = $stmt->execute();

        //刪除sequence
        $stmt = $this->db->prepare('DELETE FROM sequence WHERE job_id = :job_id');
        $stmt->bindValue(':job_id', $job_id);
        $results = $stmt->execute();

        //刪除task
        $stmt = $this->db->prepare('DELETE FROM task WHERE job_id = :job_id');
        $stmt->bindValue(':job_id', $job_id);
        $results = $stmt->execute();

        //刪除其他關聯
        //刪除ccs_normalstep、ccs_advancedstep
        //delete ccs_normalstep
        $statement = $this->db->prepare('DELETE FROM ccs_normalstep WHERE job_id = :job_id ');
        $statement->bindValue(':job_id', $job_id);
        $results = $statement->execute();
        //delete ccs_advancedstep
        $statement = $this->db->prepare('DELETE FROM ccs_advancedstep WHERE job_id = :job_id ');
        $statement->bindValue(':job_id', $job_id);
        $results = $statement->execute();

        
        return $results;
    }

    // public function CopyJob($from_job_id,$to_job_id,$to_job_name)
    // {
    //     $stmt = $this->db->prepare('DELETE FROM job WHERE job_id = :job_id');
    //     $stmt->bindValue(':job_id', $job_id);
    //     $results = $stmt->execute();
        
    //     return $results;
    // }

    public function CopyJob($from_job_id,$to_job_id,$to_job_name){
        // 判斷job_id是否存在，若存在就先把舊的刪除
        // $dupli_flag true:表示job_id已存在 false:表示job_id不存在
        $dupli_flag = $this->CheckJobExist($to_job_id);

        if($dupli_flag){
            $this->DeleteJobById($to_job_id);
        }
        $sql= "INSERT INTO job ( job_id,job_name,controller_id,ok_job,ok_job_stop,reverse_force,reverse_rpm,reverse_direction,reverse_cnt_mode,reverse_threshold_torque,point_size,img )
            SELECT  :to_job_id,:to_job_name,controller_id,ok_job,ok_job_stop,reverse_force,reverse_rpm,reverse_direction,reverse_cnt_mode,reverse_threshold_torque,point_size,img
            FROM    job
            WHERE job_id = :job_id ";
        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':to_job_id', $to_job_id);
        $stmt->bindValue(':to_job_name', $to_job_name);
        $stmt->bindValue(':job_id', $from_job_id);

        return $results = $stmt->execute();
    }


    
    //取得job id，依job_type判斷
    public function get_head_job_id(){

        $query = "SELECT job_id FROM job ";

        $statement = $this->db->prepare($query);
        $statement->execute();

        $result = $statement->fetch();
        if ($result == false || empty($result) ){
            return array('0'=> 1, 'missing_id' => 1);
        }

        $query = "SELECT job_id + 1 AS missing_id
                  FROM job
                  WHERE (job_id + 1) NOT IN ( SELECT job_id FROM job  ) order by  missing_id limit 1";

        $statement = $this->db->prepare($query);
        $statement->execute();

        return $statement->fetch();
    }

    //barcode function

    public function EditBarcode($barcode,$match_from,$match_to,$job_id,$seq_id)
    {
        if( $this->CheckBarcodeRepeat($barcode,$match_from,$match_to,$job_id,$seq_id) ){ //重複barcode

            return 'repeat';
        }


        if( $this->CheckBarcodeExist($job_id,$seq_id) ){ //已存在，用update

            $sql = "UPDATE `barcode` 
                    SET barcode = :barcode,
                        barcode_mask_from = :barcode_mask_from,
                        barcode_mask_count = :barcode_mask_count 
                    WHERE barcode_selected_job = :job_id AND barcode_selected_seq = :seq_id ";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':barcode', $barcode);
            $statement->bindValue(':barcode_mask_from', $match_from);
            $statement->bindValue(':barcode_mask_count', $match_to);
            $statement->bindValue(':job_id', $job_id);
            $statement->bindValue(':seq_id', $seq_id);
            $results = $statement->execute();

        }else{ //不存在，用insert

            $sql = "INSERT INTO `barcode` ('barcode','barcode_mask_from','barcode_mask_count','barcode_selected_job','barcode_selected_seq' )
                    VALUES (:barcode,:barcode_mask_from,:barcode_mask_count,:job_id,:seq_id)";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':barcode', $barcode);
            $statement->bindValue(':barcode_mask_from', $match_from);
            $statement->bindValue(':barcode_mask_count', $match_to);
            $statement->bindValue(':job_id', $job_id);
            $statement->bindValue(':seq_id', $seq_id);
            $results = $statement->execute();

        }

        return $results;
    }

    public function CheckBarcodeExist($job_id,$seq_id)
    {
        $sql = "SELECT count(*) as count FROM barcode WHERE barcode_selected_job = :barcode_selected_job AND barcode_selected_seq = :barcode_selected_seq  ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':barcode_selected_job', $job_id);
        $statement->bindValue(':barcode_selected_seq', $seq_id);
        $results = $statement->execute();
        $rows = $statement->fetch();

        if ($rows['count'] > 0) {
            return true; // job 已存在
        }else{
            return false; // job 不存在
        }
    }

    public function CheckBarcodeRepeat($barcode,$match_from,$match_to,$job_id,$seq_id)
    {
        $barcode_length = strlen($barcode);
        $target = substr($barcode, $match_from-1, $match_to);
        $sql = "SELECT *,count(*) as count FROM barcode WHERE  barcode_mask_from = :barcode_mask_from AND barcode_mask_count = :barcode_mask_count AND length(barcode) = :barcode_length AND substr(barcode,barcode_mask_from,barcode_mask_count) = :target ";

        $statement = $this->db->prepare($sql);
        $statement->bindValue(':target', $target);
        $statement->bindValue(':barcode_length', $barcode_length, PDO::PARAM_INT);
        $statement->bindValue(':barcode_mask_from', $match_from);
        $statement->bindValue(':barcode_mask_count', $match_to);
        $results = $statement->execute();
        $row = $statement->fetch();

        if ($row['count'] > 0) {
            if($row['barcode_selected_job'] == $job_id && $row['barcode_selected_seq'] == $seq_id){
                return false;
            }
            return true; // job 已存在
        }else{
            return false; // job 不存在
        }
    }

    public function getBarcodes($value='')
    {
        $sql = "SELECT barcode.*,job_name, seq_name FROM barcode 
                left join job on barcode.barcode_selected_job = job.job_id
                left join sequence on barcode.barcode_selected_seq = sequence.seq_id AND barcode.barcode_selected_job = sequence.job_id
                ";
        $statement = $this->db->prepare($sql);
        $statement->execute();

        return $statement->fetchall(PDO::FETCH_ASSOC);
    }

    public function DeleteBarcode($id)
    {
        $stmt = $this->db->prepare('DELETE FROM barcode WHERE id = :id');
        $stmt->bindValue(':id', $id);
        $results = $stmt->execute();

        return $results;
    }

}
