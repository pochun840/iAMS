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
                <div class="row t1" style=" padding-left: 45%">
                    <button id="call-job" type="button" class="btn-calljob" style="font-size: 18px; color: #000;"  onclick="calljoball()" ><?php echo $text['Call_Job_text'];?></button>
                </div>
                <div class="border-bottom">
                    <div class="row t1">
                        <div class="col-5 t1" style=" padding-left: 2%; color: #000"><?php echo $text['Job_ID_text'];?>:</div>
                        <div class="col-4 t1">
                            <input id="job-id" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-5 t1" style="padding-left: 2%; color: #000"><?php echo $text['Job_Name_text'];?>:</div>
                        <div class="col-4 t1">
                            <input id="job-name" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-5 t1" style="padding-left: 2%; color: #000"><?php echo $text['Tool_SN_text'];?>:</div>
                        <div class="col-4 t1">
                            <input id="tool-sn" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                    <div class="row t1">
                       <div class="col-5 t1" style="padding-left: 2%; color: #000">Adapter Type:</div>
                        <div class="col-4 t1">
                            <input id="adapter-type" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                </div>

                <div class="w3-center" style="font-size: 18px; color: #000">Instant data setting</div>
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
                            <label class="t1 form-check-label" for="skip-turn-rev">Skip Turn Rev</label>
                        </div>
                    </div>
                    <div class="row t1" style="padding-left: 1%">
                       <div class="col-5 t1">Count:</div>
                        <div class="col-4 t1">
                            <input id="count" type="text" class="t2 form-control" value="0">
                        </div>
                    </div>
                </div>

                <div class="w3-center" style="font-size: 18px; color: #000">CM/CMK Bar</div>
                <div class="row t1" style="padding-left: 3%">
                    <div class="col t1 form-check form-check-inline">
                        <input class="t1 form-check-input" type="checkbox" name="auto-calculation" id="auto-calculation" value="1" style="zoom:1.0; vertical-align: middle;">&nbsp;&nbsp;
                        <label class="t1 form-check-label" for="auto-calculation"><?php echo $text['Auto_Calculation_text'];?></label>
                    </div>
                    <div class="col t1">
                        <button  style="float: right" id="calculate" type="button" class="btn-calculate">Calculate</button>
                    </div>
                </div>

                <div class="row t1">
                    <div class="col-7 t1"><b><?php echo $text['Target_Torque_text'];?></b></div>
                    <div class="col-4 t1">
                        <input id="standard-torque" type="text" class="t2 form-control" value="0.6">
                    </div>
                </div>

                <div class="row t1">
                    <div class="col-7 t1"><b>Tolerance(+/- %)</b></div>
                    <div class="col-4 t1">
                        <input id="tolerance" type="text" class="t2 form-control" value="+ 0.5">
                    </div>
                </div>

                <div class="row t1">
                   <br><br>
                   <button id="Connect" type="button" class="btn-calljob" style="font-size: 18px; color: #000;" onclick="Connect()"><?php echo $text['Test_text'];?></button>
                </div>
            </div>


            <!-- Right -->
            <div class="column column-right">
                <div id="column-right-header">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text">TQ:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <span class="input-group-text"><?php echo $text['RPM_text'];?>:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <span class="input-group-text">Offset:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <button id="Save-btn" type="button" class="btn-save-reset-undo" style="margin-right: 5%"><?php echo $text['Save_text'];?></button>
                        <button id="Reset" type="button" class="btn-save-reset-undo" onclick="reset()"><?php echo $text['Reset_text'];?></button>
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

                                <tbody style="background-color:#F5F5F5;" id="datainfo">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="chart-setting">
                    <div class="column column-chart">
                        <div class="chart-container" id='chart_block' style="display:none;">
                            <!---曲線圖---->
                            <div  id="mychart" width="500px" height="300px"></div>
                        </div>
                    </div>

                    <div class="column column-meter-model">
                        <div class="meter-model" id='item_data' style="display:none;">
                            <div class="row t1 border-bottom">
                                <div class="col-5" style=" padding-left: 5%; color: #000"><b>Item</b></div>
                                <div class="col-5" style=" padding-left: 5%; color: #000"><b>Meter</b></div>
                            </div>

                            <div class="scrollbar-meter" id="style-meter">
                                <div class="force-overflow-meter">
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Item:</div>
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
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Bias (+/-%):</div>
                                        <div class="col-5 t1">
                                            <input id="bias" type="text" class="t2 form-control" value="10">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Hi_Q_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="high-limit-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['hi_limit_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Lo_Q_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="low-limit-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['low_limit_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Max_Torque_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="max-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['max_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Min_Torque_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="min-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['min_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Avg_Torque_text'];?></div>
                                        <div class="col-5 t1">
                                            <input id="ave-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['avg_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $text['Standard_Deviation_text'];?>:</div>
                                        <div class="col-5 t1">
                                            <input id="standard-deviation" type="text" class="t2 form-control" value="<?php  echo $data['meter']['stddev1'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">CM:</div>
                                        <div class="col-5 t1">
                                            <input id="cm" type="text" class="t2 form-control" value="<?php  echo $data['meter']['cm'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">CMK:</div>
                                        <div class="col-5 t1">
                                            <input id="cmk" type="text" class="t2 form-control" value="<?php  echo $data['meter']['cmk'];?>">
                                        </div>
                                    </div>
                                    <?php for($i=1; $i<= $data['count']; $i++){?>
                                        <div class="row t1">
                                            <div class="col-5 t1" style=" padding-left: 5%; color: #000"><?php echo $i;?>:</div>
                                            <div class="col-5 t1">
                                                <input id="1" type="text" class="t2 form-control" value="<?php echo $data['meter']['res_total'][$i-1]['torque'];?>">
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

       
    <!-- Modal Call Job Select -->
    <div id="get_joball" class="lmodal" style="display: none">
        <div class="modal-lg" style="padding-left: 5%">
            <div class="lmodal-content" style="top: 140px; width: 670px;">
                <span class="lclose-btn" onclick="closeModal_job()">&times;</span>
                <span class="lclose-btn" onclick="closeModal_job()">&times;</span>
                <span class="lclose-btn" onclick="closeModal_job()">&times;</span>
                <div class="lmodal-column modalselect">
                    <h4>Job</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">
                             <?php foreach($data['job_arr'] as $k_job =>$v_job){?>
                            <div class="row t1"  style="padding-left: 5%">
                                <div class="col t2 form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="jobid" id="jobid" value="<?php echo $v_job['job_id'];?>" onclick="JobCheckbox()" style="zoom:1.0; vertical-align: middle;">&nbsp;
                                    <label class="form-check-label" for="jobid"><?php echo $v_job['job_name'];?></label>
                                </div>
                            </div>
                            <?php }?>
                        </div>
                    </div>
                </div>
                <div class="lmodal-column modalselect">
                    <h4>Sequence</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">
                            <div id="Seq-list" style="display: none">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="lmodal-column modalselect">
                    <h4>Task</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">
                            <div id="Task-list" style="display: none">
                            </div>
                        </div>
                    </div>
                </div>
                <button id='submit_check' onclick='submit_check()'>submit</button>
            </div>
        </div>
    </div>



<script>

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


function submit_check() {
    var job_id = "<?php echo $_COOKIE['job_id'] ?? '' ?>"; 
    var job_name = "<?php echo $_COOKIE['job_name'] ?? '' ?>"; 

    // 將作業 ID 和名稱設置到對應的 input 欄位中
    document.getElementById("job-id").value = job_id;
    document.getElementById("job-name").value = job_name;

    if (job_id) {
        $.ajax({
            url: "?url=Calibrations/get_data",
            method: "POST",
            data: {
                job_id: job_id 
            },
            success: function(response) {
                document.getElementById("datainfo").innerHTML = response;
                document.getElementById("get_joball").style.display = "none";
                document.getElementById("chart_block").style.display = "block";
                document.getElementById("item_data").style.display = "block";
            },
            error: function(xhr, status, error) {
                //console.error("Ajax request error:", error); 
            }
        });
    } else {
        //console.warn("job_id is empty or undefined.");
    }
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
    $(document).ready(function () {
        highlight_row('table');
        //highlight_row('barcode-table');
    });

function highlight_row(tableId) {
    var table = document.getElementById(tableId);
    var cells = table.getElementsByTagName('td');

    for (var i = 0; i < cells.length; i++) {
        // 遍历每个单元格
        var cell = cells[i];
        
        cell.onclick = function () {
            // 获取点击单元格所在的行
            var row = this.parentNode;

            var rows = table.getElementsByTagName('tr');

            // 从所有行中移除 'selected' 类
            for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
                rows[rowIndex].classList.remove('selected');
                // 可选：如果需要，也可以清除背景颜色
                rows[rowIndex].style.backgroundColor = "";
            }

            // 为点击的行添加 'selected' 类
            row.classList.add('selected');
            // 可选：如果需要，也可以设置背景颜色
            // row.style.backgroundColor = "red";

            // 如果需要隐藏某个 div（需要指定要隐藏的 div 和隐藏的方式）
            // document.getElementById('yourDivId').style.display = 'none';
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

function closeModal_job() {
    document.getElementById("get_joball").style.display = "none";

}
</script>


<?php require APPROOT . 'views/inc/footer.tpl'; ?>

<script>

    var myChart = echarts.init(document.getElementById('mychart'), null, {
        width: '500px',
        height: '300px',
        //marginTop: 50 
    });

    var x_val = <?php echo $data['echart']['x_val'];?>;
    var y_val = <?php echo $data['echart']['y_val'];?>;

    var option = {
        title: {
            text: ''
        },
        tooltip: {
            trigger: 'axis'
        },
        xAxis: {
            type: 'category',
            name :'Count',
            data: x_val,
        },
        yAxis: {
            type: 'value',
             name :'Torque',
        },
   
        series: [{
            name: 'Torque',
            type:'line',
            symbol: 'none',
            sampling: 'average',
            lineStyle: {width: 0.75},
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
                        offset: 0,
                        color: 'rgb(255,255,255)'
                    }])
                }
            },

            data: y_val,
        }]
    };

    myChart.setOption(option);
</script>
