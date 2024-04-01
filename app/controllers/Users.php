<?php

class Users extends Controller
{
    private $UserModel;
    private $NavsController;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->UserModel = $this->model('User');
        $this->NavsController = $this->controller_new('Navs');
    }

    // 取得所有Jobs
    public function index(){

        $isMobile = $this->isMobileCheck();
        $nav = $this->NavsController->get_nav();
        $all_users = $this->UserModel->GetAllUser();
        $permission_list = $this->UserModel->GetAllPermissions();
        $all_roles = $this->UserModel->GetAllRole();

        $data = [
            'isMobile' => $isMobile,
            'nav' => $nav,
            'all_users' => $all_users,
            'permission_list' => $permission_list,
            'all_roles' => $all_roles,
        ];
        
        $this->view('user/index', $data);

    }

    public function add_user(){
        // 處理新增使用者請求
        $result = false;
        $error_message = '';

        if (isset($_POST['add_user'])) {

            // var_dump($_POST);
            //驗證帳號不可重複
            $duplicate = false;
            $duplicate = $this->UserModel->DuplicateCheck($_POST['user_account']);;
            if($duplicate){
                echo json_encode(array('error' => 'account repeat'));
                exit();
            }

            $user_account = $_POST['user_account'];
            $user_password = $_POST['user_password'];
            $role = $_POST['role'];
            $user_name = $_POST['user_name'];

            $user_id = $this->UserModel->AddUser($user_account,$user_password,$user_name);
            if (isset($user_id)) {
                $this->UserModel->AddUserRole($user_id,$role);
                $this->logMessage('add user','success: user:'.$user_account);
                $result = true;
            }else{
                $result = false;
            }

            if(!$result){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }

    public function get_user_by_id(){
        // 處理新增使用者請求
        $result = false;
        $error_message = '';
        
        if (isset($_POST['user_id'])) {

            $user_data = $this->UserModel->GetUserById($_POST['user_id']);;

            if(!$user_data){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                $user_data['error'] = '';
                echo json_encode($user_data);
                exit();
            }
            
        }
    }

    public function edit_user()
    {
        // 處理新增使用者請求
        $result = false;
        $error_message = '';

        if (isset($_POST['user_id'])) {

            $user_id = $_POST['user_id'];
            $user_password = $_POST['user_password'];
            $role = $_POST['role'];
            $user_name = $_POST['user_name'];

            $results = $this->UserModel->EditUser($user_id,$user_password,$user_name);
            if ($results) {
                $this->UserModel->EditUserRole($user_id,$role);
                $this->logMessage('edit user','success: user_id:'.$user_id);
                $result = true;
            }else{
                $result = false;
            }

            if(!$result){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }

    public function delete_user()
    {
        // 處理新增使用者請求
        $result = false;
        $error_message = '';

        if (isset($_POST['user_id'])) {

            $user_id = $_POST['user_id'];

            $results = $this->UserModel->DeleteUser($user_id);
            if ($results) {
                $this->UserModel->DeleteUserRole($user_id);
                $this->logMessage('delete user','success: user_id:'.$user_id);
                $result = true;
            }else{
                $result = false;
            }

            if(!$result){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }

    //add new role
    public function add_new_role()
    {
        // 處理新增使用者請求
        $result = false;
        $error_message = '';

        if (isset($_POST['role_name'])) {

            // var_dump($_POST);
            //驗證帳號不可重複
            $role_name = $_POST['role_name'];

            $role_id = $this->UserModel->AddNewRole($role_name);
            if ($role_id > 0) {
                $this->logMessage('add role','success: rolename:'.$role_name);
                $result = true;
            }else{
                $result = false;
            }

            if(!$result){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }
    //delete role
    public function delete_role()
    {
        // 處理新增使用者請求
        $result = false;
        $error_message = '';

        if (isset($_POST['role_id'])) {

            // var_dump($_POST);
            //驗證帳號不可重複
            $role_id = $_POST['role_id'];

            $result = $this->UserModel->DeleteRole($role_id);

            if(!$result){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                $this->logMessage('delete role','success: role_id:'.$role_id);
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }
    //edit role
    public function edit_role_permission_by_id()
    {
        if(isset($_POST['role_id'])) {

            //驗證帳號不可重複
            $role_id = $_POST['role_id'];
            $role_permissions = $_POST['role_permissions'];

            $user_data = $this->UserModel->AssiginPermissionByRoleId($role_id,$role_permissions);

            if(!$user_data){
                echo json_encode(array('error' => 'fail'));
                exit();
            }else{
                $this->logMessage('edit role','success: role_id:'.$role_id.', permissions:'.json_encode($role_permissions));
                echo json_encode(array('error' => ''));
                exit();
            }
            
        }
    }
    //get singel roel
    public function get_role_permission_by_id()
    {

        if (isset($_POST['role_id'])) {

            //驗證帳號不可重複
            $role_id = $_POST['role_id'];

            $user_data = $this->UserModel->GetRolePermissions($role_id);

            if(!$user_data){
                echo json_encode(array('error' => 'no permissions'));
                exit();
            }else{
                $user_data['error'] = '';
                echo json_encode($user_data);
                exit();
            }
            
        }
    }
    
}