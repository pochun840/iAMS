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

        if(isset($_POST['value'])){
            $receivedValue = $_POST['value'];
            if( $receivedValue =="nopage"){
                $offset = 0;
                $limit  = 100000000;
                $nopage = True;

            }
        }else{
        //執行分頁
            //當前的頁數，默認為第1頁
            $page = isset($_GET['p']) ? $_GET['p'] : 1;

            //每頁顯示的筆數
            $limit = 30;

            //計算數量
            $offset = ($page - 1) * $limit;

            //取得總筆數
            $totalItems  = "";
            $totalItems  = $this->Monitors_newModel->getTotalItemCount();

            //計算總頁數
            if(!empty($totalItems)){
                $totalPages = ""; 
                $totalPages = ceil($totalItems / $limit);
                $totalPages = 0;
            }

            $nopage = False;
        }
       
        

        #取得預設的鎖附資料前50筆
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


        #按照POST的資訊 取得資料庫搜尋的結果
        $info = $this->Monitors_newModel->monitors_info($info_arr);

        #扭力轉換
        $torque_arr = $this->Monitors_newModel->torque_change();

        #STATUS轉換
        $status_arr = $this->Monitors_newModel->status_code_change();


        if(!empty($info)){
            $info_data ="";
            foreach($info as $k =>$v){
                $info_data  = "<tr>";
                $info_data .= '<td style="text-align: center;"><input class="form-check-input" type="checkbox" name="test1" id="test1"  value="'.$v['system_sn'].'" style="zoom:1.2;vertical-align: middle;"></td>';
                $info_data .= "<td>".$v['system_sn']."</td>";
                $info_data .= "<td>".$v['data_time']."</td>";
                $info_data .= "<td>".$v['cc_barcodesn']."</td>";
                $info_data .= "<td>".$v['job_name']."</td>";
                $info_data .= "<td>".$v['sequence_name']."</td>";
                $info_data .= "<td>".$v['cc_task_name']."</td>";
                $info_data .= "<td>GTCS</td>";
                $info_data .= "<td>".$v['fasten_torque']. $torque_arr[$v['torque_unit']]."</td>";
                $info_data .= "<td>".$v['fasten_angle']." deg  </td>";
                $info_data .= "<td>". $status_arr[$v['fasten_status']]."</td>";
                $info_data .= "<td>".$v['fasten_time']." ms </td>";
                $info_data .= "<td>".$v['fasten_time']." ms </td>";
                $info_data .= "<td>".$v['error_message']."</td>";
                $info_data .= "<td>p1</td>";
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

    public function downland_csv(){

        $body = $_POST['csvData'];

        if(!empty($body)){

            $csv_header = array('Index','Time','BarcodeSN','Job Name','Seq Name','task','Controller','Torque','Total.A','Status','Job time','Task time','Error','Pset');
           
            $body = preg_replace('/<[\/]*tr[^>]*>/i', '', $body);   
            $body = preg_replace('/<[\/]*input[^>]*>/i', '', $body);  
            $body = preg_replace('/<[\/]*img[^>]*>/i', '', $body);
            $body = preg_replace('/<td(\s+style="[^"]*")?\s*>/i', '', $body);
            $body = str_replace("</td></td>","</td>",$body);

            $new_arr = array();
            $new_arr = array(
                            $body_arr[1],
                            $body_arr[2],
                            $body_arr[3],
                            $body_arr[4],
                            $body_arr[5],
                            $body_arr[6],
                            $body_arr[7],
                            $body_arr[8],
                            $body_arr[9],
                            $body_arr[10],
                            $body_arr[11],
                            $body_arr[12],
                            $body_arr[13],
                            $body_arr[14],
                        );
            
            //打開輸出流
            $output = fopen('php://output', 'w');

            fputcsv($output, $csv_header);
            fputcsv($output, $new_arr);

            //直接輸出 CSV 字符串
            echo $output;


        }
    }


    public function nextinfo($index){
        //透過index 取得相關的資料
        
        if(!empty($index)){
            $info = $this->Monitors_newModel->get_info_data($index);


            $no ="4174";
            $data = array();
            $csvdata = $this->Monitors_newModel->connected_ftp($no);

            #取得完整的CSV資料 
            if(!empty($csvdata)){

                #計算X軸 
                $x_count   = count($csvdata)-1;
                $arr       = range(0, $x_count);
                $arr_count = count($arr);

                #取整數
                $interval = ceil($arr_count / 9);
                $final[] = $csvdata[0];
                #計算中間的 x 軸點的值
                for ($i = 1; $i < 10; $i++) {
                    $val = $i * $interval - $i;
                    $final[$i * $interval - $i] = $csvdata[$val];
                }
                $at_last[$x_count] = $csvdata[$x_count];
                $final = $final + $at_last;

                #曲線圖X軸的節點 
                $x_nodal_point = implode("','", array_keys($final)); 
                $data['x_nodal_point'] = "'".$x_nodal_point."'";
                $data['final'] = $final;

                #判斷 有無cookie chat_mode 
                if (isset($_COOKIE['chat_mode'])) {
                    $chat_mode = $_COOKIE['chat_mode'];
                }else{
                    $chat_mode = "1";
                }

             
                #取得曲線圖的模式
                $chat_arr = $this->Monitors_newModel->chat_change($chat_mode);
                $data['chat'] = $chat_arr;

                #設置Y軸的最大及最小值
                #要比對的位置
                //$position = 1;

                //如果 position = ''  Y=>扭力 ,X=>角度                
                $values = array();
                foreach ($csvdata as $subarray) {                    
                    $values[] = $subarray[$chat_arr['position']];
                } 

                $total_range = '';
                foreach($final as $kk =>$vv){
                    $total_range .= $vv[$chat_arr['position']].',';
                }
        
                #曲線圖的資料
                $data['total_range'] = $total_range;
    
                #取得指定位置的值的最大值和最小值
                $y_maxvalue = max($values);
                $y_minvalue = min($values);

                $data['y_maxvalue'] = $y_maxvalue;
                $data['y_minvalue'] = $y_minvalue;

            }

            
            $data['job_info'] = $info;

            $chat_mode_arr = array(
                1=>'Torque/Time',
                2=>'Angle/Time',
                3=>'RPM/Time',
                4=>'Power/Time',
                5=>'Torque/Angle'
            );



            $torque_mode_arr = array(
                1=>'N.m',
                2=>'Kgf.m',
                3=>'Kgf.cm',
                4=>'In.lbs',

            );    
            $data['chat_mode_arr'] = $chat_mode_arr;
            $data['torque_mode_arr'] = $torque_mode_arr;

    
            $this->view('monitor/index_info', $data);
        }

    }

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

}