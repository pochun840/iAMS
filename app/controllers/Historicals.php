<?php

class Historicals extends Controller
{
    private $DashboardModel;
    private $NavsController;


    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
        $this->NavsController = $this->controller_new('Navs');
        $this->UserModel = $this->model('User');
        $this->Historicals_newModel = $this->model('Historical');
    }

    // 取得所有Jobs
    public function index($page){
        if (isset($_COOKIE["nopage"])){
            $nopage = $_COOKIE["nopage"];
        }else{
            $nopage ="0";

        }
        //0 =>不分頁 1=>分頁
        //檢查有無判斷分頁的cookie 
        if ($nopage =="0") {
            //不要分頁
            $offset = 0;
            $limit  = 100000000;
            $nopage ='0';
            $totalPages = 0;

        } else {
           
            //要分頁
            $nopage ='1';
             
            #當前的頁數，默認為第1頁
            $page = isset($_GET['p']) ? $_GET['p'] : 1;

            #每頁顯示的筆數
            $limit = 30;

            #計算數量
            $offset = ($page - 1) * $limit;

            #取得總筆數
            $totalItems  = "";
            $totalItems  = $this->Historicals_newModel->getTotalItemCount();

            #計算總頁數
            if(!empty($totalItems)){
                $totalPages = ceil($totalItems / $limit);
            }

        }

       
        #取得預設的鎖附資料
        $info_arr = "";
        $info = $this->Historicals_newModel->monitors_info($info_arr,$offset, $limit);

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();

        #人員權限列表
        $all_roles = $this->UserModel->GetAllRole();
        $all_roles = array_slice($all_roles,0,3);
    
        #鎖附結果
        $res_status_arr = array('ALL','OK','OKALL','NG');
      
        #Controller 分類
        $res_controller_arr = array('GTCS','TCG');

        #program 分類
        $res_program = array('P1','P2','P3','P4');

        #扭力轉換
        $torque_arr = $this->Historicals_newModel->torque_change();


        #取得還存在的job_id 
        $job_arr    = $this->Historicals_newModel->get_job_id();

        #STATUS轉換
        $status_arr = $this->Historicals_newModel->status_code_change();

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'all_roles' => $all_roles,
            'res_status_arr' =>  $res_status_arr,
            'res_controller_arr' => $res_controller_arr,
            'res_program' => $res_program,
            'info' => $info,
            'totalPages' => $totalPages,
            'nopage' =>$nopage,
            'page' => $page,
            'torque_arr' => $torque_arr,
            'status_arr' => $status_arr,
            'job_arr' =>$job_arr
        ];

        $data['path'] = __FUNCTION__;

        $this->view('historicals/index', $data);
    }

    #隱藏鎖附資料
    public function del_info(){

        $del_info_sn_arr = array();
        $del_info_sn = $_POST['values'];
        $res = $this->Historicals_newModel->del_info($del_info_sn);
        return $res;
    }


    #搜尋資料
    public function search_info_list(){

        $info_arr = array();
        $info_arr = $_POST;

        $offset = 0;
        $limit  = 10000;
        #按照POST的資訊 取得資料庫搜尋的結果
        $info = $this->Historicals_newModel->monitors_info($info_arr,$offset,$limit);

        #扭力轉換
        $torque_arr = $this->Historicals_newModel->torque_change();

        #STATUS轉換
        $status_arr = $this->Historicals_newModel->status_code_change();


        if(!empty($info)){
            $info_data ="";
            foreach($info as $k =>$v){
                $color = $status_arr['status_color'][$v['fasten_status']];
                $style = 'background-color:'.$color.';font-size: 20px';

                $info_data  = "<tr>";
                $info_data .= '<td style="text-align: center;"><input class="form-check-input" type="checkbox" name="test1" id="test1"  value="'.$v['system_sn'].'" style="zoom:1.2;vertical-align: middle;"></td>';
                $info_data .= "<td id='system_sn'>".$v['system_sn']."</td>";
                $info_data .= "<td>".$v['data_time']."</td>";
                $info_data .= "<td></td>";
                $info_data .= "<td>".$v['cc_barcodesn']."</td>";
                $info_data .= "<td>".$v['job_name']."</td>";
                $info_data .= "<td>".$v['sequence_name']."</td>";
                $info_data .= "<td>".$v['cc_task_name']."</td>";
                $info_data .= "<td></td>";
                $info_data .= "<td>".$v['step_lowtorque']." ~ ".$v['step_hightorque']."</td>";
                $info_data .= "<td>".$v['step_lowangle']." ~ ".$v['step_highangle']."</td>";
                $info_data .= "<td>".$v['fasten_torque'] .$torque_arr[$v['torque_unit']]."</td>";
                $info_data .= "<td>".$v['fasten_angle']." deg </td>";
                $info_data .= "<td style='".$style."'>". $status_arr['status_type'][$v['fasten_status']]."</td>";
                $info_data .= "<td>".$status_arr['error_msg'][$v['error_message']]."</td>";
                $info_data .= "<td></td>";
                $info_data .= '<td><img src="./img/info-30.png" alt="" style="height: 28px; vertical-align: middle;" onclick="NextToInfo()"></td>';
        
                $info_data .="</tr>";
                echo $info_data;
            }  
        }else{  
            # 查無資料
            $response = '';
            echo $response;
            
        }
    
    }

    #產生CSV的文件 
    #利用system_sn 取得完整的鎖附資料
    public function csv_downland(){
        if(!empty($_COOKIE['systemSnval'])){
            $system_sn = $_COOKIE['systemSnval'];
            if($system_sn != 'total'){
                $pos = strpos($system_sn, ',');

                if ($pos !== false) {
                    $system_sn_array = explode(",", $system_sn);
                    $system_sn_in = implode("','", $system_sn_array);
                
                }else{
                    $system_sn_in = $system_sn;
                }
            }else{
                $system_sn_in = 'total';
            }
           
            #取得該筆的所有完整詳細資料
            $info_final = $this->Historicals_newModel->csv_info($system_sn_in);
            $newKeys = range(0, 48); 

            #扭力轉換 
            $torque_change = $this->Historicals_newModel->torque_change();

            #狀態轉換 
            $status_arr = $this->Historicals_newModel->status_code_change();

            //整理陣列 
            foreach($info_final as $kk =>$vv){
                $info_final[$kk]['torque_unit']  = $torque_change[$vv['torque_unit']];
                $info_final[$kk]['fasten_status']  = $status_arr['status_type'][$vv['fasten_status']];
            }

            #CSV檔名
            $filename = 'data.csv';
            $file = fopen($filename, 'w');
            fputcsv($file,  array('cc_barcodesn','cc_station','cc_job_id','cc_seq_id','cc_task_id','cc_equipment','cc_operator','system_sn','data_time','device_type','device_id','device_sn','tool_type','tool_sn','tool_status','job_id','job_name','sequence_id','sequence_name','step_id','fasten_torque','torque_unit','fasten_time','fasten_angle','count_direction','last_screw_count','max_screw_count','fasten_status','error_message','step_targettype','step_tooldirection','step_rpm','step_targettorque','step_hightorque','step_lowtorque','step_targetangle','step_highangle','step_lowangle','step_delayttime','threshold_torque','step_threshold_angle','downshift_torque','downshift_speed','step_prr_rpm','step_prr_angle','barcode','total_angle','on_flag','cc_task_name'));
            foreach ($info_final as $row) {
                fputcsv($file, $row);
            }
            fclose($file);
            header('Content-Type: text/csv');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
            readfile($filename);

            unlink($filename);

        }     
    }

     #鎖附資料 圖表 
     public function history_result(){
        
        $data = array();
        $status_arr = $this->Historicals_newModel->status_code_change();
        $mode_arr = array('ng_reason','fastening_status','job_info','statistics');

        #NG REASON 

        foreach($mode_arr as $key =>$val){

            if($val =="ng_reason"){
                $ng_reason_temp = $this->Historicals_newModel->for_api_test($val);
                if(!empty($ng_reason_temp)){

                    foreach($ng_reason_temp as $key1 =>$val1){
                        $ng_reason_temp[$key1]['error_msg_name'] = $status_arr['error_msg'][$val1['error_message']];
                    }
        
                    $ng_reason = array();
                    foreach ($ng_reason_temp as $item) {
                        $ng_reason[] = array('value' => $item['total'], 'name' => $item['error_msg_name']);
                    }
                    $data['ng_reason_json'] = json_encode($ng_reason);
                }
            }

            if($val =="fastening_status"){
                $fastening_status_temp = $this->Historicals_newModel->for_api_test($val); 
                if(!empty($fastening_status_temp)){
                    foreach($fastening_status_temp as $key2 =>$val2){
                        $fastening_status_temp[$key2]['status_type'] = $status_arr['status_type'][$val2['fasten_status']];
                    }

                    $fastening_status = array();
                    foreach ($fastening_status_temp as $item1) {
                        $fastening_status[] = array('value' => $item1['total'], 'name' => $item1['status_type']);
                    }
                

                    $data['fastening_status'] = json_encode($fastening_status);
                }
                
            }

            if($val=="job_info"){
                $job_info_temp = $this->Historicals_newModel->for_api_test($val); 
                if(!empty($job_info_temp)){
                    $job_info = array();
                    $job_info = array_slice($job_info_temp,0,6);
                    
                    #柱狀圖
                    $job_names = array();
                    $fasten_time = array();
                    foreach ($job_info as $item) {
                        $job_names[] = $item['job_name'];
                        $fasten_time[] = $item['fasten_time'];
                    }
                    $job_name_json = json_encode($job_names);
                    $fasten_time_json = json_encode($fasten_time);
                    $data['job_info']['job_name'] = $job_name_json;
                    $data['job_info']['fasten_time'] =$fasten_time_json;


                    #圓餅圖
                    $job_time = array();
                    $job_time_temp = $this->Historicals_newModel->for_api_test('job_time'); 
                    foreach($job_time_temp as $k_time =>$v_time){
                        $job_time[] = array('value' => $v_time['duplicate_count'], 'name' => "JOB-".$v_time['job_id']); 
                    } 
                    $data['job_time_json'] = json_encode($job_time);
                }
            }

            if($val =="statistics"){

                $start_date = date('Y-m-d', strtotime('-7 days'));
                $end_date = date('Y-m-d');

                $date_array = array();
                for ($date = strtotime($start_date); $date <= strtotime($end_date); $date = strtotime('+1 day', $date)) {
                    $formatted_date = date('Ymd', $date);
                    $date_array[$formatted_date] = null;
                }
                $combined_statistics = [];
                #OK
                $statistics_ok_temp = $this->Historicals_newModel->for_api_test('statistics_ok'); 
                if(!empty($statistics_ok_temp)){
                    foreach($statistics_ok_temp  as $kk1 =>$vv1){
                        unset($statistics_ok_temp[$kk1]);
                        $statistics_ok_temp[$vv1['date']] = $vv1;
                        $statistics_ok_temp[$vv1['date']]['ok_count']=$vv1['status_count'];
                    }
                }

                #NG
                $statistics_ng_temp = $this->Historicals_newModel->for_api_test('statistics_ng'); 
                if(!empty($statistics_ng_temp)){
                    foreach($statistics_ng_temp as $kk =>$vv){
                        unset($statistics_ng_temp[$kk]);
                        $statistics_ng_temp[$vv['date']] = $vv;
                        $statistics_ng_temp[$vv['date']]['ng_count'] = $vv['status_count'];
                    }
                }

                #OKALL 
                $statistics_okall_temp = $this->Historicals_newModel->for_api_test('statistics_okall'); 
                if(!empty($statistics_okall_temp)){
                    foreach($statistics_okall_temp as $kk2 =>$vv2){
                        unset($statistics_okall_temp[$kk2]);
                        $statistics_okall_temp[$vv2['date']] = $vv2;
                        $statistics_okall_temp[$vv2['date']]['ok_all_count']=$vv2['status_count'];    
                    }
                }     
             
                $type_arr  = $statistics_ok_temp + $statistics_ng_temp + $statistics_okall_temp;
                if(!empty($type_arr)){
                    foreach($type_arr as $kd =>$vd){
                        foreach($statistics_okall_temp as $kd1 =>$vd1)
                        {
                            if($kd1 == $kd){
                                $type_arr[$kd]['ok_all_count'] = $vd1['ok_all_count'];
                            }
                        }

                        if(empty($vd['ng_count'])){
                            $type_arr[$kd]['ng_count'] = 0;
                        }
                        if(empty($vd['ok_count'])){
                            $type_arr[$kd]['ok_count'] = 0;
                        }  
                        
                        unset($type_arr[$kd]['fasten_status']);
                        unset($type_arr[$kd]['status_count']);
               
                    } 

                    foreach($type_arr as $kw =>$vw){
                        if(empty($vw['ok_all_count'])){
                            $type_arr[$kw]['ok_all_count'] = 0;
                        }
                    }
                }
                

                #陣列合併
                foreach($date_array as $ke1 =>$ve1){
                    foreach($type_arr as $ke2 =>$ve2){
                        if($ke1 == $ke2){
                            $date_array[$ke1]=$ve2;
                            unset($date_array[$ke1]['date']); 
                        }
                    }
                }

                foreach($date_array as $k3 =>$v3){
                     if(empty($v3['ng_count'])){
                        $date_array[$k3]['ng_count'] = 0;
                        $ng_counts[] = 0; 
                     }else{
                        $ng_counts[] = $v3['ng_count'];
                     }

                     if(empty($v3['ok_count'])){
                        $date_array[$k3]['ok_count'] = 0;
                        $ok_counts[] = 0;
                     }else{
                        $ok_counts[] = $v3['ok_count'];
                     }

                     if(empty($v3['ok_all_count'])){
                        $date_array[$k3]['ok_all_count'] = 0;
                        $ok_all_counts[] = 0;
                     }else{
                        $ok_all_counts[] = $v3['ok_all_count'];
                     }
                }
                $ng_counts = array_map('intval', $ng_counts);
                $ok_counts = array_map('intval', $ok_counts);
                $ok_all_counts = array_map('intval', $ok_all_counts);
                $data['statistics']['date'] = json_encode(array_keys($date_array));
                $data['statistics']['ng'] = json_encode($ng_counts);
                $data['statistics']['ok'] = json_encode($ok_counts);
                $data['statistics']['ok_all'] = json_encode($ok_all_counts);
            }
        }


        if(!empty($_GET['type'])){
            if($_GET['type'] =="download"){
                $data['type'] = "download";
            }

        }else{
            $data['type'] = '';
        }
        

        #取出 各種的NG狀態
        $this->view('historicals/index_report_history',$data);
    }


 


    public function test_chart(){
        $chat_mode  = "6";
        $data = array();

        $no = "4145";
        $csvdata_arr   = $this->Historicals_newModel->get_info($no,$chat_mode);
        $values = array_values($csvdata_arr['torque']);
              
        $data['chart_info']['x_val']  = json_encode(array_keys($csvdata_arr['torque'])); #X軸
        $data['chart_info']['y_val'] = json_encode($csvdata_arr['torque']); #Y軸 torque
        $data['chart_info']['y_val_1'] = json_encode($csvdata_arr['angle']); #Y軸 angle
        $data['chart_info']['max']   = max($csvdata_arr['torque']);
        $data['chart_info']['min']   = min($csvdata_arr['torque']);
        $data['chart_info']['max1']   = max($csvdata_arr['angle']);
        $data['chart_info']['min1']   = min($csvdata_arr['angle']);

       
        //$this->view('historicals/index_test3');
    }

    public function nextinfo($index){
        
        if(!empty($index)){
            $data = array();

            $data['job_info'] = $this->Historicals_newModel->get_info_data($index);
            #判斷 有無cookie chat_mode 
            if(isset($_COOKIE['chat_mode_change'])) {
                $chat_mode = $_COOKIE['chat_mode_change'];
            }else{
                $chat_mode = "1";
            }


            if(!empty($_GET['unitvalue'])){
                $unitvalue = $_GET['unitvalue'];
            }else{
                $data['job_info'][0]['torque_unit'] = (int)$data['job_info'][0]['torque_unit'];
                $unitvalue =  $data['job_info'][0]['torque_unit'];

            }

            if(!empty($_GET['anglevalue'])){
                $data['anglevalue'] = $_GET['anglevalue'];
            }else{
                $data['anglevalue'] = "";
            }

            $data['unitvalue'] = $unitvalue;
          
            #取得曲線圖的模式
            $chat_arr = $this->Historicals_newModel->chat_change($chat_mode);
            $data['chat'] = $chat_arr;
            $no = "0533";
            $csvdata_arr   = $this->Historicals_newModel->get_info($no,$chat_mode);//取得 完整的資料
            $status_arr = $this->Historicals_newModel->status_code_change();

            $chat_mode_arr = array(
                1=>'Torque/Time(MS)',
                2=>'Angle/Time(MS)',
                3=>'RPM/Time(MS)',
                4=>'Power/Time(MS)',
                5=>'Torque/Angle',
                6=>'Torque&Angle/Time(MS)',
            );

            $torque_mode_arr = array(
                1=>'N.m',
                0=>'Kgf.m',
                2=>'Kgf.cm',
                3=>'In.lbs',

            );

            $angle_mode_arr = array(
                1 =>'total angle',
                2 =>'task angle'
            );

            if($chat_mode =="5"){

                #X=>Angle Y=>Torque
                if(!empty($csvdata_arr['angle'])){
                    $data['chart_info']['x_val'] = json_encode($csvdata_arr['angle']);
                    $data['chart_info']['y_val'] = json_encode($csvdata_arr['torque']);
                    $data['chart_info']['max']   = max($csvdata_arr['torque']);
                    $data['chart_info']['min']   = min($csvdata_arr['torque']);
                    
                }
            }elseif($chat_mode =="6"){
                #X=>time Y=>torque && angle
            
                $data['chart_info']['x_val']  = json_encode(array_keys($csvdata_arr['torque'])); #X軸
                $data['chart_info']['y_val'] = json_encode($csvdata_arr['torque']); #Y軸 torque
                $data['chart_info']['y_val_1'] = json_encode($csvdata_arr['angle']); #Y軸 angle
                $data['chart_info']['max']   = max($csvdata_arr['torque']);
                $data['chart_info']['min']   = min($csvdata_arr['torque']);
                $data['chart_info']['max1']   = max($csvdata_arr['angle']);
                $data['chart_info']['min1']   = min($csvdata_arr['angle']);

            }else{

                #圖表相關資料
                if(($chat_mode == "1" || $chat_mode == "3" || $chat_mode == "4" ) && $unitvalue !="1"){
                    //針對Y軸的value 進行轉換
                    $TransType = $unitvalue;
                    $torValues = $csvdata_arr;
                    $temp_val = $this->Historicals_newModel->unitarr_change($torValues, 1, $TransType);
                    $data['chart_info']['y_val'] = json_encode($temp_val);
                    $data['chart_info']['max']   = max($temp_val);
                    $data['chart_info']['min']   = min($temp_val);
            
                }else{
                    $data['chart_info']['y_val'] = json_encode($csvdata_arr);
                    $data['chart_info']['max']   = max($csvdata_arr);
                    $data['chart_info']['min']   = min($csvdata_arr);

                }

                $data['chart_info']['x_val'] = json_encode(array_keys($csvdata_arr));

            }
               
            $line_title = $chat_mode_arr[$chat_mode];
            $line_title_arr = explode("/",$chat_mode_arr[$chat_mode]);
 
            $data['chat_mode_arr'] = $chat_mode_arr;
            $data['torque_mode_arr'] = $torque_mode_arr;
            $data['status_arr'] = $status_arr;
            $data['now_chattype'] = $data['chat_mode_arr'][$chat_mode];

            $line_title = $chat_mode_arr[$chat_mode];
            $line_title_arr = explode("/",$chat_mode_arr[$chat_mode]);
            if(!empty($line_title)){
                $line_title_arr = explode("/",$chat_mode_arr[$chat_mode]);
                $data['chart_info']['x_title'] = $line_title_arr[1];
                $data['chart_info']['y_title'] = $line_title_arr[0];
                $data['chart_info']['chat_mode'] = $chat_mode;
            }
            $data['nav'] = $this->NavsController->get_nav();
            $data['nopage'] = 0;
            $data['path'] = __FUNCTION__;
            $data['angle_mode_arr'] = $angle_mode_arr;

            $this->view('historicals/index', $data);
        }
    }

    #利用job_id 及 seq_id 找到對應的task_id 
    #並組成 html的checkbox 格式
    public function get_correspond_val(){
        $val  = array();
        #取得對應的seq_id
        if(!empty($_POST['job_id'][0])  && empty($_POST['seq_id'][0])){
            $job_id = $_POST['job_id'][0];
            $info_seq = $this->Historicals_newModel->get_seq_id($job_id);

            #組checkbox的html_code(seq)
            if(!empty($info_seq)){
                $info_seq_detailed = ''; 
                foreach($info_seq  as $k_seq =>$v_seq){
                    $info_seq_detailed  = '<div class="row t1">';
                    $info_seq_detailed .= '<div class="col t5 form-check form-check-inline">';
                    $info_seq_detailed .= '<input class="form-check-input" type="checkbox" name="seqid" id="seqid" value='.$v_seq['sequence_id'].'   onclick="JobCheckbox_seq()"  style="zoom:1.0; vertical-align: middle;">&nbsp;';
                    $info_seq_detailed .= '<label class="form-check-label" for="">'.$v_seq['sequence_name'].'</label>';
                    $info_seq_detailed .= '</div>';
                    $info_seq_detailed .= '</div>';
                    echo $info_seq_detailed;
                }   

            }
        }

        #透過job_id 及 seq_id 取得對應的task_id
        if(!empty($_POST['seq_id'][0]) && !empty($_POST['job_id'][0])){
            $job_id = $_POST['job_id'][0];
            $seq_id = $_POST['seq_id'][0];
            $info_task = $this->Historicals_newModel->get_task_id($job_id,$seq_id);

            #組checkbox的html_code(task)
            if(!empty($info_task)){
                $info_task_detailed = ''; 
                foreach($info_task  as $k_task => $v_task){
                    $info_task_detailed  = '<div class="row t1">';
                    $info_task_detailed .= '<div class="col t5 form-check form-check-inline">';
                    $info_task_detailed .= '<input class="form-check-input" type="checkbox" name="taskid" id="taskid" value='.$v_task['cc_task_id'].'   onclick="JobCheckbox_task()"  style="zoom:1.0; vertical-align: middle;">&nbsp;';
                    $info_task_detailed .= '<label class="form-check-label" for="">'.$v_task['cc_task_name'].'</label>';
                    $info_task_detailed .= '</div>';
                    $info_task_detailed .= '</div>';
                    echo $info_task_detailed;
                }
            }

        }
    }


    public function combinedata(){

        #取得下拉式選單的chart
        if(!empty($_GET['chart'])){
            $data['chat_mode']= $_GET['chart'];

        }else{
            $data['chat_mode']  = 1;
        }


        
        #取得下拉選單的unit
        if(!empty($_GET['unit'])) {
            $data['unit'] = $_GET['unit'];
        }else{
            $data['unit'] = 1;
        }
        $TransType = $data['unit'];

        # 透過cookie 取得已被勾選的id
        if(!empty($_COOKIE['checkedsn'])){
            $checkedsn = $_COOKIE['checkedsn'];
            $pos = strpos($checkedsn, ',');

            if ($pos !== false) {
                $checkedsn_array = explode(",",$checkedsn);
                $checked_sn_in = implode("','", $checkedsn_array);
                
            }else{
                $checked_sn_in =  $checkedsn;
            }

            #取得該筆的所有完整詳細資料
            $info_final = $this->Historicals_newModel->csv_info($checked_sn_in);  

            $data['info_final'] = $info_final;

            #取得曲線圖的ID
            $id = '';
            foreach($info_final as $kk =>$vv){
                $id.= sprintf("%04d", $vv['id']).",";
                
            }
            $id = rtrim($id,',');
            #二筆鎖附資料的圖表
            $final_label = $this->Historicals_newModel->get_result($checked_sn_in,$id,$data['chat_mode']);
            if(empty($final_label)){
                #找不到對應的圖檔時 回到Historicals搜尋頁面
                echo '<script>alert("not found");</script>';
                header('Location:?url=Historicals');
                exit;
            }

    

            #判斷是否需要進行單位轉換
            $temp_val0 = (!empty($TransType)) ? $this->Historicals_newModel->unitarr_change($final_label['data0'], 1, $data['unit']) : $final_label['data0'];
            $temp_val1 = (!empty($TransType)) ? $this->Historicals_newModel->unitarr_change($final_label['data1'], 1, $data['unit']) : $final_label['data1'];


            #圖表1的資訊
            $data['chart1_xcoordinate'] = json_encode(array_keys($final_label['data0']));
            $data['chart1_ycoordinate'] = json_encode($temp_val0);
            $data['chart1_ycoordinate_max'] = floatval(max($temp_val0));
            $data['chart1_ycoordinate_min'] = floatval(min($temp_val0));

    
            #圖表2的資訊
            $data['chart2_xcoordinate'] = json_encode(array_keys($final_label['data1']));
            $data['chart2_ycoordinate'] = json_encode($temp_val1);
            $data['chart2_ycoordinate_max'] = floatval(max($temp_val1));
            $data['chart2_ycoordinate_min'] = floatval(min($temp_val1));


            #設定曲線圖座標名稱
            $chat_mode_arr = $this->Historicals_newModel->details('chart_type');

            $data['chat_mode'] = (int)$data['chat_mode'];
            $line_title = $chat_mode_arr[$data['chat_mode'] ];
            $line_title_arr = explode("/",$chat_mode_arr[$data['chat_mode']]);

            $data['chart_combine']['x_title'] = $line_title_arr[1];
            $data['chart_combine']['y_title'] = $line_title_arr[0];

            #取得目前的扭力單位
            $torque_mode_arr = $this->Historicals_newModel->details('torque');

            #STATUS轉換
            $status_arr = $this->Historicals_newModel->status_code_change();
        
        }
       
        $data['status_arr'] = $status_arr;
        $data['torque_mode_arr'] = $torque_mode_arr;
        $data['chat_mode_arr_combine'] = $chat_mode_arr;
        $data['nav'] = $this->NavsController->get_nav();
        $data['nopage'] = 0;
        $data['path'] = __FUNCTION__;

        $this->view('historicals/index',$data);
    }
}