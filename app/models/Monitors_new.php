<?php

class Monitors_new{
    private $db;//condb control box
    private $db_dev;//devdb tool
    private $db_data;//devdb tool
    private $dbh;

    #在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();

    }

    #取得鎖附的資料
    public function monitors_info($info_arr,$offset=0, $limit=300){


        $sql = "SELECT * FROM `fasten_data` WHERE    on_flag ='0' ";

        //barcodesn 
        if(!empty($info_arr['barcodesn'])){
            $sql.=" AND  cc_barcodesn = '".$info_arr['barcodesn']."'";
        }

        // 日期
        if(!empty($info_arr['fromdate']) && !empty($info_arr['todate'])){

            $info_arr['fromdate'] = str_replace("-","",$info_arr['fromdate'])." 00:00:00";
            $info_arr['todate']   = str_replace("-","",$info_arr['todate'])." 23:59:59";

            $sql.=" AND data_time BETWEEN  '".$info_arr['fromdate']."' AND  '".$info_arr['todate']."'  ";
        }


        //var_dump($info_arr['status_val']);//die();

        //鎖附狀態(ALL & OK & OKALL & NG)
        if(!empty($info_arr['status_val'])){

            if($info_arr['status_val'] == "0"){//ALL 

                $sql .="AND fasten_status !='' ";

            }else if($info_arr['status_val'] =="1"){
                $sql .="AND fasten_status = '4' ";

            }else if($info_arr['status_val'] =="2"){
                $sql .=" AND fasten_status = '5' or fasten_status = '6' ";
            }else{
                $sql .=" AND fasten_status = '7' or fasten_status = '8'  ";

            }

            //OK 
            //fasten_status = 4

            //OKALL
            //fasten_status = 5 //fasten_status = 6

            //NG
            //fasten_status = 7 or fasten_status = 8



        }





        //search_name (預設 搜尋 job_name && seq_name)
        if(!empty($info_arr['sname'])){
            $sql.=" AND job_name  LIKE '%{$info_arr['sname']}%'  OR sequence_name LIKE '%{$info_arr['sname']}%' ";
        }
        
        $sql.=" order by data_time desc limit '".$offset."','".$limit."' ";


        //echo $sql;//die();
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;

    }


    #刪除鎖附資料
    public function del_info($del_info_sn){


        #20240401 修改成 update on_flag的資料(0:顯示 1:隱藏)
        $sql= "UPDATE fasten_data SET on_flag = '1' WHERE system_sn = ' ".$del_info_sn."' ";
        
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);


        return $rows;
    }
    public function getTotalItemCount() {

        $sql = "SELECT COUNT(*) as total_count FROM fasten_data order by data_time desc  ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        $total_count = $result[0]['total_count'];

        return $total_count;
    }


    #status 轉換
    public function status_code_change($status_code){

        $status_arr = array();
        $status = (int)$status_code;
        
        $status_arr[0] = 'INIT'; 
        $status_arr[1] = 'READY';
        $status_arr[2] = 'RUNNING';
        $status_arr[3] = 'REVERSE';
        $status_arr[4] = 'OK';
        $status_arr[5] = 'OK-SEQ';
        $status_arr[6] = 'OK-JOB';
        $status_arr[4] = 'NG';
        $status_arr[8] = 'NS';
        $status_arr[9] = 'SETTING';
        $status_arr[10] = 'EOC';
        $status_arr[11] = 'C1';
        $status_arr[12] = 'C1_ERR';
        $status_arr[13] = 'C2';
        $status_arr[14] = 'C2_ERR';
        $status_arr[15] = 'C4';
        $status_arr[16] = 'C4_ERR';
        $status_arr[17] = 'C5';
        $status_arr[18] = 'C5_ERR';
        $status_arr[19] = 'BS';
        return $status_arr[$status];

    }

}
