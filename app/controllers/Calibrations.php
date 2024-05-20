<?php

class Calibrations extends Controller
{
    private $DashboardModel;
    private $NavsController;

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

        
        $info = $this->CalibrationModel->datainfo();
        $data = [
            'isMobile' => $isMobile,
            'nav' => $this->NavsController->get_nav(),
            'res_controller_arr' => $this->CalibrationModel->details('controller'),
            'res_Torquemeter_arr' => $this->CalibrationModel->details('torquemeter'),
            'res_Torquetype' => $this->CalibrationModel->details('torque'),
            'info' => $info,
            
        ];



        $this->view('calibration/index', $data);

    }


    


    

    
}