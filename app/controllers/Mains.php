<?php

class Mains extends Controller
{
    private $DashboardModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->DashboardModel = $this->model('Main');
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
        
        $this->view('main/index', $data);

    }

    public function change_language()
    {
        if( !empty($_POST['language']) && isset($_POST['language'])  ){
            $language = $_POST['language'];
        }else{ 
            $input_check = false; 
            $error_message .= "language,";
        }

        // session_start();
        $_SESSION['language'] = $language;

        $response = array(
            'language' => $language,
            'result' => true,
        );
        echo json_encode($response);

    }

    // 退出登錄並清除身份驗證令牌
    public function logout() {
        $data = array();
        setcookie('user', '', time() - 3600, '/');
        setcookie('auth_token', '', time() - 3600, '/');
        $this->view('login/index', $data);
        // header("Location:".$_SERVER['REQUEST_URI']."  ");
        exit();
    }

    
}