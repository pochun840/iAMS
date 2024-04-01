<?php

class User{
    private $db;//condb control box
    private $db_dev;//devdb tool
    private $db_data;//devdb tool
    private $dbh;

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();
    }


    public function AddUser($user_account,$password,$user_name)
    {
        $password = hash('sha256', $password); // 建議使用密碼哈希

        $stmt = $this->db->prepare('INSERT INTO users (account, password, name ) VALUES (:account, :password, :name)');
        $stmt->bindValue(':account', $user_account);
        $stmt->bindValue(':password', $password);
        $stmt->bindValue(':name', $user_name);
        $stmt->execute();

        $sql = "SELECT * FROM `users` WHERE account = :account ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':account', $user_account);
        $statement->execute();
        $row = $statement->fetch(PDO::FETCH_ASSOC);
        $user_id = $row['id'];

        return $user_id;
    }

    public function EditUser($id,$password,$user_name)
    {
        //若password為空，不更新password
        if ($password == '') {
            $stmt = $this->db->prepare('UPDATE users SET name = :name WHERE id = :id');
            $stmt->bindValue(':id', $id);
            $stmt->bindValue(':name', $user_name);
            $results = $stmt->execute();
        }else{
            $password = hash('sha256', $password); // 建議使用密碼哈希
            $stmt = $this->db->prepare('UPDATE users SET password = :password, name = :name WHERE id = :id');
            $stmt->bindValue(':id', $id);
            $stmt->bindValue(':password', $password);
            $stmt->bindValue(':name', $user_name);
            $results = $stmt->execute();
        }
        
        return $results;
    }

    public function DeleteUser($id)
    {
        //若password為空，不更新password
        $stmt = $this->db->prepare('DELETE FROM users WHERE id = :id');
        $stmt->bindValue(':id', $id);
        $results = $stmt->execute();
        
        return $results;
    }

    public function AddUserRole($uid,$role)
    {
        date_default_timezone_set('UTC');

        $stmt = $this->db->prepare('INSERT INTO cc_userroles (UserID, RoleID, AssignmentDate ) VALUES (:UserID, :RoleID, :AssignmentDate)');
        $stmt->bindValue(':UserID', $uid);
        $stmt->bindValue(':RoleID', $role);
        $stmt->bindValue(':AssignmentDate', date("Y-m-d H:i:s"));
        $stmt->execute();
    }

    public function EditUserRole($uid,$role)
    {
        date_default_timezone_set('UTC');

        $stmt = $this->db->prepare('UPDATE cc_userroles SET RoleID = :RoleID, AssignmentDate = :AssignmentDate WHERE UserID = :UserID');
        $stmt->bindValue(':UserID', $uid);
        $stmt->bindValue(':RoleID', $role);
        $stmt->bindValue(':AssignmentDate', date("Y-m-d H:i:s"));
        $stmt->execute();
    }

    public function DeleteUserRole($uid)
    {
        $stmt = $this->db->prepare('DELETE FROM cc_userroles WHERE UserID = :UserID');
        $stmt->bindValue(':UserID', $uid);
        $stmt->execute();
    }

    public function DuplicateCheck($user_account)
    {
        $sql = "SELECT COUNT(*) as count FROM `users` WHERE account = :account ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':account', $user_account);
        $statement->execute();
        $row = $statement->fetch();

        if ($row['count'] > 0) {
            return true;
        }else{
            return false;
        }
        
    }

    public function GetAllUser($value='')
    {
        $sql = "SELECT *  FROM `users` ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;
    }

    public function GetUserById($user_id)
    {
        $sql = "SELECT id,account,name,RoleID FROM users LEFT JOIN cc_userroles ur ON users.id = ur.UserID  WHERE id = :id ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':id', $user_id);
        $statement->execute();
        $row = $statement->fetch(PDO::FETCH_ASSOC);

        return $row;
    }

    public function check_job_event_conflict($job_id,$event_id)
    {
        $sql = "SELECT count(*) as count FROM input WHERE input_jobid = ? AND input_event = ?";
        $statement = $this->db->prepare($sql);
        $results = $statement->execute([$job_id,$event_id]);
        $rows = $statement->fetch();

        if ($rows['count'] > 0) {
            return true; // job event已存在
        }else{
            return false; // job event不存在
        }
    }

    public function GetAllPermissions()
    {
        $sql = "SELECT * FROM `cc_permissions` ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;
    }


    // roles function

    //add new role
    public function AddNewRole($role_name)
    {
        //add cc_roles
        //add cc_rolepermissions
        $stmt = $this->db->prepare('INSERT INTO `cc_roles` (Title, Description ) VALUES (:Title, :Description)');
        $stmt->bindValue(':Title', $role_name);
        $stmt->bindValue(':Description', $role_name);
        $stmt->execute();
        $rows = $stmt->fetch();

        $sql = "SELECT * FROM `cc_roles` WHERE Title = :Title ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':Title', $role_name);
        $statement->execute();
        $row = $statement->fetch(PDO::FETCH_ASSOC);
        $role_id = $row['ID'];

        return $role_id;
    }
    //assign permissions
    public function AssiginPermissionByRoleId($role_id,$permissions)
    {
        date_default_timezone_set('UTC');
        $flag = false;
        //先刪掉再重新assign
        $stmt = $this->db->prepare('DELETE FROM `cc_rolepermissions` WHERE RoleID = :RoleID');
        $stmt->bindValue(':RoleID', $role_id);
        $result = $stmt->execute();

        if($result){
            foreach ($permissions as $key => $value) {
                $stmt = $this->db->prepare('INSERT INTO `cc_rolepermissions` (RoleID, PermissionID, AssignmentDate) VALUES (:RoleID, :PermissionID, :AssignmentDate)');
                $stmt->bindValue(':RoleID', $role_id);
                $stmt->bindValue(':PermissionID', $value);
                $stmt->bindValue(':AssignmentDate', date("Y-m-d H:i:s"));
                $flag = $stmt->execute();
            }
            return $flag;
        }else{
            return $flag;
        }


    }
    //delete role
    public function DeleteRole($role_id)
    {
        //如果角色已經被指派 就不能刪
        $stmt = $this->db->prepare('SELECT COUNT(*) as count FROM `cc_userroles` WHERE RoleID = :ID');
        $stmt->bindValue(':ID', $role_id);
        $stmt->execute();
        $row = $stmt->fetch();

        if ($row['count'] > 0) { // 角色已經被指派
            return false; 
        }else{ // job event已存在
            $stmt = $this->db->prepare('DELETE FROM `cc_roles` WHERE ID = :ID');
            $stmt->bindValue(':ID', $role_id);
            $results = $stmt->execute();

            //刪除role的permission
            $stmt = $this->db->prepare('DELETE FROM `cc_rolepermissions` WHERE RoleID = :ID');
            $stmt->bindValue(':ID', $role_id);
            $results = $stmt->execute();
            return true; // job event不存在
        }

    }
    //edit role
    public function EditRoleDetail()
    {
        // code...
    }
    //get singel role
    public function GetSingleRole()
    {
        // code...
    }
    //get all role
    public function GetAllRole()
    {
        $sql = "SELECT * FROM `cc_roles` ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;
    }
    //get role 
    public function GetRolePermissions($role_id)
    {
        $sql = "SELECT PermissionID FROM `cc_rolepermissions` WHERE RoleID = :RoleID ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':RoleID', $role_id);
        $statement->execute();
        $rows = $statement->fetchall(PDO::FETCH_ASSOC);

        return $rows;
    }


}
