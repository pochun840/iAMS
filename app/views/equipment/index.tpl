<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/equipment.css" type="text/css">

<?php echo $data['nav']; ?>

<style>
.t1{font-size: 18px; margin: 3px 0px; display: flex; align-items: center;}
.t2{font-size: 18px; margin: 3px 0px; width: 15vw;}

/* Modal add equipment */
.t3{font-size: 17px; margin: 3px 0px; display: flex; align-items: center; padding-left: 3%}
.t4{font-size: 15px; margin: 3px 0px;}
.t5{font-size: 15px; margin: 3px 0px; height: 30px;}

</style>

<div class="container-ms">

    <header>
        <div class="epuipment">
            <img id="header-img" src="./img/equipment-head.svg">Epuipment
        </div>

        <div class="notification">
            <i style=" width:auto; height: 40px;" class="fa fa-bell" onclick="ClickNotification()"></i>
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

    <div id="Equipment_Setting">
        <div id="add-menu-setting">
            <ul class="menu-add">
                <li style="float: right">
                    <button id="button_AddDevice" type="button">
                        <img id="img-device" src="./img/add-device.svg" alt="">Add Device
                    </button>

                    <ul class="submenu">
                        <li><a href="#" class="submenu-item">Kilews GTCS </a></li>
                        <li><a href="#" class="submenu-item">ARM</a></li>
                        <li><a href="#" class="submenu-item">Recycle box</a></li>
                        <li><a href="#" class="submenu-item">Pick to light</a></li>
                        <li><a href="#" class="submenu-item">Button</a></li>
                        <li><a href="#" class="submenu-item">Socket selector</a></li>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="scrollbar-epuipment" id="style-epuipment">
                <div class="force-overflow-epuipment">
                    <div class="center-content">
                        <!-- Device GTCS  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/GTCS.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; font-size:18px; padding-left: 5%">
                                <div style="font-size: 20px"><b>GTCS</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>
                            <!-- Message  -->
                            <div class="col-4" style="font-size:17px">
                                <form action="" id="device_Status">
                                    <div class="mt-1" style="text-align:left;line-height: 55px; color: #FF6633">
                                    </div>
                                </form>
                            </div>
                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox" checked />
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit" onclick="ShowDeviceEditSetting()"></i></a>
                            </div>
                        </div>

                        <!-- ARM  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/ep_picture.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; padding-left: 5%">
                                <div style="font-size: 20px"><b>ARM</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>
                            <!-- Message  -->
                            <div class="col-4" style="font-size:18px">
                                <form action="" id="arm_Status">
                                    <div class="mt-1" style="text-align: center;line-height: 55px">
                                        ---
                                    </div>
                                </form>
                            </div>
                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox">
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit" onclick="ShowARMSettingMode()"></i></a>
                            </div>
                        </div>

                        <!-- pick-to-light sensors  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/ep_picture.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; padding-left: 5%">
                                <div style="font-size: 20px"><b>pick-to-light sensors</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>

                            <!-- Message  -->
                            <div class="col-4" style="font-size:18px">
                                <form action="" id="Tool_Status">
                                    <div class="mt-1" style="text-align: center;line-height: 55px">
                                        ---
                                    </div>
                                </form>
                            </div>

                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox">
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit" onclick="ShowPickToLightSettingMode()"></i></a>
                            </div>
                        </div>

                        <!-- Tower light sensors  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/ep_picture.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; padding-left: 5%">
                                <div style="font-size: 20px"><b>Tower Light sensors</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>

                            <!-- Message  -->
                            <div class="col-4" style="font-size:18px">
                                <form action="" id="Tool_Status">
                                    <div class="mt-1" style="text-align: center;line-height: 55px">
                                        ---
                                    </div>
                                </form>
                            </div>

                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox">
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit" onclick="ShowTowerLightSettingMode()"></i></a>
                            </div>
                        </div>

                        <!-- KL-TCG  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/ep_picture.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; padding-left: 5%">
                                <div style="font-size: 20px"><b>KL-TCG</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>

                            <!-- Message  -->
                            <div class="col-4" style="font-size:18px">
                                <form action="" id="KL-TCG_Status">
                                    <div class="mt-1" style="text-align: center;line-height: 55px">
                                        ---
                                    </div>
                                </form>
                            </div>

                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox">
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit"></i></a>
                            </div>
                        </div>


                        <!-- Recycle box  -->
                        <div class="row epuipment-row">
                            <div class="col-1">
                                <img class="images" src="./img/ep_picture.png" alt="">
                            </div>
                            <div class="col-3" style="line-height: 32px; padding-left: 5%">
                                <div style="font-size: 20px"><b>Recycle box</b></div>
                                <div>V.1.1.0</div>
                                <div>Nov 11.23 10:55</div>
                            </div>

                            <!-- Message  -->
                            <div class="col-4" style="font-size:18px">
                                <form action="" id="Recycle-box_Status">
                                    <div class="mt-1" style="text-align: center;line-height: 55px">
                                        ---
                                    </div>
                                </form>
                            </div>

                            <div class="col">
                                <div class="simple-toggle">
                                    <label class="tgl" style="font-size:28px; float: right;">
                                        <input type="checkbox">
                                        <span data-on="&#10003;" data-off="&#10005;"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="col">
                                <a><i id="Remove" class="fa fa-minus-square-o"></i></a>
                                <a><i id="Edit" class="fa fa-edit" onclick="ShowRecycleboxSettingMode()"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- Device GTCS Ediet Setting -->
    <div id="Device_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">GTCS - picking connection setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>

        <div class="main-content">
            <div class="center-content">
                <div id="container">
                    <div class="wrapper" style=" top: 0">
                        <div class="navbutton active" onclick="handleButtonClick(this, 'connection')">
                            <span data-content="Connect setting" onclick="showContent('connection')"></span>Connect setting
                        </div>
                        <div class="navbutton" onclick="handleButtonClick(this, 'controller')">
                            <span data-content="Controller setting" onclick="showContent('controller')"></span>Controller setting
                        </div>
                        <div class="navbutton" onclick="handleButtonClick(this, 'information')">
                            <span data-content="Infomation" onclick="showContent('information')"></span>Infomation
                        </div>
                    </div>

                    <div id="connectionContent" class="content ">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="row t1">
                                <div class="col-1 t3">Name :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                                </div>
                            </div>

                            <div style="padding: 5px">
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    <b>Connection control</b>
                                </label>
                            </div>
                            <div class="row t3">
                                <div class="col-2 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">com 3</option>
                                        <option value="2">com 5</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">115200</option>
                                        <option value="2">57600</option>
                                        <option value="3">38400</option>
                                        <option value="4">9600</option>
                                        <option value="5">4800</option>
                                        <option value="6">2400</option>
                                        <option value="7">1200</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">None</option>
                                        <option value="2">Odd</option>
                                        <option value="2">Even</option>
                                        <option value="2">Mark</option>
                                        <option value="2">Space</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">8</option>
                                        <option value="2">7</option>
                                        <option value="3">6</option>
                                        <option value="4">5</option>
                                        <option value="5">4</option>
                                        <option value="6">3</option>
                                        <option value="7">2</option>
                                        <option value="8">1</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">10</option>
                                        <option value="2">4</option>
                                        <option value="3">1</option>
                                        <option value="4">3</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-3 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-TCP-IP">TCP/IP</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-1 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required >
                                </div>
                            </div>

                            <hr style="color: #000;border: 0.5px solid #000;">

                            <div>
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                    <b>Test adjust</b>
                                </label>
                            </div>
                            <div class="row t4">
                                <div class="col-3 t3">Status:
                                    <label style="color: red; padding-left: 5%"> offline/online</label>
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-Reconnect">Reconnect</button>
                                </div>
                            </div>
                            <div class="row t4">
                                <div class="col t3"><b>Communication log</b></div>
                            </div>
                            <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                                <div class="force-overflow-Communicationlog">
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                    </div>
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="controllerContent" class="content"  style="display: none;">
                        <div style="padding-left: 7%; padding: 60px">
                            <div class="col t1" style="padding: 10px"><b>Contrller Setting</b></div>
                            <div class="row t1">
                                <div class="col-2 t1" >ID :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-id" class="t2 form-control input-ms" value="1" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%;">Diskfull Warning(&#37;) :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="diskfull-warning" class="t2 form-control input-ms" value="80" maxlength="">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Name :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-name" class="t2 form-control input-ms" value="GTCS" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%;">Disk Storage Space :</div>
                                <div class="col progress t2" style="margin-top: 10px;padding-left:0;margin-right: 10px">
                                    <div id="disk_usage" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: 25%">X%</div>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Unit :</div>
                                <div class="col-3 t2">
                                    <select id="Torque-Unit" class="t2 Select-All" style="height: 35px; border: 1px solid  #BBBBBB; border-radius: 3px">
                                        <option value="2">N.m</option>
                                        <option value="1">Kgf.m</option>
                                        <option value="2">Kgf.cm</option>
                                        <option value="2">In.lbs</option>
                                    </select>
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Export data :</div>
                                <div class="col t2">
                                    <button class="export-impost-data w3-button w3-border w3-round-large" style="float: right">Copy data</button>
                                    <button class="export-impost-data w3-button w3-border w3-round-large" style="float: right">Export</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Language :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="language" class="t2 form-control input-ms" value="English" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Import data :</div>
                                <div class="col-3 t2">
                                    <input type="file" id="export-data-uploader" data-target="import-file-uploader" accept=".cfg" style="display: inline-block;" class="t2 form-control">
                                </div>
                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large" style="float: right">Import</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Torque Filter :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="torque-filter" class="t2 form-control input-ms" value="0.0" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Firmware update :</div>
                                <div class="col-3 t2">
                                    <input type="file" id="firmware-uploader" data-target="import-file-uploader" accept=".cfg" style="display: inline-block;" class="t2 form-control">
                                </div>
                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large" style="float: right">Firmware Update</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Batch Mode :</div>
                                <div class="switch menu col-3 t2">
                                    <input id="Batch-Mode" type="checkbox" checked>
                                    <label><i></i></label>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Blackout Recovery :</div>
                                <div class="switch menu col-3 t2">
                                    <input id="Blackout-Recovery" type="checkbox" checked>
                                    <label><i></i></label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="informationContent" class="content"  style="display: none;">
                        <div style="padding-left: 5%; padding: 60px">
                            <div class="row t1">
                                <div class="col-5 t1" style="padding: 10px;"><b>Tool Information</b></div>
                                <div class="col t1" style="padding: 10px; padding-left: 5%"><b>Controller Information</b></div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1" >Tool Type :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="tool-type" class="form-control input-ms" value="SGT-CS" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Controller S/N :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-sn" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Tool SN :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="tool-sn" class="form-control input-ms" value="PTS" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Controller Ver :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-version" class="form-control input-ms" value="1.25-J7" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">S/W Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="sw-version" class="form-control input-ms" value="1.09" maxlength="" disabled="disabled">
                                </div>

                               <div class="col-3 t1" style="padding-left: 12%">MCB Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="MCB-version" class="form-control input-ms" value="V02.91_T1_Svn369" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Total Counts :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="total-counts" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Image Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="image-version" class="form-control input-ms" value="V2.00" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Max Torque :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="max-torque" class="form-control input-ms" value="3.0" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Max Speed :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="max-speed" class="form-control input-ms" value="980" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Calibration Value :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="calibration-value" class="form-control input-ms" value="1.839" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Maintain Counts :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="maintain-counts" class="form-control input-ms" value="2289" maxlength="" disabled="disabled">
                                </div>

                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large">Refresh</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <button class="saveButton" id="saveButton">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ARM Edit Setting -->
    <div id="ARM_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">ARM Setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
        <div class="main-content">
            <div class="center-content">
                <div id="container">
                    <div class="wrapper" style="top: 0">
                        <div class="navbutton active" onclick="handleButtonClick(this, 'armconnection')">
                            <span data-content="Connect setting" onclick="showContent('armconnection')"></span>Connect setting
                        </div>
                        <div class="navbutton" onclick="handleButtonClick(this, 'armsteting')">
                            <span data-content="Arm Encoders setting" onclick="showContent('armsteting')"></span>Arm Encoders setting
                        </div>
                    </div>

                    <div id="armconnectionContent" class="content ">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="row t1">
                                <div class="col-1 t3">Name :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                                </div>
                            </div>

                            <div style="padding: 5px">
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    <b>Connection control</b>
                                </label>
                            </div>
                            <div class="row t3">
                                <div class="col-2 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">com 3</option>
                                        <option value="2">com 5</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">115200</option>
                                        <option value="2">57600</option>
                                        <option value="3">38400</option>
                                        <option value="4">9600</option>
                                        <option value="5">4800</option>
                                        <option value="6">2400</option>
                                        <option value="7">1200</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">None</option>
                                        <option value="2">Odd</option>
                                        <option value="2">Even</option>
                                        <option value="2">Mark</option>
                                        <option value="2">Space</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">8</option>
                                        <option value="2">7</option>
                                        <option value="3">6</option>
                                        <option value="4">5</option>
                                        <option value="5">4</option>
                                        <option value="6">3</option>
                                        <option value="7">2</option>
                                        <option value="8">1</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">10</option>
                                        <option value="2">4</option>
                                        <option value="3">1</option>
                                        <option value="4">3</option>
                                    </select>
                                </div>
                            </div>

                            <hr style="color: #000;border: 0.5px solid #000;">

                            <div class="row t4" style="padding-bottom: 10px">
                                <div class="col-3 t3">
                                    <label><b>Zero point calibration</b></label>
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-ZeroReset">Zero reset</button>
                                </div>
                            </div>

                            <div>
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                    <b>Test adjust</b>
                                </label>
                            </div>
                            <div class="row t4">
                                <div class="col-3 t3">Status:
                                    <label style="color: red; padding-left: 5%"> offline/online</label>
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-Reconnect">Reconnect</button>
                                </div>
                            </div>
                            <div class="row t4">
                                <div class="col t3"><b>Communication log</b></div>
                            </div>
                            <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                                <div class="force-overflow-Communicationlog">
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                    </div>
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="armstetingContent" class="content "  style="display: none;">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="scrollbar-Arm" id="style-Arm">
                                <div class="force-overflow">
                                    <div class="col t1" style="font-size: 20px; padding-left: 1%"><b>Screws</b></div>
                                    <div class="col t1" style="font-size: 20px; padding-left: 3%">Adjustment</div>
                                    <div style="padding-left: 5%">
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 1 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 2 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col t1" style="font-size: 20px; padding-left: 1%"><b>Screws Picking area</b></div>
                                    <div style="padding-left:5%">
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">picking area A. name :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col t1" style="font-size: 20px; padding-left: 3%">Adjustment</div>
                                    <div style="padding-left:5%" class="border-bottom">
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 1 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 2 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div style="padding-left:5%">
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">picking area B. name :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col t1" style="font-size: 19px; padding-left: 3%">Adjustment</div>
                                    <div style="padding-left:5%" class="border-bottom">
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 1 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 2 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div style="padding-left:5%">
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">picking area C. name :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col t1" style="font-size: 19px; padding-left: 3%">Adjustment</div>
                                    <div style="padding-left:5%" class="border-bottom">
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 1 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 2 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div style="padding-left:5%">
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">picking area D. name :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col t1" style="font-size: 19px; padding-left: 3%">Adjustment</div>
                                    <div style="padding-left:5%" class="border-bottom">
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 1 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" >Encoder 2 Tolerance setting :</div>
                                            <div class="col-3 t2">
                                                <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                            </div>
                                            <div class="col-3 t2">
                                                <button type="button" class="btn btn-Encoder">confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="saveButton" id="saveButton">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Pick To Light Edit Setting -->
    <div id="PickToLight_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">Pick-To-Light Setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
        <div class="center-content">
            <div id="container">
                <div class="wrapper" style="top: 0">
                    <div class="navbutton active" onclick="handleButtonClick(this, 'picktolight')">
                        <span data-content="Connect setting" onclick="showContent('picktolight')"></span>Connect setting
                    </div>
                    <div class="navbutton" onclick="handleButtonClick(this, 'picktolightsetting')">
                        <span data-content="Light setting" onclick="showContent('picktolightsetting')"></span>Light setting
                    </div>
                </div>

                <div id="picktolightContent" class="content">
                    <div style="padding-left: 7%; padding: 50px">
                        <div class="row t1">
                            <div class="col-1 t3">Name :</div>
                            <div class="col-2 t2">
                                <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                            </div>
                        </div>

                        <div style="padding: 5px">
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                <b>Connection control</b>
                            </label>
                        </div>
                        <div class="row t3">
                            <div class="col-2 t4 form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                            </div>
                        </div>

                        <div class="row t3">
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">com 3</option>
                                    <option value="2">com 5</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">115200</option>
                                    <option value="2">57600</option>
                                    <option value="3">38400</option>
                                    <option value="4">9600</option>
                                    <option value="5">4800</option>
                                    <option value="6">2400</option>
                                    <option value="7">1200</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">None</option>
                                    <option value="2">Odd</option>
                                    <option value="2">Even</option>
                                    <option value="2">Mark</option>
                                    <option value="2">Space</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">8</option>
                                    <option value="2">7</option>
                                    <option value="3">6</option>
                                    <option value="4">5</option>
                                    <option value="5">4</option>
                                    <option value="6">3</option>
                                    <option value="7">2</option>
                                    <option value="8">1</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">10</option>
                                    <option value="2">4</option>
                                    <option value="3">1</option>
                                    <option value="4">3</option>
                                </select>
                            </div>
                        </div>
                        <div class="row t3">
                            <div class="col-3 t4 form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="connection-control" id="Device-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.2; vertical-align: middle">&nbsp;
                                <label class="form-check-label" for="Device-TCP-IP">TCP/IP</label>
                            </div>
                        </div>
                        <div class="row t4">
                            <div class="col-2 t3">Network IP:</div>
                            <div class="col-2 t4" style="margin-left: -5%">
                                <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                            </div>
                            <div class="col-1 t3">Port:</div>
                            <div class="col-1 t4">
                                <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required>
                            </div>
                        </div>

                        <hr style="color: #000;border: 0.5px solid #000;">

                        <div>
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                <b>Test adjust</b>
                            </label>
                        </div>
                        <div class="row t4">
                            <div class="col-3 t3">Status:
                                <label style="color: red; padding-left: 5%"> offline/online</label>
                            </div>
                            <div class="col">
                                <button type="button" class="btn btn-Reconnect">Reconnect</button>
                            </div>
                        </div>
                        <div class="row t4">
                            <div class="col t3"><b>Communication log</b></div>
                        </div>
                        <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                            <div class="force-overflow-Communicationlog">
                                <div class="row t4">
                                    <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                </div>
                                <div class="row t4">
                                    <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="picktolightsettingContent" class="content" style="display: none">
                    <div class="label-text" style="padding-left: 7%; padding: 50px">
                        <div style="padding: 5px">
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    Light Setting
                            </label>
                        </div>
                    </div>
                </div>
                <button class="saveButton" id="saveButton">Save</button>
            </div>
        </div>
    </div>

    <!-- Tower Light Edit Setting -->
    <div id="TowerLight_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">Tower Light Setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
        <div class="center-content">
            <div id="container">
                <div class="wrapper" style="top: 0">
                    <div class="navbutton active" onclick="handleButtonClick(this, 'towerlight')">
                        <span data-content="Connect setting" onclick="showContent('towerlight')"></span>Connect setting
                    </div>
                    <div class="navbutton" onclick="handleButtonClick(this, 'towerlightsetting')">
                        <span data-content="Light setting" onclick="showContent('towerlightsetting')"></span>Light setting
                    </div>
                </div>

                <div id="towerlightContent" class="content">
                    <div style="padding-left: 7%; padding: 50px">
                        <div class="row t1">
                            <div class="col-1 t3">Name :</div>
                            <div class="col-2 t2">
                                <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                            </div>
                        </div>

                        <div style="padding: 5px">
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                <b>Connection control</b>
                            </label>
                        </div>
                        <div class="row t3">
                            <div class="col-2 t4 form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                            </div>
                        </div>

                        <div class="row t3">
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">com 3</option>
                                    <option value="2">com 5</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">115200</option>
                                    <option value="2">57600</option>
                                    <option value="3">38400</option>
                                    <option value="4">9600</option>
                                    <option value="5">4800</option>
                                    <option value="6">2400</option>
                                    <option value="7">1200</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">None</option>
                                    <option value="2">Odd</option>
                                    <option value="2">Even</option>
                                    <option value="2">Mark</option>
                                    <option value="2">Space</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">8</option>
                                    <option value="2">7</option>
                                    <option value="3">6</option>
                                    <option value="4">5</option>
                                    <option value="5">4</option>
                                    <option value="6">3</option>
                                    <option value="7">2</option>
                                    <option value="8">1</option>
                                </select>
                            </div>
                            <div class="col-1 t3">
                                <select id="unit" style="width: 110px">
                                    <option value="1">10</option>
                                    <option value="2">4</option>
                                    <option value="3">1</option>
                                    <option value="4">3</option>
                                </select>
                            </div>
                        </div>
                        <div class="row t3">
                            <div class="col-3 t4 form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="connection-control" id="Device-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.2; vertical-align: middle">&nbsp;
                                <label class="form-check-label" for="Device-TCP-IP">TCP/IP</label>
                            </div>
                        </div>
                        <div class="row t4">
                            <div class="col-2 t3">Network IP:</div>
                            <div class="col-2 t4" style="margin-left: -5%">
                                <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                            </div>
                            <div class="col-1 t3">Port:</div>
                            <div class="col-1 t4">
                                <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required>
                            </div>
                        </div>

                        <hr style="color: #000;border: 0.5px solid #000;">

                        <div>
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                <b>Test adjust</b>
                            </label>
                        </div>
                        <div class="row t4">
                            <div class="col-3 t3">Status:
                                <label style="color: red; padding-left: 5%"> offline/online</label>
                            </div>
                            <div class="col">
                                <button type="button" class="btn btn-Reconnect">Reconnect</button>
                            </div>
                        </div>
                        <div class="row t4">
                            <div class="col t3"><b>Communication log</b></div>
                        </div>
                        <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                            <div class="force-overflow-Communicationlog">
                                <div class="row t4">
                                    <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                </div>
                                <div class="row t4">
                                    <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="towerlightsettingContent" class="content" style="display: none">
                    <div class="label-text" style="padding-left: 7%; padding: 50px">
                        <div style="padding: 5px">
                            <label style="font-size: 18px">
                                <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    Light Setting
                            </label>
                        </div>

                        <div class="row t4">
                            <div class="col-2 t3">
                                <label>Type</label>
                            </div>
                            <div class="col-4 t3">
                                <label>Color Configuration</label>
                            </div>
                            <div class="col t3">
                                <label>Length of time</label>
                            </div>
                        </div>
                        <div class="row t4">
                            <div class="col-2 t3">
                                <label>OK</label>
                            </div>
                            <div class="col-4 t3">
                                <form action="" method="post" class="input-setting">
                                    <input type="color" id="Red" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Green" name="favcolor" value="#008000">
                                    <input type="color" id="Orange" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Blue" name="favcolor" value="#EEEEEE">
                                </form>
                                <button class="Buzzer-Button" id="OK-Buzzer">Buzzer</button>
                            </div>
                            <div class="col t3">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="OK-option" id="OK-solid-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="OK-solid-light" style="font-weight: normal;">solid light</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="OK-option" id="OK-flashing-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="OK-flashing-light" style="font-weight: normal;">flashing light</label>
                                </div>
                            </div>
                        </div>

                        <div class="row t4">
                            <div class="col-2 t3">
                                <label>NG</label>
                            </div>
                            <div class="col-4 t3">
                                <form action="" method="post" class="input-setting">
                                    <input type="color" id="Red" name="favcolor" value="#EE0000">
                                    <input type="color" id="Green" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Orange" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Blue" name="favcolor" value="#EEEEEE">
                                </form>
                                <button class="Buzzer-Button" id="NG-Buzzer">Buzzer</button>
                            </div>
                            <div class="col t3">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="NG-option" id="NG-solid-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="NG-solid-light" style="font-weight: normal;">solid light</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="NG-option" id="ok-flashing-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="ok-flashing-light" style="font-weight: normal;">flashing light</label>
                                </div>
                            </div>
                        </div>

                        <div class="row t4">
                            <div class="col-2 t3">
                                <label>OKALL</label>
                            </div>
                            <div class="col-4 t3">
                                <form action="" method="post" class="input-setting">
                                    <input type="color" id="Red" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Green" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Orange" name="favcolor" value="#FFA500">
                                    <input type="color" id="Blue" name="favcolor" value="#EEEEEE">
                                </form>
                                <button class="Buzzer-Button" id="OKALL-Buzzer" style="background-color: #1E90FF">Buzzer</button>
                            </div>
                            <div class="col t3">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="OKALL-option" id="OKALL-solid-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="OKALL-solid-light" style="font-weight: normal;">solid light</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="OKALL-option" id="OKALL-flashing-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="OKALL-flashing-light" style="font-weight: normal;">flashing light</label>
                                </div>
                            </div>
                        </div>

                        <div class="row t4">
                            <div class="col-2 t3">
                                <label>System Error</label>
                            </div>
                            <div class="col-4 t3">
                                <form action="" method="post" class="input-setting">
                                    <input type="color" id="Red" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Green" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Orange" name="favcolor" value="#EEEEEE">
                                    <input type="color" id="Blue" name="favcolor" value="#1E90FF">
                                </form>
                                <button class="Buzzer-Button" id="Error-Buzzer" style="background-color: #1E90FF">Buzzer</button>
                            </div>
                            <div class="col t3">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="Error-option" id="Error-solid-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="Error-solid-light" style="font-weight: normal;">solid light</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="Error-option" id="Error-flashing-light" value="" style="zoom:1.0; vertical-align: middle">
                                    <label class="form-check-label" for="Error-flashing-light" style="font-weight: normal;">flashing light</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="saveButton" id="saveButton">Save</button>
            </div>
        </div>
    </div>



    <!-- Recycle Box Edit Setting -->
    <div id="RecycleBox_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">Recycle Box Setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
        <div class="main-content">
            <div class="center-content">
                <div id="container">
                    <div class="wrapper" style=" top: 0">
                        <div class="navbutton" onclick="handleButtonClick(this, 'recyclebox')">
                            <span data-content="Connect setting" onclick="showContent('recyclebox')"></span>Connect setting
                        </div>
                        <div class="navbutton active" onclick="handleButtonClick(this, 'recycleboxsetting')">
                            <span data-content="Recycle box setting" onclick="showContent('recycleboxsetting')"></span>Recycle box setting
                        </div>
                    </div>

                    <!-- Warning alert -->
                    <div class="alert" id="alert">
                        <img class="images" src="./img/warning.svg" style="height: 35px; width: 35px; padding-right: 10px">
                        <strong>Warning!</strong> recyle box: a-111s2 is full. Please reset recycle box
                    </div>

                    <div id="recycleboxContent" class="content" style="display: none;">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="row t1">
                                <div class="col-1 t3">Name :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                                </div>
                            </div>

                            <div style="padding: 5px">
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    <b>Connection control</b>
                                </label>
                            </div>
                            <div class="row t3">
                                <div class="col-2 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">com 3</option>
                                        <option value="2">com 5</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">115200</option>
                                        <option value="2">57600</option>
                                        <option value="3">38400</option>
                                        <option value="4">9600</option>
                                        <option value="5">4800</option>
                                        <option value="6">2400</option>
                                        <option value="7">1200</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">None</option>
                                        <option value="2">Odd</option>
                                        <option value="2">Even</option>
                                        <option value="2">Mark</option>
                                        <option value="2">Space</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">8</option>
                                        <option value="2">7</option>
                                        <option value="3">6</option>
                                        <option value="4">5</option>
                                        <option value="5">4</option>
                                        <option value="6">3</option>
                                        <option value="7">2</option>
                                        <option value="8">1</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">10</option>
                                        <option value="2">4</option>
                                        <option value="3">1</option>
                                        <option value="4">3</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-3 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-TCP-IP">TCP/IP</label>
                                </div>
                            </div>
                            <div class="row t4">
                                <div class="col-2 t3">Network IP:</div>
                                <div class="col-2 t4" style="margin-left: -5%">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                                </div>
                                <div class="col-1 t3">Port:</div>
                                <div class="col-1 t4">
                                    <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required>
                                </div>
                            </div>

                            <hr style="color: #000;border: 0.5px solid #000;">

                            <div>
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                    <b>Test adjust</b>
                                </label>
                            </div>
                            <div class="row t4">
                                <div class="col-3 t3">Status:
                                    <label style="color: red; padding-left: 5%"> offline/online</label>
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-Reconnect">Reconnect</button>
                                </div>
                            </div>
                            <div class="row t4">
                                <div class="col t3"><b>Communication log</b></div>
                            </div>
                            <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                                <div class="force-overflow-Communicationlog">
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                    </div>
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="recycleboxsettingContent" class="content">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="col t1" style="font-size: 20px; padding-left: 1%"><b>Equipment Setting</b></div>
                            <div style="padding-left: 5%">
                                <div class="row t1">
                                    <div class="col-3 t1" >ID :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                    </div>
                                </div>
                                <div class="row t1">
                                    <div class="col-3 t1" >Name :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                    </div>
                                </div>
                                <div class="row t1">
                                    <div class="col-3 t1" >Max number of screw :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                    </div>
                                </div>
                                <div class="row t1">
                                    <div class="col-3 t1" >Threshold Type :</div>
                                    <div class="switch menu col-3 t2">
                                        <input id="Threshold-Type" type="checkbox" checked>
                                        <label><i></i></label>
                                    </div>
                                </div>
                                <div class="row t1">
                                    <div class="col-3 t1" >Threshold Warning(50%-80%) :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="" class="form-control input-ms" value="80%" maxlength="">
                                    </div>
                                </div>
                                <div class="row t1">
                                    <div class="col-3 t1" >Present number of screw :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="" class="form-control input-ms" value="" maxlength="">
                                    </div>
                                    <div class="col t2">
                                        <img class="images" src="./img/reset-alt.svg" style="height: 35px; width: 35px;">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <button class="saveButton" id="saveButton">Save</button>
                </div>
            </div>
        </div>
    </div>

<!-- modal Add Equipment SubMenu -->
<div class="modal"  id="myModal">
    <div class="modal-dialog">
        <div class="modal-content w3-animate-zoom">
            <header class="modal-header">
                <h4 id="modal_head" >Add GTCS</h4>
                <span class="close w3-display-topright">&times;</span>
            </header>
            <div class="modal-body">
                <div class="row t4">
                    <div class="col-2 t3">Name:</div>
                    <div class="col-4 t4">
                        <input type="text" class="t5 form-control input-ms" id="name" maxlength="" required>
                    </div>
                    <div class="col-2 t3">Module:</div>
                    <div class="col-3 t4">
                        <input type="text" class="t5 form-control input-ms" id="module" value="GTCS" maxlength="" required>
                    </div>
                </div>

                <hr style="color: #000;border: 0.5px solid #000;">

                <div>
                    <label style="font-size: 18px">
                        <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                        <b>Connection control</b>
                    </label>
                </div>
                <div class="row t3">
                    <div class="col-6 t4 form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="connection-control" id="modbus-RS232" value="1" style="zoom:1.0; vertical-align: middle">&nbsp;
                        <label class="form-check-label" for="modbus-RS232">Modbus RTU/RS232</label>
                    </div>
                </div>

                <div class="row t3">
                    <div class="col t4" style=" margin-right: 3px">
                        <select id="unit" style="width: 70px" class="t4">
                            <option value="1">com 3</option>
                            <option value="2">com 5</option>
                        </select>
                    </div>
                    <div class="col t4">
                        <select id="unit" style="width: 80px" class="t4">
                            <option value="1">115200</option>
                            <option value="2">57600</option>
                            <option value="3">38400</option>
                            <option value="4">9600</option>
                            <option value="5">4800</option>
                            <option value="6">2400</option>
                            <option value="7">1200</option>
                        </select>
                    </div>
                    <div class="col t4">
                        <select id="unit" style="width: 70px" class="t4">
                            <option value="1">None</option>
                            <option value="2">Odd</option>
                            <option value="2">Even</option>
                            <option value="2">Mark</option>
                            <option value="2">Space</option>
                        </select>
                    </div>
                    <div class="col t4">
                        <select id="unit" style="width: 50px" class="t4">
                            <option value="1">8</option>
                            <option value="2">7</option>
                            <option value="3">6</option>
                            <option value="4">5</option>
                            <option value="5">4</option>
                            <option value="6">3</option>
                            <option value="7">2</option>
                            <option value="8">1</option>
                        </select>
                    </div>
                    <div class="col t4">
                        <select id="unit" style="width: 50px" class="t4">
                            <option value="1">10</option>
                            <option value="2">4</option>
                            <option value="3">1</option>
                            <option value="4">3</option>
                        </select>
                    </div>
                </div>

                <div class="row t3">
                    <div class="col-6 t4 form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="connection-control" id="Modbus-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.0; vertical-align: middle">&nbsp;
                        <label class="form-check-label" for="Modbus-TCP-IP">Modbus TCP/IP</label>
                    </div>
                </div>

                <div class="row t4">
                    <div class="col-3 t3">Network IP:</div>
                    <div class="col-4 t4">
                        <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                    </div>
                    <div class="col-2 t3">Port:</div>
                    <div class="col-2 t4">
                        <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required>
                    </div>
                </div>

                <hr style="color: #000;border: 0.5px solid #000;">

                <div>
                    <label style="font-size: 18px">
                        <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                        <b>Test adjust</b>
                    </label>
                </div>
                <div class="row t4">
                    <div class="col-3 t3">Status:
                        <label style="color: red; padding-left: 5%"> offline/online</label>
                    </div>
                    <div class="col">
                        <button type="button" class="btn btn-Reconnect" style="float: right">Reconnect</button>
                    </div>
                </div>
                <div class="row t4">
                    <div class="col t3"><b>Communication log</b></div>
                </div>

                <div class="scrollbar-AddEquipmentlog" id="style-AddEquipmentlog">
                    <div class="force-overflow-AddEquipmentlog">
                        <div class="row t4">
                            <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                        </div>
                        <div class="row t4">
                            <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                        </div>
                    </div>
                </div>

                <div class="w3-center">
                    <button id="button1" class="btn btn-Addsave" onclick="new_task_save()">Save</button>
                </div>
            </div>

        </div>
    </div>
</div>
<script>
/// Modal Add Equipment
    var modal = document.getElementById("myModal");

    var closeBtn = document.getElementsByClassName("close")[0];

    var submenuItems = document.getElementsByClassName("submenu-item");

    Array.from(submenuItems).forEach(function (item) {
        item.addEventListener("click", function (event) {
            modal.classList.add("active");
        });
    });

    closeBtn.onclick = function () {
        modal.classList.remove("active");
    }

    window.onclick = function (event) {
        if (event.target == modal) {
            modal.classList.remove("active");
        }
    }
</script>

<script>
// Show Navbutton
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


//  Equipment Setting Mode
function ShowDeviceEditSetting()
{
    // Show Device Setting
    document.getElementById('Device_Edit_Setting').style.display = 'block';

    // Hide Equipment Setting
    document.getElementById('Equipment_Setting').style.display = 'none';
}

function ShowARMSettingMode()
{
    // Show ARM Setting
    document.getElementById('ARM_Edit_Setting').style.display = 'block';

    // Hide Equipment Setting
    document.getElementById('Equipment_Setting').style.display = 'none';
}

function ShowRecycleboxSettingMode()
{
    // Show Recyclebox Setting
    document.getElementById('RecycleBox_Edit_Setting').style.display = 'block';

    // Hide Equipment Setting
    document.getElementById('Equipment_Setting').style.display = 'none';
}

function ShowPickToLightSettingMode()
{
    // Show Pick To Light Setting
    document.getElementById('PickToLight_Edit_Setting').style.display = 'block';

    // Hide Equipment Setting
    document.getElementById('Equipment_Setting').style.display = 'none';
}

function ShowTowerLightSettingMode()
{
    // Show Tower Light Setting
    document.getElementById('TowerLight_Edit_Setting').style.display = 'block';

    // Hide Equipment Setting
    document.getElementById('Equipment_Setting').style.display = 'none';
}


function cancelSetting()
{
    var EquipmentSetting = document.getElementById('Equipment_Setting');
    var DeviceSetting = document.getElementById('Device_Edit_Setting');
    var ARMSetting = document.getElementById('ARM_Edit_Setting');
    var RecycleBoxSetting = document.getElementById('RecycleBox_Edit_Setting');
    var PickToLightSetting = document.getElementById('PickToLight_Edit_Setting');
    var TowerLightSetting = document.getElementById('TowerLight_Edit_Setting');

    // Check the current state and toggle accordingly
    if (DeviceSetting.style.display === 'block')
    {
        // If DeviceSetting is currently displayed, switch to EquipmentSetting
        EquipmentSetting.style.display = 'block';
        DeviceSetting.style.display = 'none';
    }
    else if (ARMSetting.style.display === 'block')
    {
        // If ARMSetting is currently displayed, switch to EquipmentSetting
        EquipmentSetting.style.display = 'block';
        ARMSetting.style.display = 'none';
    }
    else if (RecycleBoxSetting.style.display === 'block')
    {
        // If RecycleBoxSetting is currently displayed, switch to EquipmentSetting
        EquipmentSetting.style.display = 'block';
        RecycleBoxSetting.style.display = 'none';
    }
    else if (PickToLightSetting.style.display === 'block')
    {
        // If PickToLightSetting is currently displayed, switch to EquipmentSetting
        EquipmentSetting.style.display = 'block';
        PickToLightSetting.style.display = 'none';
    }
    else if (TowerLightSetting.style.display === 'block')
    {
        // If TowerLightSetting is currently displayed, switch to EquipmentSetting
        EquipmentSetting.style.display = 'block';
        TowerLightSetting.style.display = 'none';
    }
    else
    {
        // If EquipmentSetting is currently displayed or both are hidden, do nothing or handle it as needed
    }
}

// Warning alert
document.addEventListener("DOMContentLoaded", function()
{
    document.getElementById('alert').style.display = 'block';
    setTimeout(function()
    {
        document.getElementById('alert').style.display = 'none';
    }, 5000);
});


// Notification ....................
let messageCount = 0;

function addMessage() {
    messageCount++;
    document.getElementById('messageCount').innerText = messageCount;
}

function ClickNotification() {
    let messageBox = document.getElementById('messageBox');
    let closeBtn = document.getElementsByClassName("close-message")[0];
    messageBox.style.display = (messageBox.style.display === 'block') ? 'none' : 'block';
}

addMessage();

</script>

</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>