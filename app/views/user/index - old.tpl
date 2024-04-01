<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">

<?php echo $data['nav']; ?>

<div class="container">
    <h1>使用者管理</h1>

     <!-- 使用者新增表單 -->
     <h2>新增使用者</h2>
     <form onsubmit="add_account();return false;"  method="post">
         <input type="text" id="user_account" name="user_account" placeholder="帳號" required>
         <input type="password" id="user_password" name="user_password" placeholder="密碼" required>
         <br>
         <input type="text" id="user_name" name="user_name" placeholder="使用者名稱" required>
         <br>
         <select id="user_role" name="role">
             <?php
             foreach ($data['all_roles'] as $role) {
                 echo "<option value='{$role['ID']}'>{$role['Title']}</option>";
             }
             ?>
         </select>
         <br>
         <input type="submit" id="add_user" name="add_user" value="新增使用者">
     </form>

     <hr>

     <!-- 使用者列表 -->
     <h2>使用者列表</h2>
     
     <ul>
        <?php foreach ($data['all_users'] as $key => $value) {
            echo "<li> (account: ".$value['account'].") <button type=\"button\" onclick=\"load_user('".$value['id']."');\">load</button> <button type=\"button\" onclick=\"delete_user('".$value['id']."');\">delete</button></li>";
        } ?>
        <!-- <button type="button" onclick="edit_user('start');">edit</button>
        <button type="button" onclick="delete_user('start');">delete</button> -->
      <!--   <li> (角色: ) <a href='user_management.php?delete_user='>删除</a></li>
        <li> (角色: ) <a href='user_management.php?delete_user='>删除</a></li>
        <li> (角色: ) <a href='user_management.php?delete_user='>删除</a></li> -->
     </ul>

     <hr>

     <form id="user_edit" onsubmit="edit_account();return false;" method="post">
        <label for="username">帳號:</label>
        <input type="text" id="username" name="username" value="" required disabled>

        <label for="password">密碼:</label>
        <input type="password" id="password" name="password" value="" >

        <label for="password">驗證密碼:</label>
        <input type="password" id="password_confirm" name="password_confirn" value="" >

        <label for="name">名稱:</label>
        <input type="text" id="name" name="name" value="" required>

        <label for="edit_role">角色:</label>
        <select id="edit_role" >
             <?php
             foreach ($data['all_roles'] as $role) {
                 echo "<option value='{$role['ID']}'>{$role['Title']}</option>";
             }
             ?>
         </select>
        <input type="text" id="user_id" value="" disabled style="display: none;">
        <input type="submit" name="edit_user" value="edit">
    </form>

    <hr>
    <!-- -------------------------------------------------------------------------------- -->

    <h1>角色管理</h1>

     <!-- 新增角色表單 -->
     <h2>新增角色</h2>
     <form id="form_add_role" onsubmit="add_new_role();return false;" method="post">
         <label for="role_name">角色名稱:</label>
         <input type="text" id="role_name" name="role_name" required>
         <input type="submit" name="add_role" value="新增角色">
     </form>

     <!-- 角色列表 -->
     <h2>角色列表</h2>
     <ul>
         <?php
         // 顯示角色列表
         foreach ($data['all_roles'] as $role) {
             echo "<li>{$role['Title']} <a href='javascript:void(0);' onclick=\"delete_role('{$role['ID']}')\">刪除</a>
             <button type=\"button\" onclick=\"load_role('".$role['ID']."');\">load</button>
             </li>";
         }
         ?>
     </ul>

     <!-- 設定角色權限 -->
     <h2>設定角色權限</h2>
     <form onsubmit="set_role_permissions();return false;" method="post">
         <label for="selected_role_permission">選擇角色:</label>
         <select id="selected_role_permission" name="selected_role_permission">
            <option value="-1"></option>
             <?php
             foreach ($data['all_roles'] as $role) {
                 echo "<option value='{$role['ID']}'>{$role['Title']}</option>";
             }
             ?>
         </select>

         <h3>選擇權限:</h3>
         <?php
         // 顯示權限列表，並使用複選框來控制權限
         $permissions = array("Create", "Read", "Update", "Delete"); // 從資料庫取得權限列表
         foreach ($permissions as $permission) {
            // echo "<label><input type='checkbox' name='permissions[]' value='$permission'>$permission</label><br>";
         }

         foreach ($data['permission_list'] as $permission) {
            echo "<label><input type='checkbox' id='permissions_{$permission['ID']}' name='permissions' value='{$permission['ID']}'>{$permission['Title']}</label><br>" ;
         }
         ?>
        
         <input type="submit" name="set_permissions" value="設定權限">
     </form>

</div>

<script type="text/javascript">
    function add_account() {
        let user_account = document.getElementById('user_account').value;
        let user_password = document.getElementById('user_password').value;
        let user_name = document.getElementById('user_name').value;
        let add_user = document.getElementById('add_user').value;
        let user_role = document.getElementById('user_role').value;

        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'user_account': user_account,
                'user_password': user_password,
                'user_name': user_name,
                'add_user': add_user,
                'role': user_role,
                 },
            dataType: "json",
            url: "?url=Users/add_user",
        }).done(function(notice) { //成功且有回傳值才會執行
            if (notice.error != '') {
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: notice.error,
                })
            } else {
                Swal.fire('Saved!', '', 'success');
                window.location = window.location.href;
            }
        }).fail(function () {
            history.go(0);//失敗就重新整理
        });
    }

    function load_user(user_id){

        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'user_id': user_id
                 },
            dataType: "json",
            url: "?url=Users/get_user_by_id",
        }).done(function(data) { //成功且有回傳值才會執行
            if (data.error != '') {             
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: notice.error,
                })
            } else {
                document.getElementById('username').value = data.account;
                document.getElementById('name').value = data.name;
                document.getElementById('edit_role').value = data.RoleID;
                document.getElementById('user_id').value = data.id;
            }
            console.log(data);
        }).fail(function () {
            history.go(0);//失敗就重新整理
        });

    }

    function delete_user(user_id){
        $.ajax({ // 提醒
                type: "POST",
                data: { 
                    'user_id': user_id,
                     },
                dataType: "json",
                url: "?url=Users/delete_user",
            }).done(function(notice) { //成功且有回傳值才會執行
                if (notice.error != '') {
                    // Swal.fire({ // DB sync notice
                    //     title: 'Error',
                    //     text: notice.error,
                    // })
                } else {
                    // Swal.fire('Saved!', '', 'success');
                    // document.getElementById('agent_server_ip').value = '';
                    // window.location = window.location.href;
                    history.go(0);
                }
            }).fail(function () {
                // history.go(0);//失敗就重新整理
            });
    }

    function edit_account(argument) {
        let user_password = document.getElementById('password').value;
        let password_confirm = document.getElementById('password_confirm').value;
        let user_name = document.getElementById('name').value;
        let user_id = document.getElementById('user_id').value;
        let user_role = document.getElementById('edit_role').value;

        if (user_password != password_confirm ) {
            alert('兩次密碼不相同');
            document.getElementById('password').value = '';
            document.getElementById('password_confirm').value = '';
        }else{
            $.ajax({ // 提醒
                type: "POST",
                data: { 
                    'user_id': user_id,
                    'user_password': user_password,
                    'user_name': user_name,
                    'role': user_role,
                     },
                dataType: "json",
                url: "?url=Users/edit_user",
            }).done(function(notice) { //成功且有回傳值才會執行
                if (notice.error != '') {
                    // Swal.fire({ // DB sync notice
                    //     title: 'Error',
                    //     text: notice.error,
                    // })
                } else {
                    // Swal.fire('Saved!', '', 'success');
                    // document.getElementById('agent_server_ip').value = '';
                    // window.location = window.location.href;
                    history.go(0);
                }
            }).fail(function () {
                // history.go(0);//失敗就重新整理
            });
        }
    }

    // ----- role function ---------

    function add_new_role(argument) {
        let role_name = document.getElementById('role_name').value;
        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'role_name': role_name
                 },
            dataType: "json",
            url: "?url=Users/add_new_role",
        }).done(function(data) { //成功且有回傳值才會執行
            if (data.error != '') {             
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: notice.error,
                })
            } else {
                document.getElementById('role_name').value = '';
                history.go(0);
            }
            console.log(data);
        }).fail(function () {
            history.go(0);//失敗就重新整理
        });
    }

    function delete_role(role_id){
        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'role_id': role_id
                 },
            dataType: "json",
            url: "?url=Users/delete_role",
        }).done(function(data) { //成功且有回傳值才會執行
            if (data.error != '') {             
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: data.error,
                })
            } else {
                history.go(0);
            }
            console.log(data);
        }).fail(function () {
            history.go(0);//失敗就重新整理
        });
    }


    function set_role_permissions() {
        let role_permissions = [];
        $("input:checkbox[name=permissions]:checked").each(function(){
            role_permissions.push($(this).val());
        });

        console.log(role_permissions);

        let role_id = document.getElementById('selected_role_permission').value;
        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'role_id': role_id,
                'role_permissions': role_permissions
                 },
            dataType: "json",
            url: "?url=Users/edit_role_permission_by_id",
        }).done(function(data) { //成功且有回傳值才會執行
            if (data.error != '') {             
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: data.error,
                })
            } else {
                history.go(0);
            }
        }).fail(function () {
            // history.go(0);//失敗就重新整理
        });

    }

    function load_role(role_id) {
        document.getElementsByName('permissions').forEach(el => el.checked = false);//unchecked all checkbox
        document.getElementById('selected_role_permission').value = role_id;
        
        $.ajax({ // 提醒
            type: "POST",
            data: { 
                'role_id': role_id
                 },
            dataType: "json",
            url: "?url=Users/get_role_permission_by_id",
        }).done(function(data) { //成功且有回傳值才會執行
            if (data.error != '') {             
                Swal.fire({ // DB sync notice
                    title: 'Error',
                    text: data.error,
                })
            } else {
                
                for(var k in data) {
                   if(data[k]['PermissionID'] != undefined ){
                       document.getElementById('permissions_'+data[k]['PermissionID']).checked = true;
                   }
                }

            }
        }).fail(function () {
            // history.go(0);//失敗就重新整理
        });
    }


</script>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>