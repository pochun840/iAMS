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

        #select
        $info = $this->CalibrationModel->datainfo();

        #echarts
        $echart_data = $this->CalibrationModel->echarts_data();
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
            
        );

        $echart_data = $this->CalibrationModel->details('torque');

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
        
            $cleanedDataArray[0] = "2.2";
            $final = floatval($cleanedDataArray[0]);
            $this->CalibrationModel->tidy_data($final);
         
        }
        
        
        


    }

    


    


    

    
}