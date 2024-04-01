<?php

class Controller
{
    // 載入 model
    public function model($model)
    {
        require_once '../app/models/' . $model . '.php';
        return new $model();
    }

    // 載入 controller
    public function controller_new($controller)
    {
        require_once '../app/controllers/' . $controller . '.php';
        return new $controller();
    }

    // 載入 view
    // 其中 view 可能有需要從 Controller 帶過去的資料，故多了 $data 陣列作為第二個參數
    public function view($view, array $data = [])
    {
        $this->language_auto(); //從瀏覽器帶入語系
        //multi language
        $language = array("language"=>$_SESSION['language']);
        $data = array_merge($data,$language);
        
        //權限
        // $privilege = array("privilege"=>$_SESSION['privilege']);
        // $data = array_merge($data,$privilege);
        // var_dump($data);
        // 如果檔案存在就引入它
        if(file_exists('../app/language/' . $data['language'] . '.php')){
            require_once '../app/language/' . $data['language'] . '.php';
        } else { //預設採用簡體中文
            require_once '../app/language/zh-cn.php';
        }

        // 如果檔案存在就引入它
        if(file_exists('../app/views/' . $view . '.tpl')){
            require_once '../app/views/' . $view . '.tpl';
        } else {
            die('View does not exist');
        }
    }

    public function language_auto($value='')
    {
        // 如果$_SESSION['language'] 未設定 或為空 就從瀏覽器訊息帶入
        if( !isset($_SESSION['language']) || $_SESSION['language'] == '' ){
            $lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 4);
            if (preg_match("/zh-cn/i", $lang)){
                $_SESSION['language'] = 'zh-cn';
            }else if(preg_match("/zh-tw/i", $lang)){
                $_SESSION['language'] = 'zh-tw';
            }else if(preg_match("/en/i", $lang)){
                $_SESSION['language'] = 'en-us';
            }else{//預設
                $_SESSION['language'] = 'en-us';
            }
        }

    }

    public function copyDB_to_RamdiskDB() {
        // $source = "/var/www/html/database/tcscon.db";
        // $destination = "/mnt/ramdisk/tcscon.db";

        // if( file_exists($source) && file_exists($destination)){
        //     if (copy($source, $destination)) {
        //         // echo '文件複製成功！';
        //         return true;
        //     } else {
        //         // echo '文件複製失敗！';
        //         return false;
        //     }
        // }

        if( PHP_OS_FAMILY == 'Linux'){// 拿掉每次都用modbus
            
            // //判斷iDas的DB版本是否小於控制器
            // $this->SettingModel = $this->model('Setting');
            // $C_DB_Version = $this->SettingModel->Get_Controller_DB_version();
            // $Controller_Info = $this->SettingModel->GetControllerInfo();
            // if ($Controller_Info['tcscondb_version'] < $C_DB_Version) {
            //     $this->logMessage('modbus status: iDas的DB版本小於控制器');
            //     return false;
            //     // echo json_encode(array('error' => 'iDas的DB版本小於控制器'));
            //     // exit();
            // }

            // $this->logMessage('db_sync D2C start');
            // $source = "/var/www/html/database/iDas-tcscon.db";
            // $destination = "/mnt/ramdisk/FTP/iDas.cfg";

            // if (copy($source, $destination)) {
            //     require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
            //     $modbus = new ModbusMaster("127.0.0.1", "TCP");
            //     try {
            //         $modbus->port = 9000;
            //         $data = array(1, 26948, 24947);
            //         $dataTypes = array("INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT");

            //         // FC 16
            //         $modbus->writeMultipleRegister(0, 506, $data, $dataTypes);
            //         $this->logMessage('modbus write 506 ,array = '.implode("','", $data));
            //         $this->logMessage('modbus status:'.$modbus->status);
            //         return true;
            //         // echo json_encode(array('error' => ''));
            //         // exit();
            //     } catch (Exception $e) {
            //         // Print error information if any
            //         $this->logMessage('modbus write 506 fail');
            //         $this->logMessage('db_sync D2C end');
            //         return false;
            //         // echo json_encode(array('error' => 'modbus error'));
            //         // exit();
            //     }
            // } else {
            //     $this->logMessage('copy db error');
            //     $this->logMessage('db_sync D2C end');
            //     return false;
            //     // echo json_encode(array('error' => 'copy db error'));
            //     // exit();
            // }       
        }

        //關閉同步到Ramdisk
        return false;

    }

    public function logMessage($action,$detail) {
        date_default_timezone_set('UTC');
        if( PHP_OS_FAMILY == 'Linux'){
            $cc_db = new PDO('sqlite:/var/www/html/database/tcscon.db'); //local
        }else{
            $cc_db = new PDO('sqlite:../cc.db'); //local
        }

        if (!empty($_SERVER["HTTP_CLIENT_IP"])){
            $ip = $_SERVER["HTTP_CLIENT_IP"];
        }elseif(!empty($_SERVER["HTTP_X_FORWARDED_FOR"])){
            $ip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        }else{
            $ip = $_SERVER["REMOTE_ADDR"];
        }

        if(!empty($_SESSION["user"])){
            $account = $_SESSION['user'];
        }else{
            $account = '';
        }     
        
        $cc_db->exec('set names utf-8'); 
        $stmt = $cc_db->prepare('INSERT INTO system_log (account, action, detail, ip, timestamp ) VALUES ( :account, :action, :detail, :ip, :timestamp )');
        $stmt->bindValue(':account', $account);
        $stmt->bindValue(':action', $action);
        $stmt->bindValue(':detail', $detail);
        $stmt->bindValue(':ip', $ip);
        $stmt->bindValue(':timestamp', date("Y-m-d H:i:s"));
        $result = $stmt->execute();

        return $result;       
    }

    public function isMobileCheck($value='')
    {
        //Detect special conditions devices
        $iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
        $iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
        $iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
        if(stripos($_SERVER['HTTP_USER_AGENT'],"Android") && stripos($_SERVER['HTTP_USER_AGENT'],"mobile")){
            $Android = true;
        }else if(stripos($_SERVER['HTTP_USER_AGENT'],"Android")){
            $Android = false;
            $AndroidTablet = true;
        }else{
            $Android = false;
            $AndroidTablet = false;
        }
        $webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
        $BlackBerry = stripos($_SERVER['HTTP_USER_AGENT'],"BlackBerry");
        $RimTablet= stripos($_SERVER['HTTP_USER_AGENT'],"RIM Tablet");
        //do something with this information
        if( $iPod || $iPhone || $iPad || $Android || $AndroidTablet || $webOS || $BlackBerry || $RimTablet){
            return true;
        }else{
            return false;
        }
    }

    //權限驗證function
    public function LoginCheck($value='')
    {
        if( PHP_OS_FAMILY == 'Linux'){
            $con_db = new PDO('sqlite:/var/www/html/database/tcscon.db'); //local
        }else{
            $con_db = new PDO('sqlite:../tcscon.db'); //local
        }

        $con_db->exec('set names utf-8'); 
        $sql = 'SELECT * FROM operator';
        $statement = $con_db->prepare($sql);
        $results = $statement->execute();
        $row = $statement->fetch(PDO::FETCH_ASSOC);

        return $row['operator_loginflag'];        
    }


}
