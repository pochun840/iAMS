<?php

class Historicals_new{
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

    #取得CSV
    public function csv_info($system_sn){
        $sql = "SELECT * FROM `fasten_data` WHERE    on_flag ='0' AND system_sn in('".$system_sn."') order by data_time desc";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);
        return $rows;
  
    }

    #取得鎖附的資料
    public function monitors_info($info_arr,$offset=0, $limit){


        $sql = "SELECT * FROM `fasten_data` WHERE    on_flag ='0' ";

        #barcodesn 
        if(!empty($info_arr['barcodesn'])){
            $sql.=" AND  cc_barcodesn = '".$info_arr['barcodesn']."'";
        }


        #systemsn 
        if(!empty($info_arr['system_sn'])){
            $sql.=" AND  system_sn = '".$info_arr['system_sn']."'";
        }

        #日期
        if(!empty($info_arr['fromdate']) && !empty($info_arr['todate'])){

            $info_arr['fromdate'] = str_replace("-","",$info_arr['fromdate'])." 00:00:00";
            $info_arr['todate']   = str_replace("-","",$info_arr['todate'])." 23:59:59";

            $sql.=" AND data_time BETWEEN  '".$info_arr['fromdate']."' AND  '".$info_arr['todate']."'  ";
        }

        #鎖附狀態(ALL & OK & OKALL & NG)
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

        #search_name(模糊搜尋)
        if(!empty($info_arr['sname'])){
            $sql.=" AND job_name  LIKE '%{$info_arr['sname']}%'  OR sequence_name LIKE '%{$info_arr['sname']}%' OR  cc_task_name LIKE '%{$info_arr['sname']}%' OR cc_barcodesn LIKE '%{$info_arr['sname']}%'";
        }
      

        #job_id && seq_id && task_id 
        if(!empty($info_arr['job_id'][0]) && empty($info_arr['sequence_id'][0]) && empty($info_arr['cc_task_id'][0])) {

            $sql .=" AND job_id = '".$info_arr['job_id'][0]."' ";
        }

        if(!empty($info_arr['job_id'][0]) && !empty($info_arr['sequence_id'][0]) && empty($info_arr['cc_task_id'][0])) {

            $sql .=" AND job_id = '".$info_arr['job_id'][0]."' AND sequence_id = '".$info_arr['sequence_id'][0]."' ";
        }

        if(!empty($info_arr['job_id'][0]) && !empty($info_arr['sequence_id'][0]) && !empty($info_arr['cc_task_id'][0])) {

            $sql .=" AND job_id = '".$info_arr['job_id'][0]."' AND sequence_id = '".$info_arr['sequence_id'][0]."' AND  cc_task_id = '".$info_arr['cc_task_id'][0]."' ";
        }
        $sql.=" order by data_time desc limit '".$offset."','".$limit."' ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;

    }

    #查詢table 的所有欄位


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

    #api
    public function for_api($essential){
        
        

        $sql = "SELECT * FROM `fasten_data` WHERE  on_flag = '0' ";
        #列出所有error_message
        if($essential['mode' ] == "ng_reason"){
            //$sql = "SELECT error_message  FROM `fasten_data` WHERE  on_flag = '0' ";
            $sql.= "AND fasten_status in('7','8')";
        }

        $sql.= " ORDER BY data_time DESC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result; 


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
        $status_arr[7] = 'NG';
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

        $status_arr_color = array();
        $status_arr_color[0]= '';
        $status_arr_color[1]= '';
        $status_arr_color[2]= '';
        $status_arr_color[3]= '#007AB8;';
        $status_arr_color[4]= '#99CC66;'; 
        $status_arr_color[5]= '#FFCC00;';
        $status_arr_color[6]= '#FFCC00;';
        $status_arr_color[7]= 'red;';
        $status_arr_color[8]= 'red;';
        $status_arr_color[9]= '';
        $status_arr_color[10] = '';
        $status_arr_color[11] = '';
        $status_arr_color[12] = '';
        $status_arr_color[13] = '';
        $status_arr_color[14] = '';
        $status_arr_color[15] = '';
        $status_arr_color[16] = '';
        $status_arr_color[17] = '';
        $status_arr_color[18] = '';
        $status_arr_color[19] = '';


        $error_msg = array();
        $error_msg[0] =  '';
        $error_msg[1] = 'ERR-CONT-TEMP';
        $error_msg[2] = 'ERR-MOT-TEMP';
        $error_msg[3] = 'ERR-MOT-CURR';
        $error_msg[4] = 'ERR-MOT-PEAK-CURR';
        $error_msg[5] = 'ERR-HIGH-TORQUE';
        $error_msg[6] = 'ERR-DEADLOCK';
        $error_msg[7] = 'ERR-PROC-MINTIME';
        $error_msg[8] = 'ERR-PROC-MAXTIME';
        $error_msg[9] = 'ERR-ENCODER';
        $error_msg[10] = 'ERR-HALL';
        $error_msg[11] = 'ERR-BUSVOLT-HIGH';
        $error_msg[12] = 'ERR-BUSVOLT-LOW';
        $error_msg[13] = 'ERR-PROC-NA';
        $error_msg[14] = 'ERR-STEP-NA';
        $error_msg[15] = 'ERR-DMS-COMM';
        $error_msg[16] = 'ERR-FLASH';
        $error_msg[17] = 'ERR-FRAM';
        $error_msg[18] = 'ERR-HIGH-ANGLE';
        $error_msg[19] = 'ERR-PROTECT-CIRCUIT';
        $error_msg[20] = 'ERR-SWITCH-CONFIG';
        $error_msg[21] = 'ERR-STEP-NOT-REC';
        $error_msg[22] = 'ERR-TMD-FRAM';
        $error_msg[23] = 'ERR-LOW-TORQUE';
        $error_msg[24] = 'ERR-LOW-ANGLE';
        $error_msg[25] = 'ERR-PROC-NOT-FINISH';
        $error_msg[26] = 'SEQ-COMPLETED';
        $error_msg[27] = 'JOB-COMPLETED';
        $error_msg[28] = 'WORKPIECE-RECOVERY';


        $direction_arr = array();
        $direction_arr[0] = "CW";
        $direction_arr[1] = "CCW";
          
        $status_final = array();
        $status_final['status_type'] = $status_arr;
        $status_final['status_color'] = $status_arr_color;
        $status_final['error_msg'] = $error_msg;
        $status_final['direction'] = $direction_arr;
        
        return $status_final;

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

    public function unitConvert($value){
        
        #取出目前的單位 
        #0: 公斤米
        #1: 牛頓米
        #2: 公斤公分
        #3: 英鎊英寸
        if(!empty($_COOKIE['unit_mode'])){
            $unit_mode = $_COOKIE['unit_mode'];
        }else{
            $unit_mode = '';
        }
        


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

        if(!empty($no)){
            $csv_file = "DATALOG_000000".$no."_1p0.csv";
        }else{
            //$csv_file = '';
        }

        #連接到FTP
        $conn_id = ftp_connect($ftp_server);

        #登錄FTP
        $login_result = ftp_login($conn_id, $ftp_user, $ftp_pass);;

        if ($conn_id && $login_result){
            #切換到存放曲線圖路徑
            if (ftp_chdir($conn_id, $ftp_dir)){
                #取得.CSV 文件列表
                $files = ftp_nlist($conn_id, ".");
                if(empty($csv_file)){
                    usort($files, function($a, $b) use ($conn_id) {
                        $mtime_a = ftp_mdtm($conn_id, $a);
                        $mtime_b = ftp_mdtm($conn_id, $b);
                        return $mtime_b - $mtime_a; // 从大到小排序
                    });
        
                }else{
                    #combinedata的頁面過來
                    $files[0] =  $csv_file;
                }
                if($files[0]!= ""){

                    $csv_file = $files[0];
                    $filename =  $ftp_dir.$csv_file;
                    if (in_array($csv_file, $files)){

                        #csv 如果存在 並且轉換成陣列
                        $tempFile = tempnam(sys_get_temp_dir(), 'ftp_');
                        $ftp_get = ftp_get($conn_id, $tempFile, $filename, FTP_BINARY);
                        if ($ftp_get) {
                            $csvdata = array_map('str_getcsv', file($tempFile));
                            unlink($tempFile);
                        }else{
                            #
                        }

                    } else {
                        echo "File".$ftp_file."does not exist";
                    }
                }else{


                }
            }else{
                echo "Failed to change directory to".$ftp_dir; 
            }

            #關閉FTP連線
            ftp_close($conn_id);
        }else{
     
        }

        return $csvdata;

    }


    public function chat_change($chat_mode){

        /*
        $position = 1 (扭力)
        $position = 2 (角度)
        $position = 3 (轉速)
        $position = 4 (功率)
        $position = 5 (扭力) 
        */ 
        
        $chat_arr = array();
        if($chat_mode =="1"){
            $chat_name = "Torque/Time";
            $position = 1;  
            $yaxis_title = "Torque";
            $xaxis_title = "Time(MS)";
        }else if($chat_mode =="2"){
            $chat_name = "Angle/Time";
            $position = 2;  
            $yaxis_title = "Angle";
            $xaxis_title = "Time(MS)";
        }else if($chat_mode =="3"){
            $chat_name = "RPM/Time";
            $position = 3;  
            $yaxis_title = "RPM";
            $xaxis_title = "Time(MS)";
        }else if($chat_mode =="4"){
            $chat_name = "Power/Time";
            $position = 4;  
            $yaxis_title = "Power";
            $xaxis_title = "Time(MS)";
        }else if($chat_mode =="5"){
            $chat_name = "Torque/Angle";
            $position = '5';  
            $yaxis_title = "Torque";
            $xaxis_title = "Angle";

        }else{
            $chat_name = "Torque&Angle/Time";
            $position = '6';  
            $yaxis_title = "Torque/Angle";
            $xaxis_title = "Time(MS)";


        }

        if(!empty($chat_name)){
            $chat_arr['chat_name'] = $chat_name;
            $chat_arr['position']  = $position;
            $chat_arr['yaxis_title']  = $yaxis_title;
            $chat_arr['xaxis_title'] = $xaxis_title;

        }

        return $chat_arr;
    }


    public function get_result($checked_sn_in,$id){

        $file_arr = array('_0p5','_1p0','_2p0');#檔案格式
        $no_arr  = explode(',',$id);

        foreach($no_arr as $key => $val){
            $name = 'data'.$key;
            if(!empty($val)){
                foreach ($file_arr as $file_suffix) {
                    $infile = "C:\web\mywebsite.com\imas\public\data\DATALOG_000000".$val.$file_suffix.".csv";
                    if (file_exists($infile)) {
                        $csvdata = file_get_contents($infile);
                        $rows = explode("\n", $csvdata);
                        $csv_array[$name] = array_map('str_getcsv', $rows);
                        break; #找到了檔案，就中斷迴圈
                    }
                }
            }
        }
        
        foreach($csv_array as $key => &$innerarray) {
            foreach($innerarray as $key1 => $va) {
                if(empty($va[1])){
                    unset($innerarray[$key1]);
                }else{
                    $innerarray[$key1] = $va[1];
                }
            }
        }
        return $csv_array;
    }


    #nextinfo 
    public function get_info($no,$chat_mode){
        if(!empty($no)){
            $file_arr = array('_0p5','_1p0','_2p0');#檔案格式
            foreach ($file_arr as $k_f => $v_f) {
                if (!empty($v_f)) {
                    $infile = "C:/web/mywebsite.com/imas/public/data/DATALOG_000000".$no.$v_f.".csv";
                    if (file_exists($infile)) {
                        $csvdata_tmp = file_get_contents($infile);
                        if (!empty($csvdata_tmp)) {
                            $csvdata = $csvdata_tmp;
                            $lines = explode("\n", $csvdata); 
                            $csv_array = array_map('str_getcsv', $lines); 
                            break; 
                        }
                    }
                }
            }
        }

        if(empty($csv_array)){
            echo '<script>alert("查無該筆的鎖附資料");</script>';
            header("Location:?url=Historicals");
            die();
        }else{
            $resultarr = array();
            if($chat_mode =="5"){
                $position  = (int)$chat_mode;#5
                foreach($csv_array as $subarray){
                    
                    if(isset($subarray[1])){
                        $resultarr['torque'][] = $subarray[1];
                    }

                    if(isset($subarray[2])){
                        $resultarr['angle'][] = $subarray[2];
                    }
                        
                }

            }else if($chat_mode =="6"){
                $position  = (int)$chat_mode;#6
                $position  = 1;
                foreach ($csv_array as $subarray) {
                    if(isset($subarray[$position])){
                        $resultarr['torque'][] = $subarray[$position];
                    }
                }

                foreach($csv_array as $subarray){
                    if(isset($subarray[2])){
                        $resultarr['angle'][] = $subarray[2];
                    }
                }

            }else{
                $position = (int)$chat_mode;
                foreach ($csv_array as $subarray) {

                    if(isset($subarray[$position])){
                        $resultarr[] = $subarray[$position];
                    }
                }
            }
            return $resultarr;

        }
        
    }
    #api 
    public function  fasten_data_status(){
        
        #1. 取出NG的狀態()
        $sql ="SELECT * FROM fasten_data WHERE fasten_status not in('4','5','6') ORDER BY data_time DESC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $res_ng_arr = $statement->fetchall(PDO::FETCH_ASSOC);

        return  $res_ng_arr;
 
    }

    /*public function for_api($essential){
        
        $sql = "SELECT * FROM `fasten_data` WHERE  on_flag = '0' ";
        #列出所有error_message
        if($essential['mode' ] == "ng_reason"){
            //$sql = "SELECT error_message  FROM `fasten_data` WHERE  on_flag = '0' ";
            $sql.= "AND fasten_status in('7','8')";
        }W

        $sql.= " ORDER BY data_time DESC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result; 


    }*/

    public function for_api_test($mode){
        
        //$sql = "SELECT * FROM `fasten_data` WHERE  on_flag = '0' ";
        #列出所有error_message
        if($mode == "ng_reason"){
            $sql = "SELECT error_message,fasten_status,count(fasten_status)AS total   FROM `fasten_data` WHERE  on_flag = '0' ";
            $sql.= "AND fasten_status in('7','8')";
            $sql.= " GROUP BY error_message, fasten_status";
        }

        $sql.= " ORDER BY data_time DESC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchall(PDO::FETCH_ASSOC);

        return $result; 


    }

}
