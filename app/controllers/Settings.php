<?php

class Settings extends Controller
{
    private $ProductModel;
    private $SequenceModel;
    private $SettingModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->ProductModel = $this->model('Product');
        $this->SequenceModel = $this->model('Sequence');
        $this->SettingModel = $this->model('Setting');
        $this->NavsController = $this->controller_new('Navs');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
        ];
        
        $this->view('setting/index', $data);

    }

    public function GTCS_DB_SYNC($value='')
    {
        // code...
        //1.撈出GTCS目前的設定DB tcscon.db
        //2.備份tcscon.db
        //3.清空tcscon.db中job、seq、advancedstep、normalstep、input、output table
        //4.將中控設定寫入db，同時更新對應的資料task id與job id
        //5.將設定完成的db透過ftp的方式匯入GTCS的FTP資料夾
        //6.使用modbus指令 讓GTCS更新DB
        $this->FTP_download();//下載並備份GTCS的db
        $this->clearSQLiteTables();//清空GTCS的db
        $this->CCToGTCS();//將中控的設定寫入GTCS db
        $this->FTP_upload();//上傳寫入完成的GTCS db
        $this->ImportDB();//下modbus讓GTCS匯入db
    }

    public function FTP_download($value='')
    {
        $remote_file = '/mnt/ramdisk/tcscon.db';   ### 遠端檔案
        $local_file = '../localfile.db';   ### 本機儲存檔案名稱

        $handle = fopen($local_file, 'w');

        ### 連接的 FTP 伺服器是 localhost
        $conn_id = ftp_connect(CONTROLLER_IP);

        ### 登入 FTP, 帳號是 USERNAME, 密碼是 PASSWORD
        $USERNAME = 'kls';
        $PASSWORD = '12345678rd';
        $login_result = ftp_login($conn_id, $USERNAME, $PASSWORD);

        if (ftp_fget($conn_id, $handle, $remote_file, FTP_ASCII, 0)) {
            echo "下載成功, 並儲存到 $local_file\n";
            if ( copy($local_file,$local_file.'666') ) {
                echo "複製成功, 並儲存到 $local_file SS \n";
            }
        } else {
            echo "下載 $remote_file 到 $local_file 失敗\n";
        }

        ftp_close($conn_id);
        fclose($handle);
    }

    public function FTP_upload($value='')
    {
        $ftp_server = CONTROLLER_IP;
        $ftp_username = "kls";
        $ftp_password = "12345678rd";

        $local_file = '../localfile.db'; // 本地文件路径
        $remote_file = '/mnt/ramdisk/FTP/cc.cfg'; // 远程文件路径

        // 建立 FTP 连接
        $conn = ftp_connect($ftp_server);
        if (!$conn) {
            die('Could not connect to FTP server');
        }

        // 登录 FTP
        $login = ftp_login($conn, $ftp_username, $ftp_password);
        if (!$login) {
            die('FTP login failed');
        }

        // 打开本地文件
        $handle = fopen($local_file, 'r');
        if (!$handle) {
            die('Could not open local file');
        }

        // 上传文件到 FTP
        $upload = ftp_fput($conn, $remote_file, $handle, FTP_BINARY); // FTP_ASCII 或 FTP_BINARY
        if (!$upload) {
            echo 'Could not upload file';
        } else {
            echo 'File uploaded successfully';
        }

        // 关闭连接和文件句柄
        ftp_close($conn);
        fclose($handle);

    }

    public function clearSQLiteTables() {
        $dbPath = '../localfile.db';
            try {
            // 创建 PDO 连接
            $pdo = new PDO("sqlite:$dbPath");

            // 设置 PDO 错误模式为异常
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // 清空表格
            $tables = ['job', 'sequence', 'advancedstep', 'normalstep', 'input', 'output'];

            foreach ($tables as $table) {
                $query = "DELETE FROM $table";
                $pdo->exec($query);
                echo "Table $table cleared successfully<br>";
            }

            // 关闭连接
            $pdo = null;
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

    }

    public function CCToGTCS($value='')
    {
        //將中控設定寫入db，同時更新對應的資料task id與job id

        //select 中控 task 再帶出job與sequence的設定值， 最後寫入tcscon
        //select from ccs_normalstep (應該要再加advancedstep)
        $tasks = $this->SettingModel->get_all_tasks(); //gtcs的step

        $gtcs_job_id_count = 1;
        
        foreach ($tasks as $key => $task) {
            //get CC job data
            $job_data = $this->ProductModel->getJobById($task['job_id']);
            //get CC seq data
            $seq_data = $this->SequenceModel->GetSeqById($task['job_id'],$task['seq_id']);

            if($seq_data != false){
                //建立job
                $this->SettingModel->JobIdCheck($gtcs_job_id_count,$job_data);
                //建立sequence
                $this->SettingModel->SeqIdCheck($gtcs_job_id_count,$task['seq_id'],$seq_data);
                //建立step
                $this->SettingModel->TaskIdCheck($task,$gtcs_job_id_count,$seq_data['seq_name']);

                //將gtcs對應的job_id寫回task的gtcs_job_id 
                $this->SettingModel->TaskUpdate($task,$gtcs_job_id_count);

                $gtcs_job_id_count++;
            }

        }

        //advanced job
        $advanced_tasks = $this->SettingModel->get_all_tasks_advanced(); //gtcs的step

        $gtcs_adv_job_id_count = 100;
        $last_job_id = 0;
        $last_seq_id = 0;
        $last_task_id = 0;

        foreach ($advanced_tasks as $key => $task) {

            if($last_job_id != $task['job_id'] || $last_seq_id != $task['seq_id'] || $last_task_id != $task['task_id'] ){//與前一筆task不同 job_id++
                $gtcs_adv_job_id_count++;

                $last_job_id = $task['job_id'];
                $last_seq_id = $task['seq_id'];
                $last_task_id = $task['task_id'];

                //get CC job data
                $job_data = $this->ProductModel->getJobById($task['job_id']);
                //get CC seq data
                $seq_data = $this->SequenceModel->GetSeqById($task['job_id'],$task['seq_id']);

                if($seq_data != false){

                    //建立job
                    $this->SettingModel->JobIdCheck($gtcs_adv_job_id_count,$job_data);
                    //建立sequence
                    $this->SettingModel->SeqIdCheck($gtcs_adv_job_id_count,$task['seq_id'],$seq_data);
                    //建立step
                    $this->SettingModel->TaskIdCheck_Advanced($task,$gtcs_adv_job_id_count,$seq_data['seq_name']);

                    //將gtcs對應的job_id寫回task的gtcs_job_id 
                    $this->SettingModel->TaskUpdate_Advanced($task,$gtcs_adv_job_id_count);
                    
                }

            }else{//與前一筆task相同 job_id不用++
                //get CC job data
                $job_data = $this->ProductModel->getJobById($task['job_id']);
                //get CC seq data
                $seq_data = $this->SequenceModel->GetSeqById($task['job_id'],$task['seq_id']);

                if($seq_data != false){
                    //建立job job_id相同不用再建立
                    // $this->SettingModel->JobIdCheck($gtcs_adv_job_id_count,$job_data);
                    //建立sequence
                    $this->SettingModel->SeqIdCheck($gtcs_adv_job_id_count,$task['seq_id'],$seq_data);
                    //建立step
                    $this->SettingModel->TaskIdCheck_Advanced($task,$gtcs_adv_job_id_count,$seq_data['seq_name']);

                    //將gtcs對應的job_id寫回task的gtcs_job_id 
                    $this->SettingModel->TaskUpdate_Advanced($task,$gtcs_adv_job_id_count);
                }
            }
        }

    }

    //下modbus讓GTCS匯入FTP的cfg
    public function ImportDB($value='')
    {
        require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
        $modbus = new ModbusMaster(CONTROLLER_IP, "TCP");
        try {
            $modbus->port = 502;
            $modbus->timeout_sec = 30;
            $data = array(1, 25443);
            $dataTypes = array("INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT", "INT");

            // FC 16
            $modbus->writeMultipleRegister(0, 506, $data, $dataTypes);
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
            // echo $modbus->status;
            exit();
        }
    }

    
}