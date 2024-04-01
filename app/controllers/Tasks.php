<?php

class Tasks extends Controller
{
    private $TaskModel;
    private $SequenceModel;
    private $ProductModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->TaskModel = $this->model('Task');
        $this->SequenceModel = $this->model('Sequence');
        $this->ProductModel = $this->model('Product');
        $this->NavsController = $this->controller_new('Navs');
    }

    // 取得所有Jobs
    public function index($job_id = 1,$seq_id = 1){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();
        $tasks = $this->TaskModel->getTasks($job_id,$seq_id);
        $seq_data = $this->SequenceModel->GetSeqById($job_id,$seq_id);
        $job_data = $this->ProductModel->getJobById($job_id);
        //預處理task_list
        foreach ($tasks as $key => $value) {
            if( isset($value['program'][0]) ){
                $tasks[$key]['last_job_type'] = 'advanced';
                $tasks[$key]['last_targettype'] = $value['program'][array_key_last($value['program'])]['step_targettype'];
                $tasks[$key]['last_step_targetangle'] = $value['program'][array_key_last($value['program'])]['step_targetangle'];
                $tasks[$key]['last_step_highangle'] = $value['program'][array_key_last($value['program'])]['step_highangle'];
                $tasks[$key]['last_step_lowangle'] = $value['program'][array_key_last($value['program'])]['step_lowangle'];
                $tasks[$key]['last_step_targettorque'] = $value['program'][array_key_last($value['program'])]['step_targettorque'];
                $tasks[$key]['last_step_hightorque'] = $value['program'][array_key_last($value['program'])]['step_hightorque'];
                $tasks[$key]['last_step_lowtorque'] = $value['program'][array_key_last($value['program'])]['step_lowtorque'];
                $tasks[$key]['last_step_name'] = $value['program'][array_key_last($value['program'])]['step_name'];
                $tasks[$key]['last_step_count'] = count($value['program']);
            }else{
                $tasks[$key]['last_job_type'] = 'normal';
                $tasks[$key]['last_targettype'] = $value['program']['step_targettype'];
                $tasks[$key]['last_step_targetangle'] = $value['program']['step_targetangle'];
                $tasks[$key]['last_step_highangle'] = $value['program']['step_highangle'];
                $tasks[$key]['last_step_lowangle'] = $value['program']['step_lowangle'];
                $tasks[$key]['last_step_targettorque'] = $value['program']['step_targettorque'];
                $tasks[$key]['last_step_hightorque'] = $value['program']['step_hightorque'];
                $tasks[$key]['last_step_lowtorque'] = $value['program']['step_lowtorque'];
                $tasks[$key]['last_step_name'] = $value['program']['step_name'];
                $tasks[$key]['last_step_count'] = 1;
            }     
        }

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'tasks' => $tasks,
            'job_id' => $job_id,
            'seq_id' => $seq_id,
            'seq_img' => $seq_data['img'],
            'job_data' => $job_data,
        ];
        
        $this->view('task/index', $data);
    }

    public function get_head_task_id(){
        $head_task_id = '';
        $error_message = '';
        $input_check = true;

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

        //task id是由系統指派
        if ($input_check) {
            $head_task_id = $this->TaskModel->get_head_task_id($job_id,$seq_id);
        }
        
        echo json_encode($head_task_id);
        exit();
    }

    //create & edit task
    public function edit_task(){

        $error_message = '';

        if(isset($_POST)){//form資料
            $data_array = $_POST;
            $input_check = true;
            $error_message = '';

            if( !empty($data_array['job_id']) && isset($data_array['job_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "job_id,";
            }
            if( !empty($data_array['seq_id']) && isset($data_array['seq_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "seq_id,";
            }
            if( !empty($data_array['task_id']) && isset($data_array['task_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "task_id,";
            }
            if( !empty($data_array['screw_template_id']) && isset($data_array['screw_template_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "screw_template_id,";
            }
            if( !empty($data_array['position']) && isset($data_array['position']) ){
                $find = ['(',')'];
                $ss = str_replace($find,'',$data_array['position']);
                $coordinate = explode(",",$ss);
                $data_array['position_x'] = $coordinate[0];
                $data_array['position_y'] = $coordinate[1];
            }else{ 
                $input_check = false;
                $error_message .= "position,";
            }
            if( !empty($data_array['tolerance']) && isset($data_array['tolerance'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "tolerance,";
            }
            if( isset($data_array['message_text']) ){
            }else{ 
                $input_check = false;
                $error_message .= "message_text,";
            }
            if( isset($data_array['delaytime']) && $data_array['delaytime'] >=0 && $data_array['delaytime'] <= 20 ){
            }else{ 
                $input_check = false;
                $error_message .= "delaytime,";
            }
            if( !empty($data_array['img_div']) && isset($data_array['img_div'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "img_div,";
            }
            if( !empty($data_array['controller_id']) && isset($data_array['controller_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "controller_id,";
            }
            if( isset($data_array['enable_arm'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "enable_arm,";
            }

            if ($input_check) {
                $jobs = $this->TaskModel->EditTask($data_array);
                //step也要新增 用screw_template_id 去新增
                $program = $this->TaskModel->EditTaskProgram($data_array);
            }
        }


        echo json_encode(array('error' => $error_message));
        exit();
    }

    //get task by id
    public function get_task_by_id(){
        $input_check = true;
        //因job id是由系統指派，在create job時，抓取最前面的job id 帶入
        if( !empty($_POST['job_id']) && isset($_POST['job_id'])  ){
            $job_id = $_POST['job_id'];
        }else{ 
            $input_check = false; 
        }
        if( !empty($_POST['seq_id']) && isset($_POST['seq_id'])  ){
            $seq_id = $_POST['seq_id'];
        }else{ 
            $input_check = false; 
        }
        if( !empty($_POST['task_id']) && isset($_POST['task_id'])  ){
            $task_id = $_POST['task_id'];
        }else{ 
            $input_check = false; 
        }

        if($input_check){
            $task_data = $this->TaskModel->GetTaskById($job_id,$seq_id,$task_id);
        }

        echo json_encode($task_data);
    }

    public function delete_task_by_id($value='')
    {
        $input_check = true;
        if( !empty($_POST['job_id']) && isset($_POST['job_id'])  ){
            $job_id = $_POST['job_id'];
        }else{ 
            $input_check = false; 
        }
        if( !empty($_POST['seq_id']) && isset($_POST['seq_id'])  ){
            $seq_id = $_POST['seq_id'];
        }else{ 
            $input_check = false; 
        }
        if( !empty($_POST['task_id']) && isset($_POST['task_id'])  ){
            $task_id = $_POST['task_id'];
        }else{ 
            $input_check = false; 
        }

        if($input_check){
            $tasks_data = $this->TaskModel->DeleteTasksById($job_id,$seq_id,$task_id);
            $this->TaskModel->ReOrderTasksId($job_id,$seq_id,$task_id);
        }

        echo json_encode($tasks_data);
    }


    //get product list

    //get product by id

    //edit product by id

    //copy product by id

    //delete product by id

}