<?php

class Calibrations extends Controller
{
    private $DashboardModel;
    private $NavsController;
    private $mean;

    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
        $this->NavsController = $this->controller_new('Navs');
        $this->UserModel = $this->model('User');
        $this->CalibrationModel = $this->model('Calibration');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();

        #select
        $info = $this->CalibrationModel->datainfo();

        $job_arr = $this->CalibrationModel->getjobid();

        #echarts
        $job_id = $_COOKIE['job_id'] ?? null;
        if(!empty($job_id)){
            $echart_data = $this->CalibrationModel->datainfo_search($job_id);
            $meter = $this->val_traffic();
            if(!empty($echart_data)){
                #整理圖表所需要的資料
                $tmp['x_val'] = json_encode(array_column($echart_data, 'id'));
                $tmp['y_val'] = json_encode(array_column($echart_data, 'torque'));
    
            }
           

        }
        if(empty($info)){
            $info = '';
        }
        if(empty($meter)){
            $meter = '';
        }
        if(empty($tmp)){
            $tmp = '';
        }

        if(!empty($meter['res_total'])){
            $count = count($meter['res_total']);
        }else{
            $count = 0;
        }
        
    
        $data = array(
            'isMobile' => $isMobile,
            'nav' => $this->NavsController->get_nav(),
            'res_controller_arr' => $this->CalibrationModel->details('controller'),
            'res_Torquemeter_arr' => $this->CalibrationModel->details('torquemeter'),
            'res_Torquetype' => $this->CalibrationModel->details('torque'),
            'info' => $info,
            'echart'=> $tmp,
            'job_arr' => $job_arr,
            'meter' =>$meter,
            'count' =>$count,
            
        );

        $this->view('calibration/index', $data);

    }

    public function get_data(){
        
        $input_check = true;
        if (!empty($_POST['job_id']) && isset($_POST['job_id'])) {
            $job_id = $_POST['job_id'];
        } else {
            $input_check = false;
        }

        if($input_check){
            $dataset = $this->CalibrationModel->datainfo_search($job_id);
            if(!empty($dataset)){

                $torque_type = $this->CalibrationModel->details('torque');
                $controller = $this->CalibrationModel->details('controller');
                $ktm = $this->CalibrationModel->details('torquemeter');

                $datalist = '';
                foreach($dataset as $key =>$val){
                    $datalist  = '<tr style="text-align: center; vertical-align: middle;"  data-id="' .$val['id'].'">';
                    $datalist .= "<td>".$val['id']."</td>";
                    $datalist .= "<td>".$val['datatime']."</td>";
                    $datalist .= "<td>".$val['operator']."</td>";
                    $datalist .= "<td>".$val['toolsn']."</td>";
                    $datalist .= "<td>".$val['torque']."</td>";
                    $datalist .= "<td>".$torque_type[$val['unit']]."</td>";
                    $datalist .= "<td>".$val['max_torque']."</td>";
                    $datalist .= "<td>".$val['min_torque']."</td>";
                    $datalist .= "<td>".$val['avg_torque']."</td>";
                    $datalist .= "<td>".$val['high_percent']." % "."</td>";
                    $datalist .= "<td>".$val['low_percent']." % "."</td>";
                    $datalist .= "<td>".$val['customize']."</td>";
                    $datalist .= "</tr>";
                    echo $datalist;

                }
            }else {
                echo "No data found for job_id: " . $job_id;
            }         
        }else {
            echo "Invalid job_id received.";
        }

    }

    public function del_info(){
        $input_check = true;
        if(isset($_POST['chicked_id']) && !empty($_POST['chicked_id'])) {
            $click_id = $_POST['chicked_id'];
        }else{
            $input_check = false;
        }
        if($input_check){
            $res = $this->CalibrationModel->del_info($click_id);
            if($res == true){
                $response = array(
                    'success' => true,
                    'message' => 'Data delete success'
                );
            }else{
                $response = array(
                    'success' => false,
                    'message' => 'Data delete fail'
                );
            }
            echo json_encode($response);

        }


    }

    //取得KTM 回傳數值 寫入到DB
    public function  tidy_data(){
        $file_path = "../api/final_val.txt";
        $fileContent = file_get_contents($file_path);
        eval("\$array = $fileContent;");
        if(!empty($array)){
            $cleanedDataArray = [];
            foreach($array as $data) {
                $cleanedDataArray[] = str_replace(['+ ', 'kgf*cm'], '', $data);
            }
          
            #取最後一筆的資料 做型態改變
            $cleanedDataArray = end($cleanedDataArray);
            $cleanedDataArray = preg_replace('/[^0-9.]/', '', $cleanedDataArray); 
            $final = (float)$cleanedDataArray;
            
            $res = $this->CalibrationModel->tidy_data($final);

            if($res == true){
                $response = array(
                    'success' => true,
                    'message' => 'Data tidied successfully'
                );
            }else{
                $response = array(
                    'success' => false,
                    'message' => 'No data found'
                );
            }

            echo json_encode($response);
        }
    }


    public function get_correspond_val(){
        $val  = array();
    
         #檢查 $_POST['job_id'] 和 $_POST['seq_id'] 是否存在且不為空
         if(isset($_POST['job_id'][0]) && !empty($_POST['job_id'][0])) {
            $job_id = $_POST['job_id'][0];

            #取得對應的seq_id
            if(empty($_POST['seq_id'][0])) {
                $info_seq = $this->CalibrationModel->get_seq_id($job_id);
    
                #組checkbox的seq的html
                if(!empty($info_seq)){
                    foreach($info_seq as $k_seq => $v_seq){
                        echo $this->generatecheckboxhtml($v_seq['seq_id'], $v_seq['seq_name'], 'seqid', 'JobCheckbox_seq');
                    }
                }
            }
    
            #透過job_id 及 seq_id 取得對應的task_id
            if(isset($_POST['seq_id'][0]) && !empty($_POST['seq_id'][0])) {
                $seq_id = $_POST['seq_id'][0];
                $info_task = $this->CalibrationModel->get_task_id($job_id, $seq_id);

                #組checkbox的task的html
                if(!empty($info_task)){
                    foreach($info_task as $k_task => $v_task){
                        echo $this->generatecheckboxhtml($v_task['task_id'], $v_task['task_id'], 'taskid');
                    }
                }
            }

            if(!empty($job_id)){
                $tmp = $this->CalibrationModel->get_job_name($job_id);
                setcookie("job_id", $job_id, time() + 3600, "/"); 
                setcookie("job_name", $tmp[0]['job_name'], time() + 3600, "/"); 

            }
        }

    }

    
    #產生XML的API
    public function get_xml($index){

        if(!empty($index)) {
            $info = $this->CalibrationModel->datainfo($index);
            $torque_type = $this->CalibrationModel->details('torque');
            $controller_type = $this->CalibrationModel->details('controller');
            $ktm_type = $this->CalibrationModel->details('torquemeter');
    
            $xml = new XMLWriter();
            $xml->openMemory();
            $xml->setIndent(true);
            $xml->startDocument('1.0', 'UTF-8');
            $xml->startElement('calibrations');
    
            foreach ($info as $row) {
                $xml->startElement('item');
                foreach ($row as $key => $value) {
                    $xml->startElement($key);
                    if ($key == 'unit') {
                        $value = $torque_type[$value];
                    }
    
                    if ($key == 'high_percent' ||  $key == 'low_percent') {
                        $value = $value ." % ";
                    }
                    if($key == 'controller_type'){
                        $value = $controller_type[$value];
                    }   
                    if($key == 'ktm_type'){
                        $value = $ktm_type[$value];
                    }  
    
                    $xml->writeCData($value);
                    $xml->endElement();
                }
                $xml->endElement(); 
            }
        
            $xml->endElement(); 
            $xml->endDocument();
            header('Content-type: text/xml; charset=utf-8');
            echo $xml->outputMemory();

        }
    
    }
    
    
    private function generatecheckboxhtml($value, $label, $name, $onClickFunction = '') {

        $checkbox_html = '<div class="row t1">';
        $checkbox_html .= '<div class="col t5 form-check form-check-inline">';
        $checkbox_html .= '<input class="form-check-input" type="checkbox" name="' .$name. '" id="' .$name. '" value="' .$value. '"';
        
        if (!empty($onClickFunction)) {
            $checkbox_html .= ' onclick="' . $onClickFunction . '()"';
        }
        
        $checkbox_html .= ' style="zoom:1.0; vertical-align: middle;">&nbsp;';
        $checkbox_html .= '<label class="form-check-label" for="">' . $label . '</label>';
        $checkbox_html .= '</div>';
        $checkbox_html .= '</div>';
        
        return $checkbox_html;
    }


    public function val_traffic(){
        
        $a = 0.6;
        $b = 0.06;

        $temp = array();
        $info = $this->CalibrationModel->meter_info();

        foreach ($info as $sub_array) {
            if (array_key_exists('torque', $sub_array)) {
                $torque_array[] = $sub_array['torque'];
            }
        }
    
        #依照KTM 文件裡的算式 
        $temp['hi_limit_torque'] = $a + $b;
        $temp['low_limit_torque'] = $a - $b;
        $temp['max_torque'] = $info[0]['max_torque'];
        $temp['min_torque'] = $info[0]['min_torque'];
        $temp['avg_torque'] = $info[0]['avg_torque'];
        $temp['stddev1'] = number_format($this->standard_deviation($torque_array),2);
        $temp['stddev2'] = number_format($temp['stddev1'] / $temp['avg_torque'] ,2);
        $temp['stddev3'] = $temp['stddev2'] * 3;
        $temp['cm'] = number_format(( $temp['hi_limit_torque'] - $temp['low_limit_torque']) / ( 6 * $temp['stddev1'] ),2);
        $temp['cmk'] = number_format($this->calculatezscore($temp['hi_limit_torque'], $temp['low_limit_torque'],  $temp['stddev1']),2);

        $temp['res_total'] = $info;

        return $temp;


    }

    public function export_excel(){
        $isMobile = $this->isMobileCheck();

        #select
        $info = $this->CalibrationModel->datainfo();

        $job_arr = $this->CalibrationModel->getjobid();

        #echarts
        $echart_data = $this->CalibrationModel->echarts_data();

        $meter = $this->val_traffic();

        if(!empty($echart_data)){
            #整理圖表所需要的資料
            $tmp['x_val'] = json_encode(array_column($echart_data, 'id'));
            $tmp['y_val'] = json_encode(array_column($echart_data, 'torque'));

        }

        
        $data = array(
            'isMobile' => $isMobile,
            'nav' => $this->NavsController->get_nav(),
            'res_controller_arr' => $this->CalibrationModel->details('controller'),
            'res_Torquemeter_arr' => $this->CalibrationModel->details('torquemeter'),
            'res_Torquetype' => $this->CalibrationModel->details('torque'),
            'info' => $info,
            'echart'=> $tmp,
            'job_arr' => $job_arr,
            'meter' =>$meter,
            'count' =>count($meter['res_total']),
            
        );

        if(!empty($_GET['type'])){
            if($_GET['type'] =="download"){
                $data['type'] = "download";
            }

        }else{
            $data['type'] = '';
        }
        

        $this->view('calibration/excel',$data);


    }

    public function csv_download(){
        
        $input_check = true;
        if (!empty($_POST['job_id']) && isset($_POST['job_id'])) {
            $job_id = $_POST['job_id'];
        } else {
            $input_check = false;
        }

        if($input_check){
            $dataset = $this->CalibrationModel->datainfo_search($job_id);
            if(!empty($dataset)){

                $torque_type = $this->CalibrationModel->details('torque');
                $controller = $this->CalibrationModel->details('controller');
                $ktm = $this->CalibrationModel->details('torquemeter');

                #資料整理 
                foreach($dataset as $key =>$val){
                    $dataset[$key]['unit'] = $torque_type[$val['unit']];
                    $dataset[$key]['high_percent'] = $val['high_percent']."%";
                    $dataset[$key]['low_percent'] = $val['low_percent']."%";
                    $dataset[$key]['controller_type'] = $controller[$val['controller_type']];
                    $dataset[$key]['ktm_type'] = $ktm[$val['ktm_type']];
                }
             
                $csv_headers = array_keys($dataset[0]);
                header('Content-Type: text/csv; charset=utf-8');
                header('Content-Disposition: attachment; filename=data.csv');
    
                $output = fopen('php://output', 'w');
                fputcsv($output, $csv_headers);
    
                foreach ($dataset as $row) {
                    fputcsv($output, $row);
                }
    
                fclose($output);
                exit();
            }
        }
    }


    private function standard_deviation($torque_array) {
        $n = count($torque_array);
        $mean = array_sum($torque_array) / $n;
        $variance = 0.0;
        foreach ($torque_array as $x) {
            $variance += pow($x - $mean, 2);
        }
        $std_dev = sqrt($variance / $n);
        return $std_dev;
    }


    private function calculatezscore($hi_limit_torque, $low_limit_torque, $stddev1) {
        $part1 = (($this->mean - $hi_limit_torque) / (3 * $stddev1));
        $part2 = (($low_limit_torque - $this->mean) / (3 * $stddev1));
        
        return min($part1, $part2);
    }


    
}