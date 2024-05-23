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




        $this->view('calibration/index', $data);

    }

    // 
    public function  tidy_data(){
        $fileContent = file_get_contents("../final_val.txt");
        preg_match_all("/'data' => '([^']+)'/", $fileContent, $matches);
        $dataArray = $matches[1];
        $dataArray = preg_replace('/[\s+]/', '', $dataArray);
        
        if(!empty($dataArray)){
            $cleanedDataArray = [];
            foreach ($dataArray as $data) {
                $cleanedDataArray[] = str_replace(['+ ', 'kgf*cm'], '', $data);
            }
          
            #取最後一筆的資料 做型態改變
            $cleanedDataArray = end($cleanedDataArray);
            $cleanedDataArray = preg_replace('/[^0-9.]/', '', $cleanedDataArray); 
            $final = (float)$cleanedDataArray;
            $this->CalibrationModel->tidy_data($final);
         
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
                        echo $this->generatecheckboxhtml($v_task['task_id'], $v_task['task_id'], 'taskid', 'JobCheckbox_task');
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
    public function get_xml(){

        $info = $this->CalibrationModel->datainfo();
        $torque_type = $this->CalibrationModel->details('torque');

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
    
    

    
    private function generatecheckboxhtml($value, $label, $name, $onClickFunction) {

        $checkbox_html = '<div class="row t1">';
        $checkbox_html .= '<div class="col t5 form-check form-check-inline">';
        $checkbox_html .= '<input class="form-check-input" type="checkbox" name="' .$name. '" id="' .$name. '" value="' .$value. '" onclick="' .$onClickFunction.'()" style="zoom:1.0; vertical-align: middle;">&nbsp;';
        $checkbox_html .= '<label class="form-check-label" for="">'.$label.'</label>';
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
    
    
    
    function call_job($serialnumber,$length){

        $error_message = '';
        if (!empty($serialnumber) && !empty($length)) {
            require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
            $modbus = new ModbusMaster(CONTROLLER_IP, "TCP");
            try {
                $modbus->port = 502;
                $modbus->timeout_sec = 10;
                $data = $modbus->readMultipleRegisters(1, $serialnumber , $length);
                $res = json_encode(array('result' => $data[1],'error' => $error_message));

            } catch (Exception $e) {
                $res =  json_encode(array('error' => $modbus->status));
            }

        }

        return $res;
     

    }




}