<?php

class Navs extends Controller
{
    private $NavModel;
    // 在建構子中將 Post 物件（Model）實例化
    public function __construct()
    {
        $this->NavModel = $this->model('Nav');
    }

    public function get_nav($value='')
    {
        //var_dump($_SESSION['user']);
        $account = '';
        if (isset($_SESSION['user']) ) {
            $account = $_SESSION['user'];
        }else{
            $this->MainsController->logout();
        }
        $uid = $this->NavModel->GetUserIdByAccount($account);
        $user_permissions =  $this->NavModel->GetPermissionsByUserId($uid);
        $rows = $this->NavModel->GetNav();

        $permissions = array();
        foreach ($user_permissions as $key => $value) {
            $permissions[] = $value['Route'];
        }


        $nav_head = '<nav class="main-menu"><ul>';
        $nav_foot = '</ul> <ul class="logout"> <li> <a href="?url=Mains/logout"> <object type="image/svg+xml" data="./img/logout.svg" width="40" height="40">Edit Icon</object> <span class="nav-text"> Logout </span> </a> </li> </ul> </nav>';
        $nav_body = '';

        foreach ($rows as $key => $value) {
            if( in_array($value['controller'], $permissions) || $value['name'] == 'home' ){//有權限才顯示
                $nav_body .= '<li>';
                $nav_body .= '<a href="'.$value['link'].'">';
                // $nav_body .= '<i class="'.$value['icon'].'"></i>';
                // $nav_body .= '<img src="'.$value['img'].'" style="width:35px;"></i>';
                $nav_body .= '<object class="nav-image" type="image/svg+xml" data="'.$value['img'].'" width="40" height="40">Edit Icon</object>';

                $nav_body .= '<span class="nav-text"> '.$value['name'].' </span>';
                $nav_body .= '</a>';
                $nav_body .= '</li>';
            }
        }

        $result = $nav_head.$nav_body.$nav_foot;

        //

        return $result;
    }

}
