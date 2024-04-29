<?php

class Products extends Controller
{
    private $ProductModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->ProductModel = $this->model('Product');
        $this->NavsController = $this->controller_new('Navs');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();
        $jobs = $this->ProductModel->getJobs();

        $status = array();
        $status['ok_job'][0] = 'OFF';
        $status['ok_job'][1] = 'ON';
        $status['ok_job_stop'][0] = 'OFF';
        $status['ok_job_stop'][1] = 'ON';
        $status['reverse_direction'][0] = 'CW';
        $status['reverse_direction'][1] = 'CCW';
        $status['reverse_cnt_mode'][0] = 'OFF';
        $status['reverse_cnt_mode'][1] = 'ON';

        // var_dump($jobs);

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'jobs' => $jobs,
        ];
        
        $this->view('product/index', $data);

    }

    //get product list
    public function get_head_job_id(){
        //因由系統指派job id
        $head_job_id = $this->ProductModel->get_head_job_id();

        echo json_encode($head_job_id);
        exit();
    }

    //get product by id
    public function get_job_by_id()
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
            $job_detail = $this->ProductModel->getJobById($job_id);
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }

        echo json_encode($job_detail);
        exit();

    }


    //edit product by id
    public function edit_job()
    {
        $error_message = '';

        if(isset($_POST)){//form資料
            $data_array = $_POST;
            $input_check = true;
            $error_message = '';

            if( !empty($data_array['controller_type']) && isset($data_array['controller_type'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "controller_type,";
            }
            if( !empty($data_array['job_id']) && isset($data_array['job_id'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "job_id,";
            }
            if( !empty($data_array['job_name']) && isset($data_array['job_name'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "job_name,";
            }
            if(  !empty($data_array['ok_job']) && isset($data_array['ok_job']) ){
                if($data_array['ok_job'] == 'true'){
                    $data_array['ok_job'] = 1;
                }else{
                    $data_array['ok_job'] = 0;
                }
            }else{ 
                $input_check = false;
                $error_message .= "ok_job,";
            }
            if(  !empty($data_array['ok_job_stop']) && isset($data_array['ok_job_stop'])  ){
                if($data_array['ok_job_stop'] == 'true'){
                    $data_array['ok_job_stop'] = 1;
                }else{
                    $data_array['ok_job_stop'] = 0;
                }
            }else{ 
                $input_check = false;
                $error_message .= "ok_job_stop,";
            }
            if(  isset($data_array['reverse_button'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "reverse_button,";
            }
            if(  !empty($data_array['reverse_rpm']) && isset($data_array['reverse_rpm'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "reverse_rpm,";
            }
            if(  !empty($data_array['reverse_Force']) && isset($data_array['reverse_Force'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "reverse_Force,";
            }
            if(  !empty($data_array['reverse_count']) && isset($data_array['reverse_count'])  ){
                if($data_array['reverse_count'] == 'true'){
                    $data_array['reverse_count'] = 1;
                }else{
                    $data_array['reverse_count'] = 0;
                }
            }else{ 
                $input_check = false;
                $error_message .= "reverse_count,";
            }
            if( isset($data_array['threshold_torque']) && $data_array['threshold_torque'] >= 0  ){
            }else{ 
                $input_check = false;
                $error_message .= "threshold_torque,";
            }
            if( isset($data_array['size'])  ){
            }else{ 
                $input_check = false;
                $error_message .= "size,";
            }
            if(  !empty($data_array['barcode_start']) && isset($data_array['barcode_start']) ){
                if($data_array['barcode_start'] == 'true'){
                    $data_array['barcode_start'] = 1;
                }else{
                    $data_array['barcode_start'] = 0;
                }
            }else{ 
                $input_check = false;
                $error_message .= "ok_job,";
            }
            if(  !empty($data_array['tower_light']) && isset($data_array['tower_light']) ){
                if($data_array['tower_light'] == 'true'){
                    $data_array['tower_light'] = 1;
                }else{
                    $data_array['tower_light'] = 0;
                }
            }else{ 
                $input_check = false;
                $error_message .= "ok_job,";
            }

            if ($input_check) {
                $jobs = $this->ProductModel->EditJob($data_array);
            }
        }

        // var_dump($_FILES);

        if(!empty($_FILES) && $input_check){//圖片資料
            $input_image=$_FILES['croppedImage']['tmp_name'];
            $image_info = @getimagesize($input_image);
            // var_dump($image_info);
            if($image_info == false){
                // echo "The selected file is not image.";
                $error_message .= 'The selected file is not image, ';
            }else{
                $image_array=explode('/',$_FILES['croppedImage']['type']);
                $image_type = $image_array[1];
                $t=time();
                $datetime = date("Y-m-dHms",$t);
                $image_new_name = $datetime.'.'.$image_type;
                $image_upload_path="./img/job_img/".$image_new_name;
                $is_uploaded = move_uploaded_file($_FILES["croppedImage"]["tmp_name"],$image_upload_path);

                if($is_uploaded){
                    // 把img url寫入資料庫
                    // echo 'Image Successfully Uploaded';
                    $this->ProductModel->SetJobImage($data_array['job_id'],$image_upload_path);
                }
                else{
                    // echo 'Something Went Wrong!';
                    $error_message .= 'image upload error';
                }
            }
        }

        echo json_encode(array('error' => $error_message));
        exit();
    }

    //copy product by id
    public function copy_job($value='')
    {
        $input_check = true;
        $error_message = '';
        if( !empty($_POST['from_job_id']) && isset($_POST['from_job_id'])  ){
            $from_job_id = $_POST['from_job_id'];
        }else{ 
            $input_check = false;
            $error_message .= "from_job_id,";
        }
        if( !empty($_POST['to_job_id']) && isset($_POST['to_job_id'])  ){
            $to_job_id = $_POST['to_job_id'];
        }else{ 
            $input_check = false;
            $error_message .= "to_job_id,";
        }
        if( !empty($_POST['to_job_name']) && isset($_POST['to_job_name'])  ){
            $to_job_name = $_POST['to_job_name'];
        }else{ 
            $input_check = false;
            $error_message .= "to_job_name,";
        }

        if ($input_check) {
            $result = $this->ProductModel->CopyJob($from_job_id,$to_job_id,$to_job_name);
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }

        echo json_encode($result);
        exit();
    }

    //delete product by id
    public function delete_job($value='')
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
            $result = $this->ProductModel->DeleteJobById($job_id);
        }else{
            echo json_encode(array('error' => $error_message));
            exit();
        }

        echo json_encode($result);
        exit();
    }

}