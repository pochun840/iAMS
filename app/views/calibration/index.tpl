<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<script defer src="<?php echo URLROOT; ?>/js/chart.min.js"></script>
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/calibration.css?v=202405221200" type="text/css">

<script src="<?php echo URLROOT; ?>js/echarts_min.js?v=202405080900"></script>
<script src="<?php echo URLROOT; ?>js/html2canvas_min.js?v=202405080900"></script>
<script src="<?php echo URLROOT; ?>js/chart_share.js?v=202405151200"></script>
<script src="<?php echo URLROOT; ?>js/calibrations.js?v=202405210900"></script>


<?php echo $data['nav']; ?>

<div class="container-ms">

    <header>
        <div class="calibration">
            <img id="header-img" src="./img/calibration-head.svg">Calibration
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

    <div id="Torque-Collection">
        <div class="topnav">
            <label type="text" style="font-size: 24px; margin-bottom: 4px; padding-left: 10px">Torque collection and analysis system</label>
        </div>

        <div class="main-content">
            <div class="center-content">
                <div class="container-main">
                    <div class="row t1">
                        <div class="col-4 t1" style="padding-left: 7%; font-size: 18px">Torque Meter :</div>
                        <div class="custom-select">
                            <select id="TorqueMeter">
                                <?php foreach($data['res_Torquemeter_arr'] as $k_t => $v_t){?>
                                    <option value="<?php echo $k_t;?>"><?php echo $v_t;?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="row t1">
                        <div class="col-4 t1" style="padding-left: 7%; font-size: 18px">Controller :</div>
                        <div class="custom-select">
                            <select class="selectem">
                                 <?php foreach($data['res_controller_arr'] as $k_c =>$v_c){?>
                                    <option value="<?php echo $k_c;?>"><?php echo $v_c;?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <button class="nextButton" id="nextButton" onclick="NextToAnalysisSystemKTM()">Next &#10144;</button>
                </div>
            </div>
        </div>
    </div>

    <div id="analysis-system-KTM" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 24px; margin-bottom: 0px; padding-left: 10px">Torque collection and analysis system-KTM</label>
            <div class="topnav-right">
                <button class="btn" id="back-btn" type="button" onclick="backSetting()">
                    <img id="img-back" src="./img/back.svg" alt="">back
                </button>

                <button class="btn" id="export-report" type="button" onclick="openModal('Export_Report')">Export Report</button>
                <button class="btn" id="export-chart" type="button" onclick="openModal('Export_Chart')">Export Chart</button>
                <button class="btn" id="export-excel" type="button" onclick="openModal('Export_CSV')">Export CSV</button>
            </div>
        </div>

        <div class="container-fluid" id="container-fluid" >
            <!-- Left -->
            <div class="column column-left">
                <div class="row t1" style=" padding-left: 45%">
                    <button id="call-job" type="button" class="btn-calljob" style="font-size: 18px; color: #000;"  onclick="calljoball()" >Call Job</button>
                </div>
                <div class="border-bottom">
                    <div class="row t1">
                        <div class="col-5 t1" style=" padding-left: 2%; color: #000">Job ID:</div>
                        <div class="col-4 t1">
                            <input id="job-id" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-5 t1" style="padding-left: 2%; color: #000">Job Name:</div>
                        <div class="col-4 t1">
                            <input id="job-name" type="text" class="t2 form-control" value="">
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-5 t1" style="padding-left: 2%; color: #000">Tool SN:</div>
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
                            <label class="t1 form-check-label" for="auto-record">Auto Record</label>
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
                        <label class="t1 form-check-label" for="auto-calculation">Auto Calculation</label>
                    </div>
                    <div class="col t1">
                        <button  style="float: right" id="calculate" type="button" class="btn-calculate">Calculate</button>
                    </div>
                </div>

                <div class="row t1">
                    <div class="col-7 t1"><b>Target Torque</b></div>
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
                   <button id="Connect" type="button" class="btn-calljob" style="font-size: 18px; color: #000;" onclick="Connect()">Connect</button>
                </div>
            </div>


            <!-- Right -->
            <div class="column column-right">
                <div id="column-right-header">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text">TQ:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <span class="input-group-text">RPM:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <span class="input-group-text">Offset:</span>
                        <input type="text" class="form-control" style="margin-right: 5px">

                        <button id="Save-btn" type="button" class="btn-save-reset-undo" style="margin-right: 5%">Save</button>
                        <button id="Reset" type="button" class="btn-save-reset-undo" onclick="reset()">Reset</button>
                        <button id="Undo" type="button" class="btn-save-reset-undo" onclick="undo()" >Undo</button>

                        <span class="input-group-text">Received Time:</span>
                        <input type="text" class="form-control">
                    </div>
                </div>

                <div id="table-setting">
                    <div class="scrollbar-table" id="style-table">
                        <div class="force-overflow-table">
                            <table class="table table-bordered table-hover" id="table">
                                <thead id="header-table" style="text-align: center; vertical-align: middle">
                                       <tr>
                                        <th>Recv<br>No</th>
                                        <th>Recv. Time</th>
                                        <th>Operator</th>
                                        <th>Tool S/N</th>
                                        <th>Torque</th>
                                        <th>Unit</th>

                                        <th>Max<br>Torque</th>
                                        <th>Min<br>Torque</th>
                                        <th>Avg<br>Torque</th>
                                        <th>+ %</th>
                                        <th>- %</th>
                                        <th>Customize</th>
                                   
                                    </tr>
                                </thead>

                                <tbody style="background-color:#F5F5F5;" id="datainfo">

                                    <?php foreach($data['info'] as $key => $val){ ?>
                                        <tr style="text-align: center; vertical-align: middle;">
                                            <td><?php echo $val['id'];?></td>
                                            <td><?php echo $val['datatime'];?></td>
                                            <td><?php echo $val['operator'];?></td>
                                            <td><?php echo $val['toolsn'];?></td>
                                            <td><?php echo $val['torque'];?></td>
                                            <td><?php echo $data['res_Torquetype'][$val['unit']];?></td>
                                            <td><?php echo $val['max_torque'];?></td>
                                            <td><?php echo $val['min_torque'];?></td>
                                            <td><?php echo $val['avg_torque'];?></td>
                                            <td><?php echo $val['high_percent'];?></td>
                                            <td><?php echo $val['low_percent'];?></td>
                                            <td><?php echo $val['customize'];?></td>
                                        </tr>
                                    
                                    <?php } ?>  
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="chart-setting">
                    <div class="column column-chart">
                         <div class="chart-container" id='chart_block'>
                            <!---曲線圖---->
                            <div  id="mychart" width="500px" height="300px"></div>
                        
                           
                        </div>
                    </div>

                    <div class="column column-meter-model">
                        <div class="meter-model">
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
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Target Torque:</div>
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
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Hi Limit Torque:</div>
                                        <div class="col-5 t1">
                                            <input id="high-limit-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['hi_limit_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Lo Limit Torque:</div>
                                        <div class="col-5 t1">
                                            <input id="low-limit-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['low_limit_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Max Torque:</div>
                                        <div class="col-5 t1">
                                            <input id="max-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['max_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Min Torque:</div>
                                        <div class="col-5 t1">
                                            <input id="min-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['min_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Ave Torque:</div>
                                        <div class="col-5 t1">
                                            <input id="ave-torque" type="text" class="t2 form-control" value="<?php echo $data['meter']['avg_torque'];?>">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-5 t1" style=" padding-left: 5%; color: #000">Standard Deviation:</div>
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
    <!-- Modal Export CSV -->
    <div id="Export_CSV" class="modal" style="top: 10%;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content w3-animate-zoom">
                <h4>Export CSV</h4>
                <div class="row t1">
                    <div class="col-4 t1" for="fileName1">Calibration file name:</div>
                    <div class="col-8 t1">
                        <input id="fileName1" type="text" class="t1 form-control" value="">
                    </div>
                </div>
                <div class="row t1">
                    <div class="col-4 t1" for="Save-as1">Save as type:</div>
                    <div class="col t1">
                        <select id="Save-as1" style="width: 200px; height: 30px">
                            <option value="Excel">Excel</option>
                            <option value="Notepad">Notepad</option>
                        </select>
                    </div>
                </div>
                <!--<div class="row t1">
                    <div class="col-4 t1" for="pageSize1">Page Size:</div>
                    <div class="col t1">
                        <select id="pageSize1" style="width: 200px; height: 30px">
                            <option value="A4">A4</option>
                            <option value="Letter">Letter</option>
                        </select>
                    </div>
                </div>-->
                <div class="modal-footer justify-content-center">
                    <button id="ExportCSV" class="style-button" onclick="file_download()">Export</button>
                    <button class="style-button" onclick="closeModal('Export_CSV')">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Export Chart -->
    <div id="Export_Chart" class="modal" style="top: 10%">
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
                    <button id="ExportChart" class="style-button" onclick="pic_download()">Export</button>
                    <button class="style-button" onclick="closeModal('Export_Chart')">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Export Report -->
    <div id="Export_Report" class="modal" style="top: 10%;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content w3-animate-zoom">
                <h4>Export Report</h4>
                <div class="row t1">
                    <div class="col-3 t1" for="fileName3">file name:</div>
                    <div class="col-6 t1">
                        <input id="fileName3" type="text" class="t1 form-control" value="">
                    </div>
                </div>
                <div class="row t1">
                    <div class="col-3 t1" for="Save-as3">Save as type:</div>
                    <div class="col t1">
                        <select id="Save-as3" style="width: 184px; height: 30px">
                            <option value="html">html</option>
                            <option value="xml">xml</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <!--<button id="Exportreport" class="style-button" onclick="openModal('Export_Report')">Export</button>-->
                    <button id="Exportreport" class="style-button" onclick="html_download()">Export</button>
                    <button class="style-button" onclick="closeModal('Export_Report')">Cancel</button>
                </div>
            </div>
        </div>
    </div>



    <div id="get_joball" class="lmodal" style="top: 10%" >
        <div class="lmodal-dialog modal-lg">
            <div class="lmodal-content" style="top: 150px; width: 710px">
                <span class="lclose-btn" onclick="closeModal_job()">&times;</span>
                <div class="lmodal-column modalselect">
                    <h4>Job</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">

                            <?php foreach($data['job_arr'] as $k_job =>$v_job){?>
                                    <div class="row t1">
                                        <div class="col t5 form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" name="jobid" id="jobid" value="<?php echo $v_job['job_id'];?>" onclick="JobCheckbox()" style="zoom:1.0; vertical-align: middle;">&nbsp;
                                            <label class="form-check-label" for="Job-1"><?php echo $v_job['job_name'];?></label>
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
    $(document).ready(function () {
        highlight_row('table');
        //highlight_row('barcode-table');
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
} //end of function

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
    var job_id = "<?php echo $_COOKIE['job_id'] ?? '' ?>"; 
    var job_name = "<?php echo $_COOKIE['job_name'] ?? '' ?>"; 
    document.getElementById("job-id").value = job_id;
    document.getElementById("job-name").value = job_name;

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
        dataZoom: generateDataZoom(),
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
