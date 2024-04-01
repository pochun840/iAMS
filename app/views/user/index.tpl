<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/identification.css" type="text/css">

<?php echo $data['nav']; ?>

<style>
.t1{font-size: 17px; margin: 5px 0px; display: flex; align-items: center;}
.t2{font-size: 17px; margin: 5px 0px;}
.t3{font-size: 17px; margin: 3px 0px;}

</style>

<div class="container-ms">

    <header>
        <div class="identification">
            <img id="header-img " src="./img/user-head.svg"> Identification
        </div>

        <div class="notification">
            <i style="width:auto; height:40px" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel"><i style="width:auto; height: 40px;font-size: 26px" class="fa fa-user"></i> Esther</div>
    </header>

    <!-- Notification -->
    <div id="messageBox" class="messageBox" style="display: none;">
        <div class="topnav-message">
            <label type="text" style="font-size: 24px; padding-left: 3%; margin: 7px 0; color: #000"><b>Notification</b></label>
            <span class="close-message w3-display-topright" onclick="ClickNotification()">&times;</span>
        </div>
        <div class="scrollbar-message" id="style-message">
            <div class="force-overflow-message">
                <div style="padding: 0 10px; padding-bottom: 20px">
                    <div id="EquipmentWarning" style="font-size: 18px">
                        <a><b>Equipment Warning</b></a>
                        <a style="float: right">11m</a>
                    </div>
                    <div id="EW-Mess" style="font-size: 15px; padding-bottom: 5px" class="checkboxFour">
                        <a>recycle box: a-111s2 is reached the <br> threshold count for <a style="color: red">80%</a>. please reset recycle box.</a>
                        <a style="float: right; margin: 5px;">
                            <input type="checkbox" value="1" id="checkboxFourInput" name="" hidden="hidden" checked="checked">
                            <label for="checkboxFourInput"></label>
                        </a>
                    </div>
                    <div>
                        <label class="recyclebox">Recycle box</label>
                        <label class="workstation">workstation 3</label>
                    </div>
                </div>

                <div style="padding: 0 10px; padding-bottom: 20px">
                    <div id="EquipmentRecovery" style="font-size: 18px">
                        <a><b>Equipment recovery</b></a>
                        <a style="float: right">1m</a>
                    </div>
                    <div id="ER-Mess" style="font-size: 15px; padding-bottom: 5px" class="checkboxFour">
                        <a>recycle box: a-111s2 is clear the threshold count.</a>
                        <a style="float: right; margin: 5px;">
                            <input type="checkbox" value="1" id="checkboxFourInput" name="" hidden="hidden" checked="checked">
                            <label for="checkboxFourInput"></label>
                        </a>
                    </div>
                    <div>
                        <label class="recyclebox">Recycle box</label>
                        <label class="workstation">workstation 3</label>
                    </div>
                </div>

                <div style="padding: 0 10px; padding-bottom: 20px">
                    <div id="EquipmentRecovery" style="font-size: 18px">
                        <a><b>Equipment Warning</b></a>
                        <a style="float: right">2h</a>
                    </div>
                    <div id="ER-Mess" style="font-size: 15px; padding-bottom: 10px" class="checkboxFour">
                        <a>Controller:GTCS has............</a>
                        <a style="float: right; margin: 5px;">
                            <input type="checkbox" value="1" id="checkboxFourInput" name="" hidden="hidden" checked="checked">
                            <label for="checkboxFourInput"></label>
                        </a>
                    </div>
                    <div>
                        <label class="recyclebox">Recycle box</label>
                        <label class="workstation">workstation 3</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="center-content">
            <div class="wrapper">
                <div class="navbutton active" onclick="handleButtonClick(this, 'member')">
                    <span data-content="Member List" onclick="showContent('member')"></span>Member List
                </div>
                <div class="navbutton" onclick="handleButtonClick(this, 'role')">
                    <span data-content="Role Setting" onclick="showContent('role')"></span>Role Setting
                </div>
                <div class="navbutton" onclick="handleButtonClick(this, 'station')">
                    <span data-content="Station Setting" onclick="showContent('station')"></span>Station Setting
                </div>
            </div>

            <!-- Member List -->
            <div id="memberContent" class="content">
                <div class="w3-panel alert-light">
                    <label type="text" style="font-size: 22px; margin: 10px; color: #000"><b>Member List</b></label>

                    <button id="button-menulist" type="button"><img id="img-menulist" src="./img/dots-30.png" alt=""></button>

                    <button id="delete-member" type="button">
                        <img id="img-delete-member" src="./img/delete.svg" alt=""> Delete
                    </button>

                    <button id="add-memberlist" type="button" onclick="document.getElementById('AddMember').style.display='block'">
                        <img id="img-add-member" src="./img/add-member.svg" alt=""> Add member
                    </button>

                    <button id="Filter" type="button">
                        <img id="img-filter" src="./img/filter.svg" alt=""> Filter
                    </button>
                </div>

                <div class="table-container">
                    <div class="scrollbar" id="style-member">
                        <div class="scrollbar-force-overflow">
                            <table class="table table-bordered table-hover" id="member-table">
                                <thead id="header-table">
                                    <tr>
                                        <th style="width: 5%; text-align: center; vertical-align: middle;">
                                            <input type="checkbox" id="selectAll1" class="form-check-input" value="0" style="zoom:1.3">
                                        </th>
                                        <th style="width:10%;">ID</th>
                                        <th style="width:15%;">User Name</th>
                                        <th style="width:20%;">RFID Serial Number</th>
                                        <th style="width:10%;">Role</th>
                                        <th style="width:10%;">Group</th>
                                        <th style="width:25%;">Created Date</th>
                                        <th style="width:5%;">Edit</th>
                                    </tr>
                                </thead>

                                <tbody id="tbody1" style="background-color: #F2F1F1; font-size: 1.8vmin;">
                                    <tr style="text-align: center; vertical-align: middle;">
                                        <td style="text-align: center; vertical-align: middle;">
                                            <input class="form-check-input" type="checkbox" name="" id="" value="0" style="zoom:1.2">
                                        </td>
                                        <td>1</td>
                                        <td>Jimmy Lee</td>
                                        <td>123456789</td>
                                        <td>Super Admin</td>
                                        <td>RD</td>
                                        <td>2024-01-01</td>
                                        <td><img src="./img/user-edit.svg" style=" width: 35px; height: 35px"></td>
                                    </tr>

                                    <tr style="text-align: center; vertical-align: middle;">
                                        <td style="text-align: center; vertical-align: middle;">
                                            <input class="form-check-input" type="checkbox" name="" id="" value="0" style="zoom:1.2">
                                        </td>
                                        <td>1</td>
                                        <td>Esther</td>
                                        <td>123</td>
                                        <td>Super Admin</td>
                                        <td>RD</td>
                                        <td>2024-01-01</td>
                                        <td><img src="./img/user-edit.svg" style=" width: 35px; height: 35px"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Role Setting -->
            <div id="roleContent" class="content"  style="display: none;">
                <div id="AddRoleSetting" class="role-setting" >
                    <div class="w3-panel alert-light">
                        <label type="text" style="font-size: 22px; margin: 10px; color: #000"><b>Role</b></label>

                        <button id="role-permission-setting" type="button" onclick="NextToRolePermissionsSetting()">
                            <img id="img-user-setting" src="./img/user-setting.svg" alt="">
                        </button>

                        <button id="delete-button" type="button">
                            <img id="img-delete-role" src="./img/delete.svg" alt="">
                        </button>
                    </div>
                    <form id="form_add_role" onsubmit="addNewRole();return false;" method="post">
                        <div class="row t1" style=" padding-left: 5%">
                            <label for="role_name" class="col-2 t1">Add Role Name :</label>
                            <div class="col-2 t2" style="margin-left: -15px">
                                <input type="text" id="role_name" name="role_name" class="t3 form-control input-ms" maxlength="">
                            </div>
                            <div class="col t2">
                                <input id="add-roleName" class="t3" type="submit" name="add_role" value="Add">
                            </div>
                        </div>
                    </form>
                    <div class="row t1" style="padding-left: 5%">
                        <div for="role_name" class="col t1">Role Name :</div>
                    </div>

                    <div class="scrollbar-addRole" id="style-addRole">
                        <div class="AddRole-force-overflow">
                            <div class="row t1">
                                <div class="col-6 t2" style="padding-left: 20%">
                                    <ul class="rolelist t2" id="roleList">
                                        <li ondblclick="NextToRoleSetting(1)">1. super admin</li>
                                        <li ondblclick="NextToRoleSetting(2)">2. Admin</li>
                                        <li ondblclick="NextToRoleSetting(3)">3. leader</li>
                                        <li ondblclick="NextToRoleSetting(4)">4. operation</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--Role Edit Setting  -->
                <div class="role-edit" id="RoleEditSetting" style="display: none;">
                    <div class="w3-panel alert-light" style="line-height: 30px">
                        <label type="text" style="font-size: 24px; margin: 10px; color: #000"><b>Role<b style="font-size: 25px"> &gt;</b> Super admin setting</b></label>
                        <label type="text" style="font-size: 22px; margin: 10px; padding-left: 5%">
                            Role Name :
                            <input id="RoleName" class="t3" type="submit" name="RoleName" value="super admin" disabled="disabled" style="color: #000">
                        </label>

                        <button id="back-setting" type="button" onclick="cancelSetting()">
                            <img id="img-back" src="./img/back.svg" alt=""> Back
                        </button>
                        <button id="Bulk-Change" type="button" onclick="document.getElementById('BulkChange').style.display='block'">Bulk Change</button>
                    </div>
                    <div class="table-container">
                        <div class="scrollbar" id="style-RoleEdit">
                            <div class="force-overflow">
                                <table class="table table-bordered table-hover" id="RoleEdit-table">
                                    <thead id="header-table">
                                        <tr>
                                            <th style="width: 5%; text-align: center; vertical-align: middle;">
                                                <input type="checkbox" id="selectAll2" class="form-check-input" value="0" style="zoom:1.3">
                                            </th>
                                            <th style="width: 20%;">Member</th>
                                            <th style="width: 20%;">Serial Number</th>
                                            <th style="width: 20%;">Role</th>
                                        </tr>
                                    </thead>

                                    <tbody id="tbody2" style="background-color: #F2F1F1; font-size: 1.8vmin;">
                                        <tr style="text-align: center; vertical-align: middle;">
                                            <td style="text-align: center; vertical-align: middle;">
                                                <input class="select-checkbox form-check-input" type="checkbox" name="" id="" value="0" style="zoom:1.2">
                                            </td>
                                            <td style="text-align: center">Jimmy Lee</td>
                                            <td>123456789</td>
                                            <td>Super Admin</td>
                                        </tr>
                                        <tr style="text-align: center; vertical-align: middle;">
                                            <td style="text-align: center; vertical-align: middle;">
                                                <input class="select-checkbox form-check-input" type="checkbox" name="" id="" value="0" style="zoom:1.2">
                                            </td>
                                            <td style="text-align: center">Esther</td>
                                            <td>123</td>
                                            <td>Super Admin</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="RolePermissionSetting" class="role-setting" style="display: none">
                    <div class="w3-panel alert-light" style="line-height: 30px">
                        <label type="text" style="font-size: 24px; margin: 10px; color: #000"><b>Role<b style="font-size: 25px"> &gt;</b> Role permissions setting</b></label>

                        <button id="back-setting" type="button" onclick="cancelSetting()">
                            <img id="img-back" src="./img/back.svg" alt=""> Back
                        </button>
                    </div>

                    <div class="row" style=" padding-left: 5%">
                        <div for="Role-Permissions" class="col t3" style="font-size: 20px">
                            Role Name : &nbsp;<select id="controller_type" style="width: 200px; border: 1px solid #AAAAAA">
                                            <option value="0">Choose a role</option>
                                            <option value="1">Super admin</option>
                                            <option value="2">Administrator</option>
                                            <option value="3">operator</option>
                                    	    <option value="4">Foreman</option>
                                        </select></div>
                    </div>

                    <div class="Permissions_setting">
                        <div class="scrollbar-Permissions" id="style-Permissions">
                            <div class="Permissions-force-overflow">
                                <table class="w3-table w3-large table-station">
                                    <thead id="header-table" class="w3-large">
                                        <tr>
                                            <th width="25%">Permissions</th>
                                            <th>Owner</th>
                                            <th>Read</th>
                                            <th>Write</th>
                                            <th>Load</th>
                                            <th>Save</th>
                                            <th>Notification</th>
                                        </tr>
                                    </thead>
                                    <tbody class="tbody">
                                        <tr style="margin-bottom: 10px;">
                                            <td>Operation</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="01" type="checkbox" value="" name="" checked="checked">
                                                    <label for="01" style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="02" type="checkbox" value="" name="">
                                                    <label for="02" style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="03" type="checkbox" value="" name="">
                                                    <label for="03" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="04" type="checkbox" value="" name="">
                                                    <label for="04" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="05" type="checkbox" value="" name="">
                                                    <label for="05" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="06" type="checkbox" value="" checked="checked" name="">
                                                    <label for="06"></label>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Job</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="07" type="checkbox" value="" name="" checked="checked">
                                                    <label for="07" style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="08" type="checkbox" value="" name="" checked="checked">
                                                    <label for="08" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="09" type="checkbox" value="1" name="">
                                                    <label for="09" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="10" type="checkbox" value="1" name="">
                                                    <label for="10" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td></td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="11" type="checkbox" value="" checked="checked" name="">
                                                    <label for="11"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>identification<br> access management</td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="12" type="checkbox" value=""  name="" checked="checked">
                                                    <label for="12" style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="13" type="checkbox" value=""  name="" checked="checked">
                                                    <label for="13" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="14" type="checkbox" value="" name="">
                                                    <label for="14" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="15" type="checkbox" value=""  name="">
                                                    <label for="15" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="16" type="checkbox" value="" checked="checked" name="">
                                                    <label for="16"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive" style="margin-top: 10px">
                                                    <input id="17" type="checkbox" value="" checked="checked" name="">
                                                    <label for="17"></label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Program template</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="18" type="checkbox" value="" name="" checked="checked">
                                                    <label for="18" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="19" type="checkbox" value=""  name="" checked="checked">
                                                    <label for="19" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="20" type="checkbox" value=""  id="21" name="">
                                                    <label for="20" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="21" type="checkbox" value="" name="">
                                                    <label for="21" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="22" type="checkbox" value="" checked="checked" name="">
                                                    <label for="22"></label>
                                                </div>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Equipment</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="23" type="checkbox" value="" name="" checked="checked">
                                                    <label for="23"style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="24" type="checkbox" value="" name="">
                                                    <label for="24" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="25" type="checkbox" value="" checked="checked" id="21" name="">
                                                    <label for="25"></label>
                                                </div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Plugins</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="26" type="checkbox" value="" name="" checked="checked">
                                                    <label for="26"style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="27" type="checkbox" value="" name="">
                                                    <label for="27" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="28" type="checkbox" value="" checked="checked" id="21" name="">
                                                    <label for="28"></label>
                                                </div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Setting</td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="29" type="checkbox" value="" name="">
                                                    <label for="29"style="background-color: #DDDDDD"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="30" type="checkbox" value="" name="">
                                                    <label for="30" style="background-color: #D1E3FF"></label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkboxFive">
                                                    <input id="31" type="checkbox" value="" checked="checked" id="21" name="">
                                                    <label for="31"></label>
                                                </div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Calibration</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Notification</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <button class="saveButton" id="saveButton">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add New Member -->
    <div id="AddMember" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width: 80%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('AddMember').style.display='none'"
                        class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Add New Member</h3>
                </header>

                <div class="modal-body">
                    <form id="new_member_form" style="padding-left: 10%">
                        <div class="row">
                            <div for="user_name" class="col-4 t1">Name :</div>
                            <div class="col-4 t2">
                                <input type="text" class="form-control input-ms" id="user_name" maxlength="" >
                            </div>
                        </div>
                        <div class="row">
                            <div for="account" class="col-4 t1">Account :</div>
                            <div class="col-4 t2" >
                                <input type="text" class="form-control input-ms" id="account" maxlength="12" required>
                            </div>
                        </div>
                        <div class="row">
                            <div for="user-password" class="col-4 t1">Password :</div>
                            <div class="col-4 t2">
                                <input type="text" class="form-control input-ms" id="user-password" maxlength="12" required>
                            </div>
                        </div>
                        <div class="row">
                            <div for="Number-ID" class="col-4 t1">No :</div>
                            <div class="col-4 t2">
                                <input type="text" class="form-control input-ms" id="Number-ID" maxlength="" >
                            </div>
                        </div>
                        <div class="row">
                            <div for="card" class="col-4 t1">Card :</div>
                            <div class="col-4 t2">
                                <input type="text" class="form-control input-ms" id="card" maxlength="">
                            </div>
                        </div>
                        <div class="row">
                            <div for="serial-number" class="col-4 t1">Serial Number :</div>
                            <div class="col-4 t2">
                                <input type="text" class="form-control input-ms" id="serial-number" maxlength="">
                            </div>
                        </div>
                        <div class="row">
                            <div for="authority" class="col-4 t1">Authority :</div>
                            <div class="col t2">
                                <select id="controller_type" style="width: 169px">
               					    <option value="0">Choose a role</option>
               					    <option value="1">Super admin</option>
             					    <option value="2">Administrator</option>
            					    <option value="3">operator</option>
    	        				    <option value="4">Foreman</option>
                 				</select>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" >Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('AddMember').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bulk Change Modal -->
    <div id="BulkChange" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width: 90%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('BulkChange').style.display='none'"
                        class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Bulk Change</h3>
                </header>

                <div class="modal-body">
                    <form id="bulk_chage_form">
                        <div class="row">
                            <div for="selected_name" class="col-3 t1">Selected people :</div>
                            <div class="col t2">
                                <label>Jimmy Lee</label> ,
                                <label>Esther</label>
                            </div>
                        </div>

                        <div for="role_name" class="col-3 t1">Role Name :</div>
                        <div style="padding-left: 16%;">
                            <div class="row t1">
                   	            <div class="col-3 t3 form-check form-check-inline">
                                    <input class="t3 form-check-input" type="checkbox" checked="checked" name="Superadmin" id="Superadmin" value="0" style="zoom:1.2; vertical-align: middle">
                                    <label class="t3 form-check-label" for="Superadmin">Super admin</label>
                                </div>
                                <div class="col-3 t3 form-check form-check-inline">
                                    <input class="t3 form-check-input" type="checkbox" name="Administrator" id="Administrator" value="1" style="zoom:1.2; vertical-align: middle">
                                    <label class="t3 form-check-label" for="Administrator">Administrator</label>
                                </div>
                                <div class="col-3 t3 form-check form-check-inline">
                                    <input class="t3 form-check-input" type="checkbox" name="Operation" id="Operation" value="1" style="zoom:1.2; vertical-align: middle">
                                    <label class="t3 form-check-label" for="Operation">Operation</label>
                                </div>
                            </div>
                        </div>
                        <div style="padding-left: 16%;">
                            <div class="row t1">
                                <div class="col-3 t3 form-check form-check-inline">
                                    <input class="t3 form-check-input" type="checkbox" name="foreman" id="foreman" value="1" style="zoom:1.2; vertical-align: middle">
                                    <label class="t3 form-check-label" for="foreman">foreman</label>
                                </div>
                                <div class="col t3 form-check form-check-inline">
                                    <input class="t3 form-check-input" type="checkbox" name="QualityAssurance" id="QualityAssurance" value="0" style="zoom:1.2; vertical-align: middle">
                                    <label class="t3 form-check-label" for="QualityAssurance">Quality Assurance</label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" >Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('BulkChange').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

<script>
    // Select All
$(document).ready(function () {
        // Table 1
        $("#selectAll1").change(function () {
            $("#tbody1 input:checkbox").prop('checked', $(this).prop("checked"));
        });

        // Table 2
        $("#selectAll2").change(function () {
            $("#tbody2 input:checkbox").prop('checked', $(this).prop("checked"));
        });
    });

</script>

<script>

// menu nav button
function showContent(contentType)
{
    var contents = document.getElementsByClassName("content");
    for (var i = 0; i < contents.length; i++) {
        contents[i].style.display = "none";
    }

    var contentId = contentType + "Content";
    document.getElementById(contentId).style.display = "block";
}

function handleButtonClick(button, content)
{
    // Remove the active class from all navbuttons
    var buttons = document.querySelectorAll('.navbutton');
    buttons.forEach(function(btn) {
        btn.classList.remove('active');
    });

    // Add the active class to the clicked navbutton
    button.classList.add('active');

    // Call the function to display the content corresponding to the clicked navbutton
    showContent(content);
}

// Get the modal
var modal = document.getElementById('AddMember');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}


function addNewRole()
{
    var roleNameInput = document.getElementById('role_name');
    var roleList = document.getElementById('roleList');

    if (roleNameInput.value.trim() !== '')
    {
        var listItem = document.createElement('li');

        var rowIndex = roleList.getElementsByTagName('li').length + 1;
        var roleName = roleNameInput.value;
        var listItemText = rowIndex + '. ' + roleName;

        listItem.textContent = listItemText;

        roleList.appendChild(listItem);

        roleNameInput.value = '';
    }
}


// Next Role Permissions Setting
function NextToRolePermissionsSetting()
{
    // Show RoleEditSetting
    document.getElementById('RolePermissionSetting').style.display = 'block';

    // Hide AddRoleSetting
    document.getElementById('AddRoleSetting').style.display = 'none';
}

// Next Role Edit Setting
function NextToRoleSetting(roleIndex)
{
    // Show RoleEditSetting
    document.getElementById('RoleEditSetting').style.display = 'block';

    // Hide AddRoleSetting
    document.getElementById('AddRoleSetting').style.display = 'none';

    // You can use the roleIndex to customize the behavior based on the clicked role
    console.log('Double-clicked role:', roleIndex);
}

function cancelSetting() {
    var addRoleSetting = document.getElementById('AddRoleSetting');
    var roleEditSetting = document.getElementById('RoleEditSetting');
    var rolePermissionSetting = document.getElementById('RolePermissionSetting');

    // Check the current state and toggle accordingly
    if (roleEditSetting.style.display === 'block') {
        // If RoleEditSetting is currently displayed, switch to AddRoleSetting
        addRoleSetting.style.display = 'block';
        roleEditSetting.style.display = 'none';
    } else if (rolePermissionSetting.style.display === 'block') {
        // If RolePermissionSetting is currently displayed, switch to AddRoleSetting
        addRoleSetting.style.display = 'block';
        rolePermissionSetting.style.display = 'none';
    } else {
        // If AddRoleSetting is currently displayed or both are hidden, do nothing or handle it as needed
    }
}

/// Onclick event for row background color
$(document).ready(function () {
    // Call highlight_row function with table id
    highlight_row('member-table');
    highlight_row('RoleEdit-table');
});

function highlight_row(tableId)
{
    var table = document.getElementById(tableId);
    var cells = table.getElementsByTagName('td');

    for (var i = 0; i < cells.length; i++) {
        // Take each cell
        var cell = cells[i];
        // do something on onclick event for cell

        cell.onclick = function ()
        {
            // Get the row id where the cell exists
            var rowId = this.parentNode.rowIndex;

            var rowsNotSelected = table.getElementsByTagName('tr');
            for (var row = 0; row < rowsNotSelected.length; row++) {
                rowsNotSelected[row].style.backgroundColor = "";
                rowsNotSelected[row].classList.remove('selected');
            }
            var rowSelected = table.getElementsByTagName('tr')[rowId];
            // rowSelected.style.backgroundColor = "red";
            rowSelected.className += "selected";

            //hide div
        }
    }
}


// Notification ....................
let messageCount = 0;

function addMessage() {
    messageCount++;
    document.getElementById('messageCount').innerText = messageCount;
}

function ClickNotification() {
    let messageBox = document.getElementById('messageBox');
    let closeBtn = document.getElementsByClassName("close")[0];
    messageBox.style.display = (messageBox.style.display === 'block') ? 'none' : 'block';
}

addMessage();

</script>

<style type="text/css">
.selected
{
    background-color: #9AC0CD !important;
}

./*selected :hover{
    background-color: #9AC0CD;
}*/
</style>
</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>