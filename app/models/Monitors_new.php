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
        }

        //search_name (預設 搜尋 job_name && seq_name)
        if(!empty($info_arr['sname'])){
            $sql.=" AND job_name  LIKE '%{$info_arr['sname']}%'  OR sequence_name LIKE '%{$info_arr['sname']}%' OR  cc_task_name LIKE '%{$info_arr['sname']}%' OR cc_barcodesn LIKE '%{$info_arr['sname']}%'";
        }
        $sql.=" order by data_time desc limit '".$offset."','".$limit."' ";


        //echo $sql;

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
    public function status_code_change(){

        $status_arr = array();
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
        return $status_arr;

    }

    # 扭力轉換
    
    public function torque_change(){
        #0: 公斤米
        #1: 牛頓米 起子預設是牛頓米
        #2: 公斤公分
        #3: 英鎊英寸


        $torque = array();
        $torque[0] = 'Kgf.m'; 
        $torque[1] = 'N.m';
        $torque[2] = 'Kgf.cm';
        $torque[3] = 'In.lbs';
    
        return $torque;

    }


    public function get_info_data($index){
        

        $sql = "SELECT * FROM `fasten_data` WHERE    system_sn ='".$index."' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $res = $statement->fetchall(PDO::FETCH_ASSOC);

        return  $res;


    }

    public function get_job_id(){
        
        $sql = "SELECT * FROM `fasten_data` WHERE job_id != '' AND on_flag = '0' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result;

    }

    public function get_seq_id($job_id){

        $sql = "SELECT * FROM `fasten_data` WHERE job_id = '".$job_id."' AND on_flag = '0' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result;
    }

    public function get_task_id($job_id,$seq_id){

        $sql = "SELECT * FROM `fasten_data` WHERE job_id = '".$job_id."' AND sequence_id = '".$seq_id."' AND on_flag = '0' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result;
    }



    public function connected_ftp($no){

        #FTP連線相關資訊
        $ftp_server = "192.168.0.135";
        $ftp_user = "kls";
        $ftp_pass = "12345678rd";
        $ftp_dir = "/mnt/ramdisk/FTP/";

        #FTP曲線圖路徑
        $csv_file = "DATALOG_000000".$no."_1p0.csv";

   
        #連接到FTP
        $conn_id = ftp_connect($ftp_server);

        #登錄FTP
        $login_result = ftp_login($conn_id, $ftp_user, $ftp_pass);

        if ($conn_id && $login_result) {
            #切换到存放曲線圖路徑
            if (ftp_chdir($conn_id, $ftp_dir)) {
                #取得.CSV 文件列表
                $files = ftp_nlist($conn_id, ".");

                if($files[0]!= ""){
                    $filename =  $ftp_dir.$csv_file;
                    if (in_array($csv_file, $files)){

                        #csv 如果存在 並且轉換成陣列
                        $tempFile = tempnam(sys_get_temp_dir(), 'ftp_');
                        $ftp_get = ftp_get($conn_id, $tempFile, $filename, FTP_BINARY);
                        if ($ftp_get) {
                            //echo "open";
                            $csvdata = array_map('str_getcsv', file($tempFile));
                            unlink($tempFile);


                        }else{
                            //echo "nono";
                        }

                    } else {
                        echo "File".$ftp_file."does not exist";
                    }
                  
                }
            }else{
                //echo "Failed to change directory to $ftp_dir"; 
            }

            #關閉FTP連線
            ftp_close($conn_id);
        }else{
            //echo "Failed to connect to FTP server";
        }

        return $csvdata;

    }
}
