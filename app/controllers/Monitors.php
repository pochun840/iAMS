<?php

class Monitors extends Controller
{
    private $DashboardModel;
    private $NavsController;



    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
        $this->NavsController = $this->controller_new('Navs');
        $this->UserModel = $this->model('User');
        $this->Monitors_newModel = $this->model('Monitors_new');
    }

    // 取得所有Jobs
    public function index($page){


        //每頁顯示的筆數
        $limit = 30;

        //當前的頁數，默認為第1頁
        $page = isset($_GET['p']) ? $_GET['p'] : 1;
  
        //計算數量
        $offset = ($page - 1) * $limit;

        //取得總筆數
        $totalItems  = "";
        $totalItems  = $this->Monitors_newModel->getTotalItemCount();

        //計算總頁數
        if(!empty($totalItems)){
            $totalPages = ""; 
            $totalPages = ceil($totalItems / $limit);
        }
        
        #取得預設的鎖附資料前50筆
        $info_arr = "";
        $info = $this->Monitors_newModel->monitors_info($info_arr,$offset, $limit);
        
        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();


        #人員權限列表
        $all_roles = $this->UserModel->GetAllRole();
        $all_roles = array_slice($all_roles,0,3);
        //$all_roles = array('GTCS','TCG');

        //var_dump($all_roles);die();

        #鎖附結果
        $res_status_arr = array('ALL','OK','OKALL','NG');
      

        #Controller 分類
        $res_controller_arr = array('GTCS','TCG');

        #program 分類
        $res_program = array('P1','P2','P3','P4');

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'all_roles' => $all_roles,
            'res_status_arr' =>  $res_status_arr,
            'res_controller_arr' => $res_controller_arr,
            'res_program' => $res_program,
            'info' => $info,
            'totalPages' => $totalPages,
            'page' => $page,
            
        ];
            
        $this->view('monitor/index', $data);

    }

    public function del_info(){

        $del_info_sn_arr = array();
        $del_info_sn_arr = $_POST['values'];
        $del_info_sn = implode(",",$del_info_sn_arr);

        #如果是複選 則 強制修改內容
        $del_info_sn = str_replace("," ,"','",$del_info_sn);

        #刪除鎖附結果 以 system_sn 當成唯一值
        $res = $this->Monitors_newModel->del_info($del_info_sn);
        return $res;
    }


    public function search_info_list(){

        $info_arr = array();
        $info_arr = $_POST;


        #按照POST的資訊 取得資料庫搜尋的結果
        $info = $this->Monitors_newModel->monitors_info($info_arr);



        if(!empty($info)){
            $info_data ="";
            foreach($info as $k =>$v){



                $info_data  = "<tr>";
                $info_data .= '<td style="text-align: center;"><input class="form-check-input" type="checkbox" name="test1" id="test1"  value="'.$v['system_sn'].'" style="zoom:1.2;vertical-align: middle;"></td>';
                $info_data .= "<td>".$v['system_sn']."</td>";
                $info_data .= "<td>".$v['data_time']."</td>";
                $info_data .= "<td>".$v['cc_barcodesn']."</td>";
                $info_data .= "<td>".$v['job_name']."</td>";
                $info_data .= "<td>".$v['sequence_name']."</td>";
                $info_data .= "<td>task-1</td>";
                $info_data .= "<td>GTCS</td>";
                $info_data .= "<td>".$v['fasten_torque']." N.m </td>";
                $info_data .= "<td>".$v['fasten_angle']." deg  </td>";
                $info_data .= "<td>".$this->Monitors_newModel->status_code_change($v['fasten_status'])."</td>";
                $info_data .= "<td>".$v['fasten_time']." ms </td>";
                $info_data .= "<td>".$v['fasten_time']." ms </td>";
                $info_data .= "<td>error</td>";
                $info_data .= "<td>p1</td>";
                $info_data .= '<td><img src="./img/info-30.png" alt="" style="height: 28px; vertical-align: middle;" onclick="NextToInfo()"></td>';
        
                $info_data .="</tr>";
                echo $info_data;
            }  
        }else{

        }


        

    
    }



    public function  download_csv(){


        //開始準備一組匯出陣列
        $csv_arr = array();

        //先放置 CSV 檔案的標頭資料
        $csv_arr[] = array('得票數', '系統編號', '報名人', '身分證字號', '信箱', '聯絡電話', '聯絡手機', '聯絡地址', '性別', '年齡', '作品名稱', '作品分類', '拍攝日期', '拍攝地點', '拍攝相機', '拍攝鏡頭', '相片原始檔案', '投稿日期', '審查狀態');
       
        //設定檔案輸出名稱
        $filename = "contest-data-export-" . date("Y-m-d-H-i-s") . ".csv";
        
        //設定瀏覽器讀取此份資料為不快取，與解讀行為是下載 CSV 檔案
        header('Pragma: no-cache');
        header('Expires: 0');
        header('Content-Disposition: attachment;filename="' . $filename . '";');
        header('Content-Type: application/csv; charset=UTF-8');

        for ($i = 0; $i < count($photo_data); $i++) {
            $p = $photo_data[$i];
            $csv_arr[] = array(
                //開始根據資料變數組裝後面的陣列資料
            );
        }
        //確保輸出內容符合 CSV 格式，定義下列方法來處理
        function csvstr(array $fields): string{
            $f = fopen('php://memory', 'r+');
            if (fputcsv($f, $fields) === false) {
                return false;
            }
            rewind($f);
            $csv_line = stream_get_contents($f);
            return rtrim($csv_line);
        }
        //正式循環輸出陣列內容
        for ($j = 0; $j < count($csv_arr); $j++) {
            if ($j == 0) {
                //檔案標頭如果沒補上 UTF-8 BOM 資訊的話，Excel 會解讀錯誤，偏向輸出給程式觀看的檔案
                echo "\xEF\xBB\xBF";
            }
            //輸出符合規範的 CSV 字串以及斷行
            echo csvstr($csv_arr[$j]) . PHP_EOL;
        }


    }


    
}