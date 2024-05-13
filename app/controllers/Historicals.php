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

    public function index($page)
    {
        $nopage = isset($_COOKIE["nopage"]) ? $_COOKIE["nopage"] : "0";
        $limit = 30;
        $offset = 0;
        $totalPages = 0;

        if($nopage == "1") {
            $page = isset($_GET['p']) ? $_GET['p'] : 1;
            $offset = ($page - 1) * $limit;
            $totalItems = $this->Historicals_newModel->getTotalItemCount();

            if (!empty($totalItems)) {
                $totalPages = ceil($totalItems / $limit);
            }
        }

        #資料取得
        $info = $this->getMonitorsInfo($nopage, $offset, $limit);
        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();
        $all_roles = array_slice($this->UserModel->GetAllRole(), 0, 3);
        $res_status_arr = ['ALL', 'OK', 'OKALL', 'NG'];
        $res_controller_arr = ['GTCS', 'TCG'];
        $res_program = ['P1', 'P2', 'P3', 'P4'];
        $torque_arr = $this->Historicals_newModel->details('torque');

        #取得所有的job_id
        $job_arr = $this->Historicals_newModel->get_job_id();
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
            'nopage' => $nopage,
            'page' => $page,
            'torque_arr' => $torque_arr,
            'status_arr' => $status_arr,
            'job_arr' => $job_arr,
            'path' => __FUNCTION__
        ];

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
        $torque_arr = $this->Historicals_newModel->details('torque');

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
            $torque_change = $this->Historicals_newModel->details('torque');

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
        $mode_arr = array('ng_reason','fastening_status','job_info','statistics','bk');

        #NG REASON 
        foreach($mode_arr as $key =>$val){
            
            if($val =="ng_reason"){
                $ng_reason_temp = $this->Historicals_newModel->for_history($val);
                if(!empty($ng_reason_temp)){
                    $ng_reason = $this->processNgReasonData($ng_reason_temp, $status_arr);
                    $data['ng_reason_json'] = json_encode($ng_reason);
                }
            }

            if($val =="fastening_status"){
                $fastening_status_temp = $this->Historicals_newModel->for_history($val); 
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
                $job_info_temp = $this->Historicals_newModel->for_history($val); 
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
                    $job_time_temp = $this->Historicals_newModel->for_history('job_time'); 
                    foreach($job_time_temp as $k_time =>$v_time){
                        $job_time[] = array('value' => $v_time['duplicate_count'], 'name' => "JOB-".$v_time['job_id']); 
                    } 
                    $data['job_time_json'] = json_encode($job_time);
                }
            }

            if($val =="statistics"){

                $start_date = date('Y-m-d', strtotime('-7 days'));
                $end_date = date('Y-m-d');

                // 初始化日期陣列
                $date_array = [];
                for ($date = strtotime($start_date); $date <= strtotime($end_date); $date = strtotime('+1 day', $date)) {
                    $formatted_date = date('Ymd', $date);
                    $date_array[$formatted_date] = [
                        'ng_count' => 0,
                        'ok_count' => 0,
                        'ok_all_count' => 0
                    ];
                }


                #OK
                $statistics_ok_temp = $this->Historicals_newModel->for_history('statistics_ok'); 
                if(!empty($statistics_ok_temp)){
                    foreach($statistics_ok_temp  as $kk1 =>$vv1){
                        unset($statistics_ok_temp[$kk1]);
                        $statistics_ok_temp[$vv1['date']] = $vv1;
                        $statistics_ok_temp[$vv1['date']]['ok_count']=$vv1['status_count'];
                    }
                }

                #NG
                $statistics_ng_temp = $this->Historicals_newModel->for_history('statistics_ng'); 
                if(!empty($statistics_ng_temp)){
                    foreach($statistics_ng_temp as $kk =>$vv){
                        unset($statistics_ng_temp[$kk]);
                        $statistics_ng_temp[$vv['date']] = $vv;
                        $statistics_ng_temp[$vv['date']]['ng_count'] = $vv['status_count'];
                    }
                }

                #OKALL 
                $statistics_okall_temp = $this->Historicals_newModel->for_history('statistics_okall'); 
                if(!empty($statistics_okall_temp)){
                    foreach($statistics_okall_temp as $kk2 =>$vv2){
                        unset($statistics_okall_temp[$kk2]);
                        $statistics_okall_temp[$vv2['date']] = $vv2;
                        $statistics_okall_temp[$vv2['date']]['ok_all_count']=$vv2['status_count'];    
                    }
                }     
             
                $type_arr  = $statistics_ok_temp + $statistics_ng_temp + $statistics_okall_temp;
                if (!empty($type_arr)) {
                    foreach ($type_arr as $kd => &$vd) {

                        $vd['ok_all_count'] = $statistics_okall_temp[$kd]['ok_all_count'] ?? 0;
                        $vd['ng_count'] = $vd['ng_count'] ?? 0;
                        $vd['ok_count'] = $vd['ok_count'] ?? 0;
                        unset($vd['fasten_status']);
                        unset($vd['status_count']);
                    }
                
                    foreach ($type_arr as &$vd) {
                        if (!isset($vd['ok_all_count'])) {
                            $vd['ok_all_count'] = 0;
                        }
                    }
                }
                
                #陣列合併
                foreach ($date_array as $ke1 => &$ve1) {
                    foreach ($type_arr as $ke2 => $ve2) {
                        if ($ke1 == $ke2) {
                            $ve1 = array_merge($ve1, $ve2);
                            unset($ve1['date']); 
                        }
                    }
                    $ng_counts[] = isset($ve1['ng_count']) ? $ve1['ng_count'] : 0;
                    $ok_counts[] = isset($ve1['ok_count']) ? $ve1['ok_count'] : 0;
                    $ok_all_counts[] = isset($ve1['ok_all_count']) ? $ve1['ok_all_count'] : 0;
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
        
        $this->view('historicals/index_report_history',$data);
    }


    public function nextinfo($index) {

        if(!empty($index)) {
            $data = array();
    
            #取得詳細資料
            $data['job_info'] = $this->Historicals_newModel->get_info_data($index);

    
            #檢查chat_mode cookie
            $chat_mode = isset($_COOKIE['chat_mode_change']) ? $_COOKIE['chat_mode_change'] : "1";
    
            #取得unitvalue
            $unitvalue = isset($_GET['unitvalue']) ? $_GET['unitvalue'] : $data['job_info'][0]['torque_unit'];
    
            $data['unitvalue'] = $unitvalue;
    
            #曲線圖模式
            $chat_mode_arr = $this->Historicals_newModel->details('chart_type');
            $data['chat_mode_arr'] = $chat_mode_arr;
    
            #取得圖表模式
            $chat_arr = $this->Historicals_newModel->chat_change($chat_mode);
            $data['chat'] = $chat_arr;
    
            #取得完整的資料
            $length = strlen($data['job_info'][0]['id']);
            if ($length < 4) {
                $no = sprintf("%04d", $data['job_info'][0]['id']);
            } else {
                $no = $data['job_info'][0]['id'];
            }


            

            $csvdata_arr = $this->Historicals_newModel->get_info($no, $chat_mode);

            if(!empty($csvdata_arr)){
                $data['chart_info'] = $this->ChartData($chat_mode, $csvdata_arr, $unitvalue, $chat_mode_arr);
                #設定曲線圖的座標名稱
                $titles = $this->Historicals_newModel->extractXYTitles($data['chart_info']['chat_title']);
                $data['chart_info']['x_title'] = $titles['x_title'];
                $data['chart_info']['y_title'] = $titles['y_title'];
                $data['chart_info']['chat_mode'] = $chat_mode;
            }

             
            #狀態列表
            $status_arr = $this->Historicals_newModel->status_code_change();
            $data['status_arr'] = $status_arr;

            $torque_mode_arr = $this->Historicals_newModel->details('torque');
            $data['torque_mode_arr'] = $torque_mode_arr;
        
            $data['nav'] = $this->NavsController->get_nav();
            $data['nopage'] = 0;
            $data['path'] = __FUNCTION__;
    
            $this->view('historicals/index', $data);
        }
    }

    #利用job_id 及 seq_id 找到對應的task_id 
    #並組成 html的checkbox 格式
    public function get_correspond_val(){
        $val  = array();
    
        // 檢查 $_POST['job_id'] 和 $_POST['seq_id'] 是否存在且不為空
        if(isset($_POST['job_id'][0]) && !empty($_POST['job_id'][0])) {
            $job_id = $_POST['job_id'][0];
    
            // 取得對應的seq_id
            if(empty($_POST['seq_id'][0])) {
                $info_seq = $this->Historicals_newModel->get_seq_id($job_id);
    
                // 組checkbox的html_code(seq)
                if(!empty($info_seq)){
                    foreach($info_seq as $k_seq => $v_seq){
                        echo $this->generateCheckboxHtml($v_seq['sequence_id'], $v_seq['sequence_name'], 'seqid', 'JobCheckbox_seq');
                    }
                }
            }
    
            // 透過job_id 及 seq_id 取得對應的task_id
            if(isset($_POST['seq_id'][0]) && !empty($_POST['seq_id'][0])) {
                $seq_id = $_POST['seq_id'][0];
                $info_task = $this->Historicals_newModel->get_task_id($job_id, $seq_id);
    
                // 組checkbox的html_code(task)
                if(!empty($info_task)){
                    foreach($info_task as $k_task => $v_task){
                        echo $this->generateCheckboxHtml($v_task['cc_task_id'], $v_task['cc_task_name'], 'taskid', 'JobCheckbox_task');
                    }
                }
            }
        }
    }

    
    private function generateCheckboxHtml($value, $label, $name, $onClickFunction) {
        $checkbox_html = '<div class="row t1">';
        $checkbox_html .= '<div class="col t5 form-check form-check-inline">';
        $checkbox_html .= '<input class="form-check-input" type="checkbox" name="' . $name . '" id="' . $name . '" value="' . $value . '" onclick="' . $onClickFunction . '()" style="zoom:1.0; vertical-align: middle;">&nbsp;';
        $checkbox_html .= '<label class="form-check-label" for="">' . $label . '</label>';
        $checkbox_html .= '</div>';
        $checkbox_html .= '</div>';
        return $checkbox_html;
    }


    public function combinedata(){

        #取得下拉式選單的 chart
        $data['chat_mode'] = !empty($_GET['chart']) ? $_GET['chart'] : 1;

        #取得下拉選單的 unit
        $data['unit'] = !empty($_GET['unit']) ? $_GET['unit'] : 1;

        #設置 TransType
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
            
            #整理曲線圖的資料
            if($data['chat_mode'] == 5) {
             
                $x_coordinate_key_data0 = array_keys($final_label['data0']['angle']);
                $x_coordinate_key_data1 = array_keys($final_label['data1']['angle']);
                $data['chart1_xcoordinate'] = json_encode($x_coordinate_key_data0);
                $data['chart2_xcoordinate'] = json_encode($x_coordinate_key_data1);
            
                $final_label['data0'] = $final_label['data0']['torque'];
                $final_label['data1'] = $final_label['data1']['torque'];

            }else if($data['chat_mode'] == 6){

                $data['chart1_xcoordinate'] = json_encode(array_keys($final_label['data0']));
                $data['chart2_xcoordinate'] = json_encode(array_keys($final_label['data1']));

            
                $data0_torque = $final_label['data0']['torque'];
                $data1_torque = $final_label['data1']['torque'];

                $data0_angle = $final_label['data0']['angle'];
                $data1_angle = $final_label['data1']['angle'];

                #進行資料轉換
                $temp_val0 = $this->prepareChartData($data0_torque, $TransType, $data['unit']);
                $temp_val1 = $this->prepareChartData($data1_torque, $TransType, $data['unit']);

                #角度資料不需要轉換
                $temp_val0_angle = $this->prepareChartData($data0_angle, '', ''); 
                $temp_val1_angle = $this->prepareChartData($data1_angle, '', ''); 

            }else{
               
                $data['chart1_xcoordinate'] = json_encode(array_keys($final_label['data0']));
                $data['chart2_xcoordinate'] = json_encode(array_keys($final_label['data1']));
            
                #單位轉換只針對torque資料
                $final_label['data0'] = $this->prepareChartData($final_label['data0'], $TransType, $data['unit']);
                $final_label['data1'] = $this->prepareChartData($final_label['data1'], $TransType, $data['unit']);
            }
            
            
            if($data['chat_mode'] == 6){

                $data['chart1_xcoordinate'] = json_encode(array_keys($final_label['data0']));
                $data['chart2_xcoordinate'] = json_encode(array_keys($final_label['data1']));
                $data['chart1_ycoordinate'] = json_encode($temp_val0);
                $data['chart1_ycoordinate_max'] = floatval(max($temp_val0));
                $data['chart1_ycoordinate_min'] = floatval(min($temp_val0));
    
                $data['chart2_ycoordinate'] = json_encode($temp_val1);
                $data['chart2_ycoordinate_max'] = floatval(max($temp_val1));
                $data['chart2_ycoordinate_min'] = floatval(min($temp_val1));
                
                $data['chart1_ycoordinate_angle'] = json_encode($temp_val0_angle);
                $data['chart1_ycoordinate_max_angle'] = floatval(max($temp_val0_angle));
                $data['chart1_ycoordinate_min_angle'] = floatval(min($temp_val0_angle));

                $data['chart2_ycoordinate_angle'] = json_encode($temp_val1_angle);
                $data['chart2_ycoordinate_max_angle'] = floatval(max($temp_val1_angle));
                $data['chart2_ycoordinate_min_angle'] = floatval(min($temp_val1_angle));

            }else{

                $temp_val0 = $this->prepareChartData($final_label['data0'], $TransType, $data['unit']);
                $temp_val1 = $this->prepareChartData($final_label['data1'], $TransType, $data['unit']);


                $data['chart1_ycoordinate'] = json_encode($temp_val0);
                $data['chart1_ycoordinate_max'] = floatval(max($temp_val0));
                $data['chart1_ycoordinate_min'] = floatval(min($temp_val0));
    
                $data['chart2_ycoordinate'] = json_encode($temp_val1);
                $data['chart2_ycoordinate_max'] = floatval(max($temp_val1));
                $data['chart2_ycoordinate_min'] = floatval(min($temp_val1));
            }

    
            #設定曲線圖座標名稱
            $chartTypeDetails = $this->Historicals_newModel->details('chart_type');
            $data['chat_mode'] = (int)$data['chat_mode'];
            $lineTitle = isset($chartTypeDetails[$data['chat_mode']]) ? $chartTypeDetails[$data['chat_mode']] : '';
            $titles = $this->Historicals_newModel->extractXYTitles($lineTitle);
            
            $data['chart_combine']['x_title'] = $titles['x_title'];
            $data['chart_combine']['y_title'] = $titles['y_title'];

            #取得目前的扭力單位
            $torque_mode_arr = $this->Historicals_newModel->details('torque');

            #STATUS轉換
            $status_arr = $this->Historicals_newModel->status_code_change();
        
        }
       
        $data['status_arr'] = $status_arr;
        $data['torque_mode_arr'] = $torque_mode_arr;
        $data['chat_mode_arr_combine'] = $chartTypeDetails ;
        $data['nav'] = $this->NavsController->get_nav();
        $data['nopage'] = 0;
        $data['path'] = __FUNCTION__;

        $this->view('historicals/index',$data);
    }


    function prepareChartData($final_label_data, $TransType, $unit) {
        if (!empty($TransType)) {
            return $this->Historicals_newModel->unitarr_change($final_label_data, 1, $unit);
        } else {
            return $final_label_data;
        }
    }

    private function processNgReasonData($ng_reason_temp, $status_arr) {
        $ng_reason = [];
        foreach ($ng_reason_temp as $item) {
            $error_msg_name = $status_arr['error_msg'][$item['error_message']];
            $ng_reason[] = ['value' => $item['total'], 'name' => $error_msg_name];
        }
        return $ng_reason;
    }


    #search 資料處理
    private function getMonitorsInfo($nopage, $offset, $limit){
        
        if($nopage == '0'){
            $offset = 0;
            $limit = 100000000;
        }

        return $this->Historicals_newModel->monitors_info("", $offset, $limit);
    }

    #nextinfo 整理曲線圖
    private function ChartData($chat_mode, $csvdata_arr, $unitvalue, $chat_mode_arr){
        $data = array();
        
        if($chat_mode == "5"){
    
            if(!empty($csvdata_arr['angle'])){

                $data['x_val'] = json_encode($csvdata_arr['angle']);
                $data['y_val'] = json_encode($csvdata_arr['torque']);
                $data['max'] = max($csvdata_arr['torque']);
                $data['min'] = min($csvdata_arr['torque']);
            }

        }else if($chat_mode == "6"){
     
            $data['x_val'] = json_encode(array_keys($csvdata_arr['torque']));
            $data['y_val'] = json_encode($csvdata_arr['torque']);
            $data['y_val_1'] = json_encode($csvdata_arr['angle']);
            $data['max'] = max($csvdata_arr['torque']);
            $data['min'] = min($csvdata_arr['torque']);
            $data['max1'] = max($csvdata_arr['angle']);
            $data['min1'] = min($csvdata_arr['angle']);

        }else{

            if(($chat_mode == "1" || $chat_mode == "3" || $chat_mode == "4") && $unitvalue != "1"){
            
                $TransType = $unitvalue;
                $torValues = $csvdata_arr;
                $temp_val = $this->Historicals_newModel->unitarr_change($torValues, 1, $TransType);
                $data['y_val'] = json_encode($temp_val);
                $data['max'] = max($temp_val);
                $data['min'] = min($temp_val);

            }else{

                $data['y_val'] = json_encode($csvdata_arr);
                $data['max'] = max($csvdata_arr);
                $data['min'] = min($csvdata_arr);
            }
            $data['x_val'] = json_encode(array_keys($csvdata_arr));
        }
    
        $data['chat_title'] = $chat_mode_arr[(int)$chat_mode] ?? '';
        return $data;
    }
}