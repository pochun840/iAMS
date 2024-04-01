<?php

class Operations extends Controller
{
    private $OperationModel;
    private $ProductModel;
    private $SequenceModel;
    private $TaskModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->OperationModel = $this->model('Operation');
        $this->ProductModel = $this->model('Product');
        $this->SequenceModel = $this->model('Sequence');
        $this->TaskModel = $this->model('Task');
        $this->NavsController = $this->controller_new('Navs');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();

        $current_job_id = $this->OperationModel->GetConfigValue('current_job_id');
        $current_seq_id = $this->OperationModel->GetConfigValue('current_seq_id');
        $current_task_id = $this->OperationModel->GetConfigValue('current_task_id');
        //透過上述3個參數 顯示進入Operation畫面所帶入的資料
        //每完成一個就會更新


        $job_data = $this->ProductModel->getJobById($current_job_id['value']);
        $seq_data = $this->SequenceModel->GetSeqById($current_job_id['value'],$current_seq_id['value']);
        $seq_list = $this->OperationModel->getSequencesEnable($current_job_id['value']);
        $task_program = $this->TaskModel->GetTaskProgram($current_job_id['value'],$current_seq_id['value'],$current_task_id['value']);//調整
        $task_list = $this->TaskModel->getTasks($current_job_id['value'],$current_seq_id['value']);

        //get total seq
        $total_seq = $this->SequenceModel->getSequences($current_job_id['value']);
        $total_seq = count($total_seq);

        $job_list = $this->ProductModel->getJobs();
        //預處理task_list
        foreach ($task_list as $key => $value) {
            if( isset($value['program'][0]) ){
                $task_list[$key]['last_job_type'] = 'advanced';
                $task_list[$key]['last_targettype'] = $value['program'][array_key_last($value['program'])]['step_targettype'];
                $task_list[$key]['last_step_targetangle'] = $value['program'][array_key_last($value['program'])]['step_targetangle'];
                $task_list[$key]['last_step_highangle'] = $value['program'][array_key_last($value['program'])]['step_highangle'];
                $task_list[$key]['last_step_lowangle'] = $value['program'][array_key_last($value['program'])]['step_lowangle'];
                $task_list[$key]['last_step_targettorque'] = $value['program'][array_key_last($value['program'])]['step_targettorque'];
                $task_list[$key]['last_step_hightorque'] = $value['program'][array_key_last($value['program'])]['step_hightorque'];
                $task_list[$key]['last_step_lowtorque'] = $value['program'][array_key_last($value['program'])]['step_lowtorque'];
                $task_list[$key]['last_step_name'] = $value['program'][array_key_last($value['program'])]['step_name'];
                $task_list[$key]['last_step_count'] = count($value['program']);
                $task_list[$key]['gtcs_job_id'] = $value['program'][array_key_last($value['program'])]['gtcs_job_id'];
            }else{
                $task_list[$key]['last_job_type'] = 'normal';
                $task_list[$key]['last_targettype'] = $value['program']['step_targettype'];
                $task_list[$key]['last_step_targetangle'] = $value['program']['step_targetangle'];
                $task_list[$key]['last_step_highangle'] = $value['program']['step_highangle'];
                $task_list[$key]['last_step_lowangle'] = $value['program']['step_lowangle'];
                $task_list[$key]['last_step_targettorque'] = $value['program']['step_targettorque'];
                $task_list[$key]['last_step_hightorque'] = $value['program']['step_hightorque'];
                $task_list[$key]['last_step_lowtorque'] = $value['program']['step_lowtorque'];
                $task_list[$key]['last_step_name'] = $value['program']['step_name'];
                $task_list[$key]['last_step_count'] = 1;
                $task_list[$key]['gtcs_job_id'] = $value['program']['gtcs_job_id'];
            }     
        }

        $task_count = count($task_list);

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'job_id' => $current_job_id['value'],
            'seq_id' => $current_seq_id['value'],
            'task_id' => $current_task_id['value'],
            'job_data' => $job_data,
            'job_list' => $job_list,
            'seq_data' => $seq_data,
            'seq_list' => $seq_list,
            'total_seq' => $total_seq,
            'seq_img' => @$seq_data['img'],
            'task_program' => $task_program,
            'task_list' => $task_list,
            'task_count' => $task_count,
        ];
        
        $this->view('operation/index', $data);

    }

    public function Call_Controller_Job()
    {
        $input_check = true;
        $error_message = '';
        if( !empty($_POST['job_id']) && isset($_POST['job_id'])  ){
            $job_id = $_POST['job_id'];
        }else{ 
            $input_check = false;
            $error_message .= "job_id,";
        }

        if ($input_check) {
            require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
            $modbus = new ModbusMaster(CONTROLLER_IP, "TCP");
            try {
                $modbus->port = 502;
                $modbus->timeout_sec = 10;
                $data = array($job_id);
                $dataTypes = array("INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT");

                // FC 16
                $modbus->writeMultipleRegister(0, 463, $data, $dataTypes);
                // $this->logMessage('modbus write 506 ,array = '.implode("','", $data));
                // $this->logMessage('modbus status:'.$modbus->status);
                // $this->logMessage('Import config end');
                // echo json_encode(array('error' => ''));
                echo $modbus->status;
                exit();

            } catch (Exception $e) {
                // Print error information if any
                // echo $modbus;
                // echo '<br>123';
                // echo $e;
                // echo '<br>456';
                // $this->logMessage('modbus write 506 fail');
                // $this->logMessage('modbus status:'.$modbus->status);
                // $this->logMessage('Import config end');
                // echo json_encode(array('error' => 'modbus error'));
                echo $modbus->status;
                exit();
            }
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }

        echo json_encode($job_detail);
        exit();
        
    }

    public function Change_Job()
    {
        $input_check = true;
        $error_message = '';
        if( !empty($_POST['job_id']) && isset($_POST['job_id'])  ){
            $job_id = $_POST['job_id'];
        }else{ 
            $input_check = false;
            $error_message .= "job_id,";
        }
        if( !empty($_POST['seq_id']) && isset($_POST['seq_id'])  ){
            $seq_id = $_POST['seq_id'];
        }else{ 
            $input_check = false;
            $error_message .= "seq_id,";
        }

        if ($input_check) {
            $current_job_id = $this->OperationModel->SetConfigValue('current_job_id',$job_id);
            $current_job_id = $this->OperationModel->SetConfigValue('current_seq_id',$seq_id);
            echo json_encode(array('error' => $error_message));
            exit();
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }
        
    }

    public function ToolStatusCheck()
    {
        $error_message = '';
        if (true) {
            require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
            $modbus = new ModbusMaster(CONTROLLER_IP, "TCP");
            try {
                $modbus->port = 502;
                $modbus->timeout_sec = 10;
                // $data = array($job_id);
                $dataTypes = array("INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT");

                // FC 16
                $data = $modbus->readMultipleRegisters(0, 4345, 1);
               
                echo json_encode(array('result' => $data[1],'error' => $error_message));
                exit();

            } catch (Exception $e) {
                
                echo json_encode(array('error' => $modbus->status));
                exit();
            }
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }

        // echo json_encode($job_detail);
        echo json_encode(array('error' => $error_message));
        exit();
    }

    public function Switch_Tool_Status()
    {
        $input_check = true;
        $error_message = '';
        if( isset($_POST['tool_status']) ){
            $tool_status = $_POST['tool_status'];
        }else{ 
            $input_check = false;
            $error_message .= "tool_status,";
        }

        // var_dump($tool_status);

        // $tool_status = 1;

        if ($input_check) {
            require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
            $modbus = new ModbusMaster(CONTROLLER_IP, "TCP");
            try {
                $modbus->port = 502;
                $modbus->timeout_sec = 10;
                $data = array($tool_status);
                $dataTypes = array("INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT");

                // FC 16
                $data = $modbus->writeMultipleRegister(0, 461, $data, $dataTypes);
                // $this->logMessage('modbus write 506 ,array = '.implode("','", $data));
                // $this->logMessage('modbus status:'.$modbus->status);
                // $this->logMessage('Import config end');
                // echo json_encode(array('error' => ''));
                // echo $modbus->status;
                // var_dump($data);
                echo json_encode(array('result' => $data,'error' => $error_message));
                exit();

            } catch (Exception $e) {
                echo $modbus->status;
                exit();
            }
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }
        
    }

}