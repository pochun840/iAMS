<?php

class Equipments extends Controller
{
    private $DashboardModel;
    private $NavsController;
    private $EquipmentModel;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
        $this->NavsController = $this->controller_new('Navs');
        $this->EquipmentModel = $this->model('Equipment');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();

        //有設定的device，讀取目前的設定值來顯示
        $TowerLightSetting = $this->EquipmentModel->GetTowerLightSetting();

        $div_add_device_modal = 'equipment/div_add_device_modal';
        $div_arm = 'equipment/div_arm';
        $div_device = 'equipment/div_device';
        $div_picktolight = 'equipment/div_picktolight';
        $div_plc_io = 'equipment/div_plc_io';
        $div_recycle_box = 'equipment/div_recycle_box';
        $div_tower_light = 'equipment/div_tower_light';

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'TowerLightSetting' => $TowerLightSetting,
            'div_add_device_modal' => $div_add_device_modal,
            'div_arm' => $div_arm,
            'div_device' => $div_device,
            'div_picktolight' => $div_picktolight,
            'div_plc_io' => $div_plc_io,
            'div_recycle_box' => $div_recycle_box,
            'div_tower_light' => $div_tower_light,
        ];
        
        $this->view('equipment/index', $data);

    }

    public function IO_tes()
    {   
        $data_true = array(true,true);
        $data_false = array(false,false);
        $regiest = 0x04;
        $ledMax = 12;

        if(isset($_GET['pin0']) ){
            $pin0 = boolval($_GET['pin0']);
        }else{
            $pin0 = false;
        }
        if(isset($_GET['pin1']) ){
            $pin1 = boolval($_GET['pin1']);
        }else{
            $pin1 = false;
        }
        if(isset($_GET['pin2']) ){
            $pin2 = boolval($_GET['pin2']);
        }else{
            $pin2 = false;
        }
        if(isset($_GET['pin3']) ){
            $pin3 = boolval($_GET['pin3']);
        }else{
            $pin3 = false;
        }
        if(isset($_GET['pin4']) ){
            $pin4 = boolval($_GET['pin4']);
        }else{
            $pin4 = false;
        }
        if(isset($_GET['pin5']) ){
            $pin5 = boolval($_GET['pin5']);
        }else{
            $pin5 = false;
        }
        if(isset($_GET['pin6']) ){
            $pin6 = boolval($_GET['pin6']);
        }else{
            $pin6 = false;
        }
        if(isset($_GET['pin7']) ){
            $pin7 = boolval($_GET['pin7']);
        }else{
            $pin7 = false;
        }
        if(isset($_GET['pin8']) ){
            $pin8 = boolval($_GET['pin8']);
        }else{
            $pin8 = false;
        }
        if(isset($_GET['pin9']) ){
            $pin9 = boolval($_GET['pin9']);
        }else{
            $pin9 = false;
        }
        if(isset($_GET['pin10']) ){
            $pin10 = boolval($_GET['pin10']);
        }else{
            $pin10 = false;
        }
        if(isset($_GET['pin11']) ){
            $pin11 = boolval($_GET['pin11']);
        }else{
            $pin11 = false;
        }

        $data_true = array($pin0,$pin1,$pin2,$pin3,$pin4,$pin5,$pin6,$pin7,$pin8,$pin9,$pin10,$pin11);
        $data_tt = array(false,false,false,false,false,true,false,false,false,false,false,false);
        $data_false = array(false,false,false,false,false,false,false,false,false,false,false,false);

        require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
        $modbus = new ModbusMaster('192.168.1.75', "TCP");
        try {

            $modbus->port = 502;
            $modbus->timeout_sec = 10;

            $recDate = $modbus->writeMultipleCoils(0,0,$data_true);
            usleep(1000000);// 0.05s
            $recDate = $modbus->writeMultipleCoils(0,0,$data_false);

            echo json_encode($recDate);
            exit();

        } catch (Exception $e) {
            // echo $modbus->status;
            echo json_encode($modbus->status);
            exit();
        }        

    }

    public function TowerLightSetting($value='')
    {
        //看要不要加驗證
        $result = $this->EquipmentModel->SetTowerLight($_POST);

        echo json_encode($result);
        exit();
    }

    
}