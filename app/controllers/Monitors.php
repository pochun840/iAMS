<?php

class Monitors extends Controller
{
    private $DashboardModel;
    private $NavsController;


    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
        $this->NavsController = $this->controller_new('Navs');
        $this->UserModel = $this->model('User');
        $this->Monitors_newModel = $this->model('Monitors_new');
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
            $limit = 2;

            #計算數量
            $offset = ($page - 1) * $limit;

            #取得總筆數
            $totalItems  = "";
            $totalItems  = $this->Monitors_newModel->getTotalItemCount();

            #計算總頁數
            if(!empty($totalItems)){
                $totalPages = ceil($totalItems / $limit);
            }

        }

       
        #取得預設的鎖附資料
        $info_arr = "";
        $info = $this->Monitors_newModel->monitors_info($info_arr,$offset, $limit);

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
        $torque_arr = $this->Monitors_newModel->torque_change();


        #取得還存在的job_id 
        $job_arr    = $this->Monitors_newModel->get_job_id();



        #STATUS轉換
        $status_arr = $this->Monitors_newModel->status_code_change();

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
            
        $this->view('monitor/index', $data);

    }

    public function del_info(){

        $del_info_sn_arr = array();
        $del_info_sn_arr = $_POST['values'];
        $del_info_sn = implode(",",$del_info_sn_arr);

        #如果是複選 則 強制修改內容
        $del_info_sn = str_replace("," ,"','",$del_info_sn);

        #刪除鎖附結果 以 system_sn 當成唯一值
        $res = $this->Monitors_newModel->del_info($del_info_sn);
        return $res;
    }


    public function search_info_list(){

        $info_arr = array();
        $info_arr = $_POST;

        $offset = 0;
        $limit  = 10000;
        #按照POST的資訊 取得資料庫搜尋的結果
        $info = $this->Monitors_newModel->monitors_info($info_arr,$offset,$limit);

        #扭力轉換
        $torque_arr = $this->Monitors_newModel->torque_change();

        #STATUS轉換
        $status_arr = $this->Monitors_newModel->status_code_change();


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

    public function nextinfo($index){
        //透過index 取得相關的資料
        
        if(!empty($index)){
            $info = $this->Monitors_newModel->get_info_data($index);

            $no ="4178";
            $data = array();
            //$csvdata = $this->Monitors_newModel->connected_ftp($no);

            $status_arr = $this->Monitors_newModel->status_code_change();

            #取得完整的CSV資料 
            if(!empty($csvdata)){

                #計算X軸 
                $x_count   = count($csvdata)-1;
                $arr       = range(0, $x_count);
                $arr_count = count($arr);

             
                #曲線圖X軸的節點 
                $x_nodal_point = implode("','", array_keys($csvdata)); 
                $data['x_nodal_point'] = "'".$x_nodal_point."'";

                #判斷 有無cookie chat_mode 
                if (isset($_COOKIE['chat_modeno'])) {
                    $chat_mode = $_COOKIE['chat_modeno'];
                }else{
                    $chat_mode = "1";
                }


            
             
                #取得曲線圖的模式
                $chat_arr = $this->Monitors_newModel->chat_change($chat_mode);
                $data['chat'] = $chat_arr;

                #設置Y軸的最大及最小值
                #要比對的位置

                //如果 position = '5'  Y=>扭力 ,X=>角度

                if(!empty($chat_mode)){
                    if($chat_mode == "5"){
                        $position = 1;
                        foreach ($csvdata as $subarray) {                    
                            $values[] = $subarray[$position];
                        } 
                        $total_range = '';
                        foreach($csvdata as $kk =>$vv){
                            $total_range .= $vv[$position].',';
                        }
                    }else{
                        $values = array();
                        foreach ($csvdata as $subarray) {                    
                            $values[] = $subarray[$chat_arr['position']];
                        } 

                        $total_range = '';
                        foreach($csvdata as $kk =>$vv){
                            $total_range .= $vv[$chat_arr['position']].',';
                        }
                    }

                    #曲線圖的資料
                    $data['total_range'] = $total_range;
        
                    #取得指定位置的值的最大值和最小值
                    $y_maxvalue = max($values);
                    $y_minvalue = min($values);

                     
                    $data['y_maxvalue'] = $y_maxvalue;
                    $data['y_minvalue'] = $y_minvalue;

                }
                
            }

            
            $data['job_info'] = $info;

            $chat_mode_arr = array(
                1=>'Torque/Time',
                2=>'Angle/Time',
                3=>'RPM/Time',
                4=>'Power/Time',
                5=>'Torque/Angle',
                6=>'Torque&Angle/Time',
            );

            $torque_mode_arr = array(
                1=>'N.m',
                2=>'Kgf.m',
                3=>'Kgf.cm',
                4=>'In.lbs',

            );    
            $data['chat_mode_arr'] = $chat_mode_arr;
            $data['torque_mode_arr'] = $torque_mode_arr;
            $data['status_arr'] = $status_arr;

    
            if(!empty($info[0]['step_lowtorque'])){
                setcookie("lowval", $info[0]['step_lowtorque'], time() + (86400 * 30), "/"); 
                setcookie("highval", $info[0]['step_hightorque'], time() + (86400 * 30), "/");
            }

            $data['line_low'] = $info[0]['step_lowtorque'];
            $data['line_high'] = $info[0]['step_hightorque'];
    
            $this->view('monitor/index_info', $data);
        }

    }

    #利用job_id 及 seq_id 找到對應的task_id 
    #並組成 html的checkbox 格式
    public function get_correspond_val(){
        $val  = array();
        #取得對應的seq_id
        if(!empty($_POST['job_id'][0])  && empty($_POST['seq_id'][0])){
            $job_id = $_POST['job_id'][0];
            $info_seq = $this->Monitors_newModel->get_seq_id($job_id);

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
            $info_task = $this->Monitors_newModel->get_task_id($job_id,$seq_id);

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


    public function ddd(){
        $this->view('monitor/index_test');
    }

    
    public function eee(){

        $this->view('monitor/index_test1');
    
    }


    public function combinedata(){
        #取得 id 
        #透過 id 取得完整的鎖附資料


        #判斷有無cookie 


        $chat_mode  = "1";//預設是torque/time 
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
            $info_final = $this->Monitors_newModel->csv_info($checked_sn_in);
            $data['info_final'] = $info_final;


            //Torque/Time
            #取得曲線圖的模式
            $chat_arr = $this->Monitors_newModel->chat_change($chat_mode);
            $data['chat'] = $chat_arr;

            
            #二筆鎖附資料的圖表
            $final_label = $this->Monitors_newModel->get_result($checked_sn_in);



            #圖表1的資訊
            $data['chart1_xcoordinate'] = json_encode(array_keys($final_label['data0']));
            $data['chart1_ycoordinate'] = json_encode($final_label['data0']);
            $data['chart1_ycoordinate_max'] = max($final_label['data0']);
            $data['chart1_ycoordinate_min'] = min($final_label['data0']);


            #圖表2的資訊
            $data['chart2_xcoordinate'] = json_encode(array_keys($final_label['data1']));
            $data['chart2_ycoordinate'] = json_encode($final_label['data1']);
            $data['chart2_ycoordinate_max'] = max($final_label['data1']);
            $data['chart2_ycoordinate_min'] = min($final_label['data1']);
            
       
        }else{
            
        }

        $torque_mode_arr = array(
            1=>'N.m',
            2=>'Kgf.m',
            3=>'Kgf.cm',
            4=>'In.lbs',

        ); 

    
        #扭力轉換
        $torque_arr = $this->Monitors_newModel->torque_change();

        #STATUS轉換
        $status_arr = $this->Monitors_newModel->status_code_change();

        $data['torque_arr'] = $torque_arr;
        $data['status_arr'] = $status_arr;
        $data['torque_mode_arr'] = $torque_mode_arr;

        $this->view('monitor/index',$data);
    }

    #產生CSV的文件 
    #利用system_sn 取得完整的鎖附資料
    public function csv_downland(){
 
        if(!empty($_COOKIE['systemSnval'])){
            $system_sn = $_COOKIE['systemSnval'];
            $pos = strpos($system_sn, ',');

            if ($pos !== false) {
                $system_sn_array = explode(",", $system_sn);
                $system_sn_in = implode("','", $system_sn_array);
            
            }else{
                $system_sn_in = $system_sn;
            }
        
            #取得該筆的所有完整詳細資料
            $info_final = $this->Monitors_newModel->csv_info($system_sn_in);
            $newKeys = range(0, 48); 

            #扭力轉換 
            $torque_change = $this->Monitors_newModel->torque_change();

            #狀態轉換 
            $status_arr = $this->Monitors_newModel->status_code_change();

            //整理陣列 
            foreach($info_final as $kk =>$vv){
                $info_final[$kk]['torque_unit']  = $torque_change[$vv['torque_unit']];
                $info_final[$kk]['fasten_status']  = $status_arr['status_type'][$vv['fasten_status']];
            }

            foreach ($info_final as &$val) {
                $val = array_combine($newKeys, $val); // 使用 array_combine() 函数将新键名数组与原数组合并
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


    public function eeeq()
    {
        $multiArray = array(
            'data0' => array(
                0 => array('10','113','1566','12050'),
                1 => array('110','2113','3566','42050'),
            ),
            'data1' => array(
                20 => array('111','513','1566','12050'),
                60 => array('112','4113','3566','42050'),
            ),
        );
        
        $res = array(); // 用于存储结果的数组
        
        // 迭代多维数组
        foreach ($multiArray as $key => $innerArray) {
            // 初始化临时数组
            $tempArray = array();

           
        
            // 仅检查内部数组的第二个索引位置的值是否在指定数组中，并将其添加到临时数组中
            foreach ($innerArray as $value) {
    
                $tempArray = $value[1];
            }
        
            // 将临时数组添加到结果数组中
            $res[$key][] = $tempArray;
        }
        
        // 输出结果
        echo "<pre>";
        print_r($res);
        echo "</pre>";
        die();

    }

    


}