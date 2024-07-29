<?php

class Sequence{
    private $db;//condb control box

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();
    }

    // 取得所有Sequence
    public function getSequences($job_id)
    {
        $sql = "SELECT * FROM `sequence` WHERE job_id = :job_id";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetchall(PDO::FETCH_ASSOC);
    }

    // 取得所有Sequence
    public function getSequences_enable($job_id)
    {
        $sql = "SELECT * FROM `sequence` WHERE job_id = :job_id AND sequence_enable = 1";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetchall(PDO::FETCH_ASSOC);
    }

    // 取得所有Sequence
    public function getJob($job_id)
    {
        $sql = "SELECT * FROM `job` WHERE job_id = :job_id";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetch(PDO::FETCH_ASSOC);
    }


    //取得job id，依job_type判斷
    public function get_head_seq_id($job_id){

        $query = "SELECT seq_id FROM sequence where job_id = :job_id ";

        $statement = $this->db->prepare($query);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        $result = $statement->fetch();
        if ($result == false || empty($result) ){
            return array('0'=> 1, 'missing_id' => 1);
        }

        $query = "SELECT seq_id + 1 AS missing_id
                  FROM sequence
                  WHERE (seq_id + 1) NOT IN ( SELECT seq_id FROM sequence where job_id = :job_id ) order by  missing_id limit 1";

        $statement = $this->db->prepare($query);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetch();
    }

    //編輯or新增job
    public function EditSeq($data)
    {
        if( $this->CheckSeqExist($data['job_id'],$data['seq_id']) ){ //已存在，用update

            $sql = "UPDATE `sequence` 
                    SET 
                        seq_name = :seq_name,
                        tightening_repeat = :tightening_repeat,
                        ng_stop = :ng_stop,
                        ok_sequence = :ok_sequence,
                        ok_sequence_stop = :ok_sequence_stop,
                        sequence_mintime = :sequence_mintime,
                        sequence_maxtime = :sequence_maxtime,
                        barcode_start = :barcode_start
                    WHERE job_id = :job_id AND seq_id = :seq_id";
            $statement = $this->db->prepare($sql);
           // $statement->bindValue(':sequence_enable', $data['seq_enable']);
            $statement->bindValue(':seq_name', $data['seq_name']);
            $statement->bindValue(':tightening_repeat', 1); //中控預設1
            $statement->bindValue(':ng_stop', $data['stop_on_NG']);
            $statement->bindValue(':ok_sequence', $data['ok_seq']);
            $statement->bindValue(':ok_sequence_stop', $data['ok_seq_stop']);
            $statement->bindValue(':sequence_maxtime', $data['timeout']);
            $statement->bindValue(':barcode_start', $data['barcode_enable']);
            $statement->bindValue(':sequence_mintime', 0);
            $statement->bindValue(':seq_id', $data['seq_id']);
            $statement->bindValue(':job_id', $data['job_id']);
            $results = $statement->execute();

        }else{ //不存在，用insert

            //echo "eeeeerty";die();
            $sql = "INSERT INTO `sequence` ('sequence_enable','job_id','seq_id','seq_name','tightening_repeat','ng_stop','ok_sequence','ok_sequence_stop','sequence_mintime','sequence_maxtime','img' ,'barcode_start' )
                    VALUES (:sequence_enable,:job_id,:seq_id,:seq_name,:tightening_repeat,:ng_stop,:ok_sequence,:ok_sequence_stop,:sequence_mintime,:sequence_maxtime,:img,:barcode_start)";
            $statement = $this->db->prepare($sql);

            $statement->bindValue(':sequence_enable', 1);
            $statement->bindValue(':seq_name', $data['seq_name']);
            $statement->bindValue(':tightening_repeat', 1); //中控預設1
            $statement->bindValue(':ng_stop', $data['stop_on_NG']);
            $statement->bindValue(':ok_sequence', $data['ok_seq']);
            $statement->bindValue(':ok_sequence_stop', $data['ok_seq_stop']);
            $statement->bindValue(':sequence_mintime', 0);
            $statement->bindValue(':sequence_maxtime', $data['timeout']);
            $statement->bindValue(':img', '');
            $statement->bindValue(':seq_id', $data['seq_id']);
            $statement->bindValue(':job_id', $data['job_id']);
            $statement->bindValue(':barcode_start', $data['barcode_enable']);
            $results = $statement->execute();

        }

        return $results;
    }

    //get seq by job_id and seq_id
    public function GetSeqById($job_id,$seq_id){

        $sql= "SELECT * FROM sequence WHERE job_id = :job_id AND seq_id = :seq_id";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->bindValue(':seq_id', $seq_id);
        $results = $statement->execute();
        $rows = $statement->fetch(PDO::FETCH_ASSOC);

        return $rows;
    }

    //enable or disable sequence
    public function EnableDisableSeq($job_id,$seq_id,$status)   
    {
        $sql = "UPDATE `sequence` SET 'sequence_enable'= :sequence_enable WHERE job_id = :job_id AND seq_id = :seq_id ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':sequence_enable', $status);
        $statement->bindValue(':job_id', $job_id);
        $statement->bindValue(':seq_id', $seq_id);
        $results = $statement->execute();
        return $results;
    }

    public function SetSeqImage($job_id,$seq_id,$img_url)
    {
        $sql = "UPDATE `sequence` 
                    SET img = :img 
                    WHERE job_id = :job_id AND seq_id = :seq_id";
            $statement = $this->db->prepare($sql);
            $statement->bindValue(':job_id', $job_id);
            $statement->bindValue(':seq_id', $seq_id);
            $statement->bindValue(':img', $img_url);
            $results = $statement->execute();

        return $results;
    }

    //檢查job id是否已存在
    public function CheckSeqExist($job_id,$seq_id)
    {
        $sql = "SELECT count(*) as count FROM sequence WHERE job_id = :job_id AND seq_id = :seq_id";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->bindValue(':seq_id', $seq_id);
        $results = $statement->execute();
        $rows = $statement->fetch();

        if ($rows['count'] > 0) {
            return true; // job 已存在
        }else{
            return false; // job 不存在
        }
    }

    public function CopySeq($from_job_id,$from_seq_id,$to_seq_id,$to_seq_name)
    {
        // 判斷seq_id是否存在，若存在就先把舊的刪除
        // $dupli_flag true:表示job_id已存在 false:表示job_id不存在
        $dupli_flag = $this->CheckSeqExist($from_job_id,$to_seq_id);

        if($dupli_flag){
            $this->DeleteSeqById($from_job_id,$to_seq_id);
        }
        $sql= "INSERT INTO sequence ( sequence_enable,job_id,seq_id,seq_name,img,tightening_repeat,ng_stop,ok_sequence,ok_sequence_stop,sequence_mintime,sequence_maxtime )
            SELECT  sequence_enable,job_id,:to_seq_id,:to_seq_name,img,tightening_repeat,ng_stop,ok_sequence,ok_sequence_stop,sequence_mintime,sequence_maxtime
            FROM    sequence
            WHERE job_id = :job_id AND seq_id = :seq_id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':to_seq_id', $to_seq_id);
        $stmt->bindValue(':to_seq_name', $to_seq_name);

        $stmt->bindValue(':job_id', $from_job_id);
        $stmt->bindValue(':seq_id', $from_seq_id);

        return $results = $stmt->execute();
    }

    public function DeleteSeqById($job_id,$seq_id)
    {
        //刪除sequence
        $stmt = $this->db->prepare('DELETE FROM sequence WHERE job_id = :job_id AND seq_id = :seq_id');
        $stmt->bindValue(':job_id', $job_id);
        $stmt->bindValue(':seq_id', $seq_id);
        $results = $stmt->execute();

        //更新seq_id
        $sql2= "UPDATE sequence SET seq_id = seq_id - 1 WHERE job_id = :job_id AND seq_id > :seq_id";
        $stmt = $this->db->prepare($sql2);
        $stmt->bindValue(':job_id', $job_id);
        $stmt->bindValue(':seq_id', $seq_id);
        $results2 = $stmt->execute();

        //更新對應的step

        //刪除task
        $stmt = $this->db->prepare('DELETE FROM task WHERE job_id = :job_id AND seq_id = :seq_id');
        $stmt->bindValue(':job_id', $job_id);
        $stmt->bindValue(':seq_id', $seq_id);
        $results = $stmt->execute();

        //刪除其他關聯
        //delete ccs_normalstep
        $statement = $this->db->prepare('DELETE FROM ccs_normalstep WHERE job_id = :job_id AND seq_id = :seq_id  ');
        $statement->bindValue(':job_id', $job_id);
        $statement->bindValue(':seq_id', $seq_id);
        $results = $statement->execute();
        //delete ccs_advancedstep
        $statement = $this->db->prepare('DELETE FROM ccs_advancedstep WHERE job_id = :job_id AND seq_id = :seq_id  ');
        $statement->bindValue(':job_id', $job_id);
        $statement->bindValue(':seq_id', $seq_id);
        $results = $statement->execute();
        
        return $results;
    }

}
