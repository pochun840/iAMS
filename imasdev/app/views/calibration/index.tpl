<?php require APPROOT . 'views/inc/header.tpl'; ?>


<script src="<?php echo URLROOT; ?>js/echarts.min.js"></script>
<?php echo $data['nav']; ?>

<div class="container-ms">

    <header>
        <div class="calibration">
            <img id="header-img" src="./img/calibration-head.svg"><?php echo $text['main_calibration_text'];?>
        </div>
        <div class="notification">
            <i style="width:auto; height:40px" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel"><i style="width:auto; height: 40px;font-size: 26px" class="fa fa-user"></i> <?php echo $_SESSION['user']; ?></div>
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

    <div id="Torque-Collection">
        <div class="topnav">
            <label type="text" style="font-size: 24px; margin-bottom: 4px; padding-left: 10px"><?php echo $text['Calibrations_title_text'];?></label>
        </div>

        <div class="main-content">
            <div class="center-content">
                <div class="container-main">
                    <div class="row t1">
                        <div class="col-4 t1" style="padding-left: 7%; font-size: 18px"><?php echo $text['Choose_ktm_text'];?> :</div>
                        <div class="custom-select">
                            <select id="TorqueMeter">
                                <?php foreach($data['res_Torquemeter_arr'] as $k_t => $v_t){?>
                                    <option value="<?php echo $k_t;?>"><?php echo $v_t;?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="row t1">
                        <div class="col-4 t1" style="padding-left: 7%; font-size: 18px"><?php echo $text['Choose_Controller_text'];?> :</div>
                        <div class="custom-select">
                            <select id="controller_info">
                                 <?php foreach($data['res_controller_arr'] as $k_c =>$v_c){?>
                                    <option value="<?php echo $k_c;?>"><?php echo $v_c;?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <button class="nextButton" id="nextButton" onclick="NextToAnalysisSystemKTM()"><?php echo $text['Next_text'];?></button>
                </div>
            </div>
        </div>
    </div>

    <div id="analysis-system-KTM" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 24px; margin-bottom: 0px; padding-left: 10px"><?php echo $text['Calibrations_title_text'];?></label>
            <div class="topnav-right">
                <button class="btn" id="back-btn" type="button" onclick="backSetting()">
                    <img id="img-back" src="./img/back.svg" alt=""><?php echo $text['Back_text']; ?>
                </button>

                <button class="btn" id="export-report" type="button" onclick="openModal('Export_Report')"><?php echo $text['Export_text'];?></button>
                <!--<button class="btn" id="export-chart" type="button" onclick="openModal('Export_Chart')">Export Chart</button>-->
                <button class="btn" id="export-excel" type="button"  onclick="window.location.href = '?url=Calibrations/export_excel';"><?php echo $text['Export_Report_text'];?></button>
            </div>
        </div>

        <div class="container-fluid" id="container-fluid" >
            <!-- Left -->
            <div class="column column-left">
                <!--<div class="row t1" style=" padding-left: 45%">
                    <button id="call-job" type="button" class="btn-calljob" style="font-size: 18px; color: #000;"  onclick="calljoball()" ><?php echo $text['Call_Job_text'];?></button>
                </div>-->
                <div class="border-bottom">
                   
                    <div class="row t1">
                        <div class="col-5 t1" style="padding-left: 2%; color: #000"><?php echo $text['Tool_SN_text'];?>:</div>
                        <div class="col-4 t1">
                            <input id="tool-sn" type="text" class="t2 form-control" value="<?php echo $data['tools_sn'];?>">
                        </div>
                    </div>
                    <div class="row t1">
                       <div class="col-5 t1" style="padding-left: 2%; color: #000">Adapter Type:</div>
                        <div class="col-4 t1">
                            <input id="adapter_type" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                </div>

                <div class="w3-center" style="font-size: 18px; color: #000"><?php echo $text['Instant_data_setting_text'];?></div>
                <div class="border-bottom">
                    <div class="row t1" style="padding-left: 3%">
                        <div class="col t1 form-check form-check-inline">
                            <input class="t1 form-check-input" type="checkbox" checked="checked" name="auto-record" id="auto-record" value="1" style="zoom:1.0; vertical-align: middle;">&nbsp;&nbsp;
                            <label class="t1 form-check-label" for="auto-record"><?php echo $text['Auto_Record_text'];?></label>
                        </div>
                    </div>
                    <div class="row t1" style="padding-left: 3%">
                        <div class="col t1 form-check form-check-inline">
                            <input class="t1 form-check-input" type="checkbox" checked="checked" name="skip-turn-rev" id="skip-turn-rev" value="1" style="zoom:1.0; vertical-align: middle;">&nbsp;&nbsp;
                            <label class="t1 form-check-label" for="skip-turn-rev"><?php echo $text['Skip_Turn_Rev_text'];?></label>
                        </div>
                    </div>
                    <div class="row t1" style="padding-left: 1%">
                       <div class="col-5 t1"><?php echo $text['Count_text'];?>:</div>
                        <div class="col-4 t1">
                            <input id="count" type="text" class="t2 form-control" value="0">
                        </div>
                    </div>
                </div>

                <div class="w3-center" style="font-size: 18px; color: #000">CM/CMK Bar</div>
             

                <div class="row t1">
                    <div class="col-7 t1"><b><?php echo $text['Target_Torque_text'];?></b></div>
                    <div class="col-4 t1">
                        <input id="standard-torque" type="text" class="t2 form-control">
                    </div>
                </div>

                <div class="row t1">
                    <div class="col-7 t1"><b><?php echo $text['Tolerance_text'];?>(+/- %)</b></div>
                    <div class="col-4 t1">
                        <input id="tolerance" type="text" class="t2 form-control" value="+ 0.5">
                    </div>
                </div>

            
            </div>


            <!-- Right -->
            <div class="column column-right">
                <div id="column-right-header">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text"><?php echo $text['Target_Q_text'];?>:</span>
                        <input type="text" id= 'current_tarque'  name='current_tarque' class="form-control" style="margin-right: 5px">

                        <span class="input-group-text"><?php echo $text['RPM_text'];?>:</span>
                        <input type="text" id= 'current_rpm'  name= 'current_rpm'  class="form-control" style="margin-right: 5px">

                        <span class="input-group-text"><?php echo $text['Joint_Offset_text'];?>:</span>
                        <input type="text" id= 'current_offset'  name= 'current_offset'  class="form-control" style="margin-right: 5px">

                        <button id="Save-btn" type="button" class="btn-save-reset-undo" onclick='current_save()' style="margin-right: 5%"><?php echo $text['Save_text'];?></button>
                        <button id="Reset" type="button" class="btn-save-reset-undo"><?php echo $text['Reset_text']."_1";?></button>
                        <button id="Undo" type="button" class="btn-save-reset-undo" onclick="undo()" ><?php echo $text['Undo_text'];?></button>

                        <span class="input-group-text"><?php echo $text['Time_text'];?>:</span>
                        <input type="text" class="form-control">
                    </div>
                </div>

                <div id="table-setting">
                    <div class="scrollbar-table" id="style-table">
                        <div class="force-overflow-table">
                            <table class="table table-bordered table-hover" id="table">
                                <thead id="header-table" style="text-align: center; vertical-align: middle">
                                       <tr>
                                        <th><?php echo $text['Index_text'];?></th>
                                        <th><?php echo $text['Time_text'];?></th>
                                        <th><?php echo $text['Operator_text'];?></th>
                                        <th><?php echo $text['Tool_SN_text'];?></th>
                                        <th><?php echo $text['Torque_text'];?></th>
                                        <th><?php echo $text['Unit_text'];?></th>

                                        <th><?php echo $text['Max_Torque_text'];?></th>
                                        <th><?php echo $text['Min_Torque_text'];?></th>
                                        <th><?php echo $text['Avg_Torque_text'];?></th>
                                        <th>+ %</th>
                                        <th>- %</th>
                                        <th><?php echo $text['Customize_text'];?></th>
                                   
                                    </tr>
                                </thead>

                                <tbody style="background-color:#F5F5F5;" id="info_toal">
                                    <?php if (!empty($data['info'])){?>
                                        <?php foreach($data['info'] as $key => $val){?>
                                            <tr data-id="<?php echo $val['id']; ?>" >
                                                <td><?php echo $val['id']; ?></td>
                                                <td><?php echo $val['datatime']; ?></td>
                                                <td><?php echo $val['operator']; ?></td>
                                                <td><?php echo $val['toolsn']; ?></td>
                                                <td><?php echo $val['torque']; ?></td>
                                                <td><?php echo "N.m"; ?></td>
                                                <td><?php echo $val['max_torque']; ?></td>
                                                <td><?php echo $val['min_torque']; ?></td>
                                                <td><?php echo $val['avg_torque']; ?></td>
                                                <td><?php echo $val['high_percent'] . " % "; ?></td>
                                                <td><?php echo $val['low_percent'] . " % "; ?></td>
                                                <td><?php echo $val['customize']; ?></td>
                                            </tr>
                                        <?php } ?>
                                   <?php } ?> 
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>

                <div id="chart-setting">
                    <div class="column column-chart">
                        <div class="chart-container" id='chart_block' style="display:block;">
                            <!---曲線圖---->
                            <div  id="mychart" width="500px" height="300px"></div>
                        </div>
                    </div>

                    <div class="column column-meter-model">
                        <div class="meter-model" id='item_data' style="display:block;">
                            <div class="row t1 border-bottom">
                                <div class="col-5" style=" padding-left: 5%; color: #000"><b><?php echo $text['Item_text'];?></b></div>
                                <div class="col-5" style=" padding-left: 5%; color: #000"><b><?php echo $text['Meter_text'];?></b></div>
                            </div>

                            <div class="scrollbar-meter" id="style-meter">
                                <div class="force-overflow-meter">
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Item_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="item" type="text" class="t2 form-control" value="KTM-100(N.m)">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Target_Torque_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="target-torque" type="text" class="t2 form-control" value="0.6">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Bias_text'];?> (+/-%):</div>
                                        <div class="col-5 t1">
                                            <input id="bias" type="text" class="t2 form-control" value="10">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Hi_Q_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="high-limit-torque" type="text" class="t2 form-control" value="<?php echo htmlspecialchars($data['meter']['hi_limit_torque'] ?? '', ENT_QUOTES); ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Lo_Q_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="low-limit-torque" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['low_limit_torque']) ? $data['meter']['low_limit_torque'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Max_Torque_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="max-torquee" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['max-torque']) ? $data['meter']['max-torque'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Min_Torque_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="min-torque" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['min-torque']) ? $data['meter']['min-torque'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Avg_Torque_text'];?></div>
                                        <div class="col-5 t1">
                                            <input id="avg_torque" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['avg_torque']) ? $data['meter']['avg_torque'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Standard_Deviation_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="standard-deviation" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['stddev1']) ? $data['meter']['stddev1'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">CM:</div>
                                        <div class="col-5 t1">
                                             <input id="cm" type="text" class="t2 form-control" value="<?php echo !empty($data['meter']['cm']) ? $data['meter']['cm'] : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">CMK:</div>
                                        <div class="col-5 t1">
                                            <input id="cmk" type="text" class="t2 form-control" value="<?php  echo $data['meter']['cmk'];?>">
                                        </div>
                                    </div>
                                    <div id="input-container">
                                    <?php for($i=1; $i<= $data['count']; $i++){?>
                                        <div class="row t1">
                                            <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $i;?>:</div>
                                            <div class="col-5 t1">
                                                <input data-id="<?php echo $i;?>" type="text" class="t2 form-control" value="<?php echo $data['meter']['res_total'][$i-1]['torque'];?>">
                                            </div>
                                        </div>
                                    <?php } ?>
                                    </div>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Export Modal -->

   

    <!-- Modal Export Chart -->
    <div id="Export_Chart" class="modal" style="top: 10%" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content w3-animate-zoom">
                <h4>Export Chart</h4>
                <div class="row t1">
                    <div class="col-3 t1" for="fileName2">file name:</div>
                    <div class="col-6 t1">
                        <input id="fileName2" type="text" class="t1 form-control" value="">
                    </div>
                </div>
                <div class="row t1">
                    <div class="col-3 t1" for="Save-as2">Save as type:</div>
                    <div class="col t1">
                        <select id="Save-as2" style="width: 184px; height: 30px">
                            <option value="png">png</option>
                            <option value="jpg">jpg</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="ExportChart" class="style-button" onclick="pic_download()"><?php echo $text['Export_text'];?></button>
                    <button class="style-button" onclick="closeModal('Export_Chart')">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Export Report -->
    <div id="Export_Report" class="modal" style="top: 10%;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content w3-animate-zoom">
                <h4><?php echo $text['Export_Report_text'];?></h4>
                <div class="row t1">
                    <div class="col-3 t1" for="fileName3"><?php echo $text['file_name_text'];?>:</div>
                    <div class="col-6 t1">
                        <input id="fileName3" type="text" class="t1 form-control" value="">
                    </div>
                </div>
                <div class="row t1">
                    <div class="col-3 t1" for="Save-as3"><?php echo $text['Type_text'];?>:</div>
                    <div class="col t1">
                        <select id="Save-as3" style="width: 184px; height: 30px">
                            <option value="html">html</option>
                            <option value="xml">xml</option>
                            <option value="csv">excel</option>
                            <option value="jpg">jpg</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="Exportreport" class="style-button" onclick="html_download()"><?php echo $text['Export_text'];?></button>
                    <button class="style-button" onclick="closeModal('Export_Report')"><?php echo $text['Cancel_text'];?></button>
                </div>
            </div>
        </div>
    </div>

       
  

<script>
let lastData = null; 
var myChart; 

$(document).ready(function() {
    fetchLatestInfo();
    setInterval(fetchLatestInfo, 10000); // 每 10 秒更新
   
});


// Open modal
function openModal(modalId)
{
    document.getElementById(modalId).style.display = "flex";
}

// Close modal
function closeModal(modalId)
{
    document.getElementById(modalId).style.display = "none";
}

function exportCSV(modalId)
{

    var fileName = document.getElementById("fileName" + modalId[5]).value;
    var pageSize = document.getElementById("pageSize" + modalId[5]).value;


    closeModal(modalId);
}


function NextToAnalysisSystemKTM()
{

    //紀錄ktm  及 controller 型號

    var meter = document.getElementById("TorqueMeter").value;
    var controller_type = document.getElementById("controller_info").value;


    document.cookie = "meter=" + meter + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    document.cookie = "controller_type =" + controller_type  + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();

    // Show analysis-system-KTM
    document.getElementById('analysis-system-KTM').style.display = 'block';

    // Hide Torque-Collection
    document.getElementById('Torque-Collection').style.display = 'none';
}






function backSetting()
{
    var TorqueCollection = document.getElementById('Torque-Collection');
    var analysisSystemKTM = document.getElementById('analysis-system-KTM');

    // Check the current state and toggle accordingly
    if (analysisSystemKTM.style.display === 'block') {
        // If RoleEditSetting is currently displayed, switch to AddRoleSetting
        TorqueCollection.style.display = 'block';
        analysisSystemKTM.style.display = 'none';
    } else {
        // If AddRoleSetting is currently displayed or both are hidden, do nothing or handle it as needed
    }
}


function toggleMenu()
{
    var menuContent = document.getElementById("myMenu");
    menuContent.style.display = (menuContent.style.display === "block") ? "none" : "block";
}



// Change the color of a row in a table


function highlight_row(tableId) {
    var table = document.getElementById(tableId);
    var rows = table.getElementsByTagName('tr');

    for (var i = 0; i < rows.length; i++) {
        // 为每一行添加点击事件
        rows[i].onclick = function () {
            // 清除所有行的选中状态
            for (var j = 0; j < rows.length; j++) {
                rows[j].classList.remove('selected');
            }

            // 为当前行添加选中状态
            this.classList.add('selected');

            // 获取当前行的 data-id 属性
            var selectedId = this.getAttribute('data-id');

            // 调试输出
            console.log('Selected ID:', selectedId); // 打印到控制台
            alert('Selected ID: ' + selectedId);
        }
    }
}

$(document).ready(function () {
        alert('eewwe');
        highlight_row('info_toal');
});

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

function closeModal_job() {
    document.getElementById("get_joball").style.display = "none";

}


function selectSingle(checkbox) {
    const checkboxes = document.querySelectorAll('input[name="jobid"]');

    checkboxes.forEach((item) => {
        if (item !== checkbox) {
            item.checked = false; // 取消其他复选框的选中状态
        }
    });
}

function updateCookie(name, value, days) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}


function current_save() {
 
    let targetQ = document.getElementById('current_tarque').value;
    const rpm = document.getElementById('current_rpm').value;
    const offset = document.getElementById('current_offset').value;

    //const standardTorque = document.getElementById('standard-torque').value;

    //targetQ = standardTorque;
    const data = {
        target_q: targetQ,
        rpm: rpm,
        joint_offset: offset
    };

   $.ajax({
        url: "?url=Calibrations/current_save", 
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function(response) {
            //alert('保存成功！');
            console.log('Success:', response);

            document.getElementById('standard-torque').value = targetQ;
        },
        error: function(xhr, status, error) {
            alert('保存失敗：' + error);
            console.error('Error:', error);
        }
    });
}

function undo() {
    var status_val= '0';
    $.ajax({
        type: "POST",
        data: {
              status_val: status_val
              },
        url: '?url=Calibrations/del_all',
        success: function(response) {
            history.go(0);
        },
        error: function(error) {
        
        }
    }).fail(function () {

    });
    history.go(0); 
}




async function fetchData() {
        const url1 = 'http://192.168.0.161/imasdev/public/index.php?url=Calibrations/get_val';
        //const url2 = 'http://192.168.0.161/imasdev/public/index.php?url=Calibrations/get_data';

        try {
            
            const response1 = await fetch(url1, {
                method: 'GET', 
            });

            if (response1.ok) {
                const data = await response1.json(); 
                console.log('API 返回:', data);
                //document.getElementById('result').innerText = JSON.stringify(data, null, 2); 
            } else {
                console.error('请求失败，状态码:', response1.status);
                //document.getElementById('result').innerText = '请求失败，状态码: ' + response1.status;
            }

        
        } catch (error) {
            console.error('发生错误:', error);
            //document.getElementById('result').innerText = '发生错误: ' + error.message;
            //document.getElementById('datainfo').innerHTML = '发生错误: ' + error.message;
        }
    }

// 每 3 秒调用一次 fetchData

setInterval(fetchData, 3000);
fetchData();

function fetchLatestInfo() {
    $.ajax({
        url: '?url=Calibrations/get_latest_info', 
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            // 更新表格
            updateTable(data.info);
            
            // 更新曲線圖
            if (data.echart_data && data.echart_data.x_val && data.echart_data.y_val) {
                renderChart(data.echart_data.x_val, data.echart_data.y_val);
            } else {
                console.log('No echart data available.');
            }


            //更新右邊的扭力值(total)
            updateInputs(data.meter); 
        },
        error: function() {
            console.log('Error loading data');
        }
    });
}


function updateTable(data) {
    let tbody = $('#info_toal'); 
    tbody.empty(); 

    if (data.length > 0) {
        data.forEach(function(val) {
            tbody.append(`<tr data-id="${val.id}">
                <td>${val.id}</td>
                <td>${val.datatime}</td>
                <td>${val.operator}</td>
                <td>${val.toolsn}</td>
                <td>${val.torque}</td>
                <td>N.m</td>
                <td>${val.max_torque}</td>
                <td>${val.min_torque}</td>
                <td>${val.avg_torque}</td>
                <td>${val.high_percent} %</td>
                <td>${val.low_percent} %</td>
                <td>${val.customize}</td>
            </tr>`);
        });
    } else {
        tbody.append('<tr><td colspan="12" style="text-align: center;">No data available.</td></tr>');
    }
}


function updateInputs(meterData) {
    const container = document.getElementById('input-container'); 
    container.innerHTML = ''; 

    for (let i = 0; i < meterData.length; i++) {
        const torqueValue = meterData[i].torque; 
        const inputHTML = `
            <div class="row t1">
                <div class="col-5 t1" style="padding-left: 5%; color: #000">${i + 1}:</div>
                <div class="col-5 t1">
                    <input data-id="${i + 1}" type="text" class="t2 form-control" value="${torqueValue}">
                </div>
            </div>`;
        container.insertAdjacentHTML('beforeend', inputHTML); 
    }
}





let selectedId = null;

document.querySelectorAll('#info_toal tr').forEach(row => {
    row.addEventListener('click', function() {
        selectedId = this.getAttribute('data-id');

        const rows = document.querySelectorAll('#info_toal tr');
        rows.forEach(r => r.classList.remove('selected'));
        this.classList.add('selected');
    });
});

document.getElementById('Reset').addEventListener('click', function() {
    if (selectedId) {
        alert('Selected ID: ' + selectedId);
    } else {
        alert('No row selected.');
    }
});
</script>


<?php require APPROOT . 'views/inc/footer.tpl'; ?>

<script>

var x_val = <?php echo $data['echart']['x_val']; ?>; 
var y_val = <?php echo $data['echart']['y_val']; ?>; 

renderChart(x_val, y_val);

function renderChart(x_val, y_val) {

    if (!myChart) {
        myChart = echarts.init(document.getElementById('mychart'));
    }

    var option = {
        title: {
            text: ''
        },
        tooltip: {
            trigger: 'axis'
        },
        xAxis: {
            type: 'category',
            name: 'Count',
            data: x_val,
        },
        yAxis: {
            type: 'value',
            name: 'Torque',
        },
        series: [{
            name: 'Torque',
            type: 'line',
            symbol: 'none',
            sampling: 'average',
            lineStyle: {
                width: 0.75
            },
            itemStyle: {
                normal: {
                    color: 'rgb(255,0,0)'
                }
            },
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 0, [{
                        offset: 0,
                        color: 'rgb(255,255,255)'
                    }, {
                        offset: 1,
                        color: 'rgb(255,255,255)'
                    }])
                }
            },
            data: y_val,
        }]
    };

    myChart.setOption(option, true); 
}

</script>


<style>
.selected {
    background-color: #FFCCCB; /* 高亮的背景色 */
}
</style>
