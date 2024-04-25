<?php require APPROOT . 'views/inc/header.tpl'; ?>
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/historical.css?v=202404111200" type="text/css">

<script src="<?php echo URLROOT; ?>js/flatpickr.js"></script>
<script src="<?php echo URLROOT; ?>js/historical.js?v=202404111000"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>

<?php if(isset($data['nav'])){
    echo $data['nav'];
}



//
//取得URL 
$path  = $_SERVER['REQUEST_URI'];
$path  = str_replace('/imas/public/index.php?url=Historicals/','',$path);
if ($path == "combinedata") {
    echo "
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var element = document.getElementById('CombineDataDisplay');
            if (element) {
                element.style.display = 'block';
            }
        
            var otherElement = document.getElementById('FasteningDisplay');
            if (otherElement) {
                otherElement.style.display = 'none';
            }
        });
    </script>
    ";
}

if (strpos($path, "nextinfo") !== false) {

      echo "
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var element = document.getElementById('DetailInfoDisplay');
            if (element) {
                element.style.display = 'block';
            }
        
            var otherElement = document.getElementById('FasteningDisplay');
            if (otherElement) {
                otherElement.style.display = 'none';
            }
        });
    </script>
    ";

}

if(!empty($_COOKIE['limit_val'])){
    $limit_val = $_COOKIE['limit_val'];
}else{
    $limit_val = '';
}

if(!empty($_COOKIE['unit_mode'])){
    $unit_mode = $_COOKIE['unit_mode'];
}else{
    $unit_mode = '';
}

if(!empty($_COOKIE['chat_mode'])){
    $chat_mode = $_COOKIE['chat_mode'];
}else{
    $chat_mode = '';
}

if(!empty($_COOKIE['chat_modeno'])){
    $chat_modeno = $_COOKIE['chat_modeno'];
}else{
    $chat_modeno = '';
}

if(!empty($_COOKIE['chat_mode_change'])){
    $chat_mode_change= $_COOKIE['chat_mode_change'];
}else{
    $chat_mode_change = '';
}

if(!empty($_COOKIE['line_style'])){
    $line_style = $_COOKIE['line_style'];
}else{
    $line_style = '';
}


?>

<style>


.t1{font-size: 20px; margin: 3px 0px; display: flex; align-items: center;}
.t2{font-size: 17px; margin: 3px 0px;}
.t3{font-size: 17px; margin: 3px 0px; height: 29px;border-radius: 5px;}
.t4{font-size: 17px; margin-right: 5px; border-radius: 5px}
.t5{margin-left: 10px; text-align: center;}
.t6{width: 116px;margin-right:10%}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    list-style: none;
    padding: 0;
}
.pagination li {
    margin-right: 5px;
}
.pagination li a,
.pagination li span {
    padding: 5px 10px;
    text-decoration: none;
    border: 1px solid #ccc;
    border-radius: 3px;
}
.current-page {
    font-weight: bold;
}
                                    
</style>


<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.18/c3.min.js"></script>


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/c3.min.css?v=202404251500" type="text/css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>




<div class="container-ms">
    <header>
        <div class="historical">
            <img id="header-img " src="./img/historical-head.svg"> historical Record
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
                <div class="navbutton active" onclick="handleButtonClick(this, 'fastening')">
                    <span data-content="Fastening Record" onclick="showContent('fastening')"></span>Fastening Record
                </div>
                <div class="navbutton" onclick="handleButtonClick(this, 'workflowlog')">
                    <span data-content="Work Flow Log" onclick="showContent('workflowlog')"></span>Work Flow Log
                </div>
                <div class="navbutton" onclick="handleButtonClick(this, 'useraccess')">
                    <span data-content="User Access Logging" onclick="showContent('useraccess')"></span>User Access Logging
                </div>
            </div>

            <!-- Fastening Setting -->
            <div id="fasteningContent" class="content">
                <div id="FasteningDisplay" style="margin-top: 40px">
                    <div style="padding-left: 2%">
                        <div class="row">
                            <div for="BarcodeSN" class="col-1 t1">BarcodeSN</div>
                            <div class="col-2 t2">
                                <input type="text" class="t3 form-control input-ms" id="barcodesn" name="barcodesn" maxlength="" style="width: 190px;">
                            </div>

                            <div for="Operator" class="col-1 t1">Operator</div>
                            <div class="col-2 t2">
                               <!--<input type="text" class="t3 form-control input-ms" id="Operator" maxlength="" value="" style="width: 190px;">-->
                               <!--<select>
                                    <?//php foreach($data['all_roles'] as $key =>$val){ ?>
                                            <!--<option value='<?//php echo $val['ID'];?>'> <?//php echo $val['Title'];?> </option>
                                    <?//php } ?>
                               </select>-->
                            </div>

                            <div for="SelectJob" class="col-1 t1">Select Job</div>
                            <div class="col-2 t3">
                                <input type="text" class="t3 form-control input-ms" id="JobSelect" placeholder="Click here.." onfocus="openModal('JobSelect')" onclick="this.blur()">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-1 t1" for="FromDate">From</div>
                            <div class="col-2 t1">
                                <input type="datetime-local" class="t3" id="FromDate" name="FromDate" style="width: 190px;border-radius: 5px;border: 1px solid #CCCCCC; ">
                            </div>

                            <div class="col-1 t1" for="ToDate">To</div>
                            <div class="col-2 t1">
                                <input type="datetime-local" class="t3" id="ToDate" name="ToDate" style="width: 190px; border-radius: 5px;border: 1px solid #CCCCCC;">
                            </div>
                        </div>

                        <div class="row">
                            <div for="result-status" class="col-1 t1">Result Status</div>
                            <div class="col-2 t2">
                                <select id="status" style="width: 190px">
                                    <?php foreach($data['res_status_arr'] as $key_res =>$val_res){?>
                                            <option value="<?php echo $key_res;?>"><?php echo $val_res;?></option>
                                    <?php }?>
                                    
                                </select>
                            </div>

                            <div for="Controller" class="col-1 t1">Controller</div>
                            <div class="col-2 t3">
                                <select id="Controller" style="width: 190px;">
                                    <?php foreach($data['res_controller_arr'] as $key_res_1 =>$val_res_1){?>
                                            <option value="<?php echo $key_res_1;?>"><?php echo $val_res_1;?></option>
                                    <?php }?>
                                </select>
                            </div>

                            <div for="Program" class="col-1 t1">program</div>
                            <div class="col-2 t3">
                                <select id="Program" style="width: 190px;">
                                     <?php foreach($data['res_program'] as $key_res_2 =>$val_res_2){?>
                                            <option value="<?php echo $key_res_2;?>"><?php echo $val_res_2;?></option>
                                    <?php }?>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="topnav-menu">
                        <div class="search-container">
                            <input type="text" placeholder="Search.." name="sname" id="search_name" size="40" style="height: 35px">&nbsp;
                            <button id="Search" type="button" class="Search-button" onclick="search_info()">Search</button>
                        </div>


                        <div class="topnav-right">
                            <button id="Export-CSV" type="button" class="ExportButton" onclick="csv_download()">Export CSV</button>
                            <button id="Export-Report" type="button" class="ExportButton" onclick="window.location.href='?url=Historicals/history_result';" >Export Report</button>
                            <button id="Combine-btn" type="button" onclick="NextToCombineData()">Combine Data</button>
                            <button id="Clear" type="button"   onclick="clear_button() ">Clear</button>
                            <button  id="nopage" type="button"  onclick="nopage('nopage')">Nopage</button>
                        </div>

                    </div>

                    <div class="scrollbar-fastening" id="style-fastening">
                        <div class="force-overflow-fastening">
                            <table class="table table-bordered table-hover" id="fastening-table">
                                <thead id="header-table" style="text-align: center; vertical-align: middle">
                                    <tr>
                                        <th><i class="fa fa-trash-o" style="font-size:26px;color:black" onclick="delete_historyinfo()"></i></th>
                                        <th>Index</th>
                                        <th>Time</th>
                                        <th>Station</th>
                                        <th>BarcodeSN</th>
                                        <th>Job Name</th>
                                        <th>Seq Name</th>
                                        <th>task</th>
                                        <th>Equipment</th>
                                        <th>Torque range</th>
                                        <th>Angle range</th>
                                        <th>Final Torque</th>
                                        <th>Final Angle</th>
                                        <th>Status</th>
                                        <th>Error</th>
                                        <th>Pset</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>

                                <tbody id="tbody1" style="background-color: #F2F1F1; font-size: 1.8vmin;text-align: center; vertical-align: middle;">
                                    
                                    <?php foreach($data['info'] as $k_info =>$v_info){
                                    
                                        $link ='?url=Historicals/nextinfo/'.$v_info['system_sn'];
                                        ?>
                                        <tr>
                                            <td style="text-align: center;">
                                                <input class="form-check-input" type="checkbox" name="test1" id="test1"  value="<?php echo $v_info['system_sn'];?>" style="zoom:1.2;vertical-align: middle;">
                                            </td>
                                            <td><?php echo $v_info['system_sn'];?></td>
                                            <td><?php echo $v_info['data_time'];?></td>
                                            <td></td>
                                            <td><?php echo $v_info['cc_barcodesn'];?></td>
                                            <td><?php echo $v_info['job_name'];?></td>
                                            <td><?php echo $v_info['sequence_name'];?></td>
                                            <td><?php echo $v_info['cc_task_name'];?></td>
                                            <td></td>
                                            <td><?php echo $v_info['step_lowtorque']." ~ ".$v_info['step_hightorque'];?></td>
                                            <td><?php echo $v_info['step_lowangle']." ~ ".$v_info['step_highangle'];?></td>
                                            <td><?php echo $v_info['fasten_torque'].$data['torque_arr'][$v_info['torque_unit']] ;?></td>
                                            <td><?php echo $v_info['fasten_angle'] . " deg";?></td>
                                            <td style="background-color:<?php echo $data['status_arr']['status_color'][$v_info['fasten_status']];?> font-size: 20px"><?php echo $data['status_arr']['status_type'][$v_info['fasten_status']];?></td>
                                            <td><?php echo $data['status_arr']['error_msg'][$v_info['error_message']];?></td>
                                            <td></td>
                                            <td>
                                                <a href=" <?php echo $link;?> " >
                                                    <img src="./img/info-30.png" alt="" style="height: 28px; vertical-align: middle;" >
                                                </a>
                                            </td>
                                        </tr>
                                    <?php }?>
                                </tbody>
                            </table>


                            <?php if( $data['nopage'] ==  "1"){ ?>
                            <div class="pagination" align="center">
                                <?php if ($data['page'] > 1): ?>
                                    <a href="?url=Historicals&p=<?php echo ($data['page'] - 1); ?>"> Pre  &nbsp;&nbsp;</a>
                                <?php endif; ?>
                                
                                <?php for ($i = 1; $i <= $data['totalPages']; $i++): ?>
                                    <?php if ($i == $data['page']): ?>
                                        <span class="current-page"><?php echo $i; ?></span>
                                    <?php else: ?>
                                        <a href="?url=Historicals&p=<?php echo $i; ?>"><?php echo "&nbsp;&nbsp$i&nbsp;&nbsp"; ?>&nbsp;&nbsp;</a>
                                    <?php endif; ?>
                                <?php endfor; ?>
                                
                                <?php if ($data['page'] < $data['totalPages']): ?>
                                    <a href="?url=Historicals&p=<?php echo ($data['page'] + 1); ?>"> Next  &nbsp;&nbsp;</a>
                                <?php endif; ?>

                            </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>

                <!-- Click Detail Fastening Record Info -->
                <div id="DetailInfoDisplay" style="display: none">
                    <div class="topnav">
                        <label type="text" style="font-size: 18px; padding-left: 1%; margin: 4px">Fastenig record &#62; Info</label>
                        <button id="back-setting" type="button" onclick="goBack()">
                            <img id="img-back" src="./img/back.svg" alt=" onclick="goBack()">Back
                        </button>
                    </div>

                    <table class="table" style="font-size: 15px;">
                        <tr style="padding: 0 10px">
                            <td>Index: <?php echo $data['job_info'][0]['system_sn'];?></td>
                            <td>Job info: <?php echo $data['job_info'][0]['job_name'];?> / <?php echo $data['job_info'][0]['sequence_name']. "/". $data['job_info'][0]['cc_task_name'];?></td>
                            <td>Controller: </td>
                            <td>Error code: <?php echo  $data['status_arr']['error_msg'][$data['job_info'][0]['error_message']];?></td>
                            <td>Status : <a style="background-color: <?php echo $data['status_arr']['status_color'][$data['job_info'][0]['fasten_status']];?>; padding: 0 10px"><?php echo $data['status_arr']['status_type'][$data['job_info'][0]['fasten_status']];?></a></td>
                        </tr>
                        <tr>
                            <td>Actual Torque: <?php echo $data['job_info'][0]['fasten_torque'];?> kgf.cm</td>
                            <td>BarcodeSN: <?php echo $data['job_info'][0]['cc_barcodesn'];?></td>
                            <td>Direction: <?php echo  $data['status_arr']['direction'][$data['job_info'][0]['count_direction']];?></td>
                            <td>Pset: </td>
                            <td>Time: <?php echo $data['job_info'][0]['data_time'];?></td>
                        </tr>
                        <tr  style="vertical-align: middle;">
                            <td>Member: <!--<input class="t6" type="text" size="10" value="Esther" disabled="disabled" style="background-color: #F5F5F5">--></td>
                            <td>Note: <!--<input class="t6" type="text" value="arm (444,215)[200]" disabled="disabled" style="background-color: #F5F5F5; width: 15vw"></td>-->
                            <td>
                                <input class="form-check-input" type="checkbox" id="myCheckbox" onchange="check_limit(this)"  <?php if($limit_val=="1"){ echo "checked"; }else{}?>  style="zoom:1.2; float: left">&nbsp; display the high/low auxiliary lines.
                            </td>
                            </td>
                        </tr>
                        <tr style="vertical-align: middle">
                            <td>
                                Chart Setting:  
                                <select id="chartseting" class="t6 Select-All" style="float: none"  onchange="chat_mode_change(this)">
                                            <?php foreach($data['chat_mode_arr'] as $k_chat => $v_chat){?>
                                                <option  value="<?php echo $k_chat;?>"  <?php if($chat_mode_change == $k_chat){echo "selected";}else{echo "";}?>  > <?php echo $v_chat;?> </option>
                                            <?php } ?>                             
                                </select>
                            </td>
                            <td>
                                Torque Unit:    
                                <select id="Torque-Unit" class="Select-All" style="float: none; width: 100px" onchange="unit_change(this)">
                                                    <?php foreach($data['torque_mode_arr'] as $k_torque => $v_torque){?>
                                                            <option  value="<?php echo $k_torque;?>"  <?php if($unit_mode== $k_torque){echo "selected";}else{echo "";}?>  > <?php echo $v_torque;?> </option>
                                                    <?php } ?>
                                </select>
                            </td>
                            <td>
                                Angle:  <select id="Angle" class="t6 Select-All" id='angle_type' style="float: none; width: 100px">
                                            <option value="1">Total angle</option>
                                            <option value="2">Task angle</option>
                                        </select>
                            </td>
                           <!--<td>
                                Sampling:  
                                <select id="SelectOutputSampling" class="t6 Select-All" id='file_type'>
                                            <option value="1">1(ms)</option>
                                            <option value="2">0.5(ms)</option>
                                            <option value="3">2(ms)</option>
                                </select>
                            </td>-->
                            <td>
                                <button id="Export-Excel" type="button" class="ExportButton" style="margin-top: 0">Export Excel</button>
                                <!--<button id="Save-info" type="button" style="margin-top: 0">Save</button>-->
                            </td>
                        </tr>
                    </table>

                    <div>
                        <div style="text-align: center">
                            <label style="float: left"><b>Diagram Display</b></label>
                            <label><?php echo $data['chat']['chat_name'];?></label>
                        </div>
                        <div id="chart-setting">
                            <div class="chart-container">
                                <div class="menu-chart" onclick="toggleMenu()">
                                    <i class="fa fa-bars" style="font-size: 26px"></i>
                                    <div class="menu-content" id="myMenu">
                                        <a href="#" onclick="viewFullScreen()">View in full screen</a>
                                        <a href="#" onclick="printChart()">Print chart</a>
                                        <a  onclick="nextinfo_png()">Download PNG</a>
                                        <a  id="downloadPngBtn">Download JEPG</a>
                                    </div>
                                    
                                </div>
                                <div class="empty-div3"></div>
                                <div id="chartinfo"></div>
                                
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Click Combine Data -->
                <div id="CombineDataDisplay" style="display: none">
                    <div class="topnav">
                        <label type="text" style="font-size: 20px; padding-left: 1%; margin: 6px">Fastenig record &#62; Combine data</label>
                        <button id="back-setting" type="button"  onclick="goBack()" >
                            <img id="img-back" src="./img/back.svg" alt=""  onclick="goBack()" >Back
                        </button>
                    </div>
                    <div class="topnav-menu" style="background-color: #FFF; margin-top: 3px">
                        <div class="row t1">
                            <div class="col t2 form-check form-check-inline" style="margin-left: 10px">
                                <input class="form-check-input" type="checkbox" id="myCheckbox" onchange="check_limit(this)";  <?php if($limit_val=="1"){ echo "checked"; }else{}?> style="zoom:1.2; vertical-align: middle">
                                <label class="form-check-label" for="optioncheck">display the high/low auxiliary lines.</label>

                                <label style="padding-left: 5%">
                                    Angle : &nbsp;<select id="angle" style="width: 120px" onchange="angle_change(this)">
                                                    <option value="1">total angle</option>
                                                    <option value="2">task angle</option>
                                                  </select>
                                </label>
                                <label style="padding-left: 5%">
                                    Unit :  &nbsp;
                                        <select id="unit" style="width: 100px" onchange="unit_change(this)" >
                                          <?php foreach($data['torque_mode_arr'] as $k_torque => $v_torque){?>
                                                            <option  value="<?php echo $k_torque;?>"  <?php if($unit_mode== $k_torque){echo "selected";}else{echo "";}?>  > <?php echo $v_torque;?> </option>
                                          <?php } ?>        
                                        </select>
                                </label>
                            </div>
                            <div class="col t2">
                                <!---<button id="Save-combine" type="button">Save</button>-->
                                <button id="Export-Excel-data" type="button" class="ExportButton">Export Excel</button>
                                <button id="downloadBtn" type="button" class="ExportButton" onclick="get_png()">Export PNG</button>
                            </div>
                        </div>
                    </div>

                    <hr class="w3-clear" style="width: 100%">

                    <div class="w3-col">
                        <div class="w3-round" style="margin: 5px 0;">
                            <div class="w3-row-padding">
                                <div class="scrollbar-Combine" id="style-Combine">
                                    <div class="force-overflow-Combine">
                                    <?php foreach( $data['info_final'] as $key =>$val){?>
                                            <div class="w3-half">
                                                <div class="row t1">
                                                    <div class="col"> Index : <?php echo $val['system_sn'];?></div>
                                                    <div class="col"> Job info : <?php echo $val['job_name'];?></div>
                                                    <div class="col"> Pset : </div>
                                                </div>
                                                <div class="row t1">
                                                    <div class="col"> Time : <?php echo $val['data_time'];?></div>
                                                    <div class="col"> Task Time : <?php echo $val['fasten_time'];?> ms </div>
                                                    <div class="col"> Status : <a style="background-color:<?php echo $data['status_arr']['status_color'][$val['fasten_status']];?>"><?php echo $data['status_arr']['status_type'][$val['fasten_status']];?></a></div>
                                                </div>
                                                <div class="row t1">
                                                    <div class="col"> barcodeSN : <?php echo $val['cc_barcodesn'];?></div>
                                                    <div class="col"> Error Code : <?php echo  $data['status_arr']['error_msg'][$val['error_message']];?></div>
                                                    <div class="col"> Actual Torque : <?php echo $val['fasten_torque'] ." ".$data['torque_arr'][$val['torque_unit']];?> </div>
                                                </div>
                                                <div class="row t1">
                                                    <div class="col"> Equipment : </div>
                                                </div>
                                             </div>
                                    <?php }?>

                                

                                        <!---圖表1--->
                                        <div id="photo1">
                                            <div class="empty-div"></div>
                                            <div id="chart-title"><?php echo $data['info_final'][0]['job_name'];?></div>
                                            <div id="chart"></div>
                                        </div>

                                        <br><br><br><br>
                                        <!---圖表2--->
                                        <div id="photo2">
                                            <div class="empty-div"></div>
                                            <div id="chart-title2"><?php echo $data['info_final'][1]['job_name'];?></div>
                                            <div id="chart1"></div>
                                        </div>
                                        
                                                                   
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Work Flow Log Setting -->
            <div id="workflowlogContent" class="content" style="display: none">
                <div id="WorkFlowLogDisplay" style="margin-top: 40px">
                    <div style="padding-left: 2%; width: 70%">
                        <table class="table" style="font-size: 15px; margin-bottom: 0px; border-bottom: hidden;">
                            <tr>
                                <td>Job : <input type="text" class="t3" id="Member-Name" maxlength="" value="Esther" style="float: none;width: 130px"></td>
                                <td>Super Admin : <input type="text" class="t3" id="superAdmin" maxlength="" style="float: none;width: 130px;"></td>
                                <td>From : <input type="datetime-local" class="t3" id="FromDate" name="FromDate" style="width: 190px;border-radius: 5px;border: 1px solid #CCCCCC;float: none"> </td>
                                <td>To : <input type="datetime-local" class="t3" id="ToDate" name="ToDate" style="width: 190px; border-radius: 5px;border: 1px solid #CCCCCC;float: none"></td>
                            </tr>
                        </table>
                    </div>

                    <div class="topnav-menu">
                        <div class="search-container">
                            <form>
                                <input type="text" placeholder="Search.." name="search" size="40" style="height: 35px">&nbsp;
                                <button id="Search" type="submit" class="Search-button">Search</button>
                            </form>
                        </div>
                        <div class="topnav-right">
                            <button id="ExportExcel" type="button" class="ExportButton">Export Excel</button>
                            <button id="ExportReport" type="button" class="ExportButton">Export Report</button>
                            <button id="Reset" type="button">Reset</button>
                        </div>
                    </div>

                    <div class="scrollbar-WorkFlowLog" id="style-WorkFlowLog">
                        <div class="force-overflow-WorkFlowLog">
                            <table class="table table-bordered table-hover" id="WorkFlowLog-table">
                                <thead id="header-table" style="text-align: center; vertical-align: middle">
                                    <tr>
                                        <th>Index</th>
                                        <th>Time</th>
                                        <th>BarcodeSN</th>
                                        <th>Type</th>
                                        <th>Event</th>
                                        <th>Job Name</th>
                                        <th>Seq Name</th>
                                        <th>task</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="tbody1" style="background-color: #F2F1F1;text-align: center; font-size: 1.8vmin; vertical-align: middle;">
                                    <tr>
                                        <td>1</td>
                                        <td>2024/02/01 13:30:20</td>
                                        <td>567678</td>
                                        <td>job-1</td>
                                        <td>seq-1</td>
                                        <td>task-1</td>
                                        <td>tightening</td>
                                        <td style="text-align: left">0.6 N.m\223 Deg\P1\OK</td>
                                        <td>
                                            <img src="./img/info-30.png" alt="" style="height: 28px; vertical-align: middle;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>2024/02/01 13:30:20</td>
                                        <td>123456</td>
                                        <td>job-1</td>
                                        <td>seq-2</td>
                                        <td>task-2</td>
                                        <td>Select point</td>
                                        <td style="text-align: left">task1[2]>task2[1]\(111,120)[200]>(222,120)[200]</td>
                                        <td>
                                            <img src="./img/info-30.png" alt="" style="height: 28px; vertical-align: middle;" onclick="WorkFlowLogInfo()">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Work Flow Log Info -->
                <div id="WorkFlowLogInfoDisplay" style="display: none">
                    <div class="topnav">
                        <label type="text" style="font-size: 20px; padding-left: 1%; margin: 6px">Work Flow Log &#62; Info</label>
                        <button id="back-setting" type="button" onclick="cancelSetting()">
                            <img id="img-back" src="./img/back.svg" alt="">Back
                        </button>
                    </div>
                    <table class="table table-borderless" style="font-size: 15px; width: 80%">
                        <tr>
                            <td>Index: <input class="t6 input-ms" type="text" size="10" value="2"></td>
                            <td>Barcode: <input class="t6 input-ms" type="text" size="20" value="123456"></td>
                            <td>job Info: <input class="t6 input-ms" type="text" size="25" value="job-1 > seq-2 > task-2" style="width: 190px"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Member: <input class="t6 input-ms" type="text" size="10" value="Esther" disabled="disabled"></td>
                            <td>Type: <input class="t6 input-ms" type="text" size="20" value="Select point"></td>
                            <td>Event: <input class="t6 input-ms" type="text" size="25" value="task1[2]>task2[1]" style="width: 190px"></td>
                            <td>Arm position: <input class="t6 input-ms" type="text" size="25" value="(111,120)[200]>(222,120)[200]" disabled="disabled" style="width: auto"></td>
                        </tr>
                    </table>
                    <hr style="width: 100%; height: 4px;">
                    <b style="font-size: 20px">Diagram Display</b>
                    <div class="w3-center">
                        <img src="./img/pick-A-screw.svg" style=" height: 40vh; width: 70vw" alt="Nature" class="w3-margin-bottom">
                    </div>

                    <button class="Save-button" id="saveButton" onclick="Save_job()">Save</button>
                </div>
            </div>

            <!-- User Access Setting -->
            <div id="useraccessContent" class="content" style="display: none">
                <div style="padding-left: 2%; margin-top: 40px">
                    <table class="table" style="font-size: 15px; margin-bottom: 0px; border-bottom: hidden; width: 70%">
                        <tr>
                            <td>Member Name : <input type="text" class="t3" id="Member-Name" maxlength="" value="Esther" style="float: none;width: 130px"></td>
                            <td>Role Name : <select id="unit" class="t3" style="width: 130px;float: none">
                                                <option value="1">Super Admin</option>
                                                <option value="2">Admin</option>
                                                <option value="2">Operator</option>
                                                <option value="2">Leader</option>
                                            </select>
                            </td>
                            <td>From : <input type="datetime-local" class="t3" id="FromDate" name="FromDate" style="width: 190px;border-radius: 5px;border: 1px solid #CCCCCC;float: none"> </td>
                            <td>To : <input type="datetime-local" class="t3" id="ToDate" name="ToDate" style="width: 190px; border-radius: 5px;border: 1px solid #CCCCCC;float: none"></td>
                        </tr>
                    </table>
                </div>

                <div class="topnav-menu">
                    <div class="search-container">
                        <form>
                            <input type="text" placeholder="Search.." name="search" size="40" style="height: 35px">&nbsp;
                            <button id="Search" type="submit" class="Search-button">Search</button>
                        </form>
                    </div>
                    <div class="topnav-right">
                        <button id="Export_Excel" type="button" class="ExportButton">Export Excel</button>
                        <button id="Export_Report" type="button" class="ExportButton">Export Report</button>
                        <button id="Reset_btn" type="button">Reset</button>
                    </div>
                </div>

                <div class="scrollbar-UserAccess" id="style-UserAccess">
                    <div class="force-overflow-UserAccess">
                        <table class="table table-bordered table-hover" id="UserAccess-table">
                            <thead id="header-table" style="text-align: center; vertical-align: middle">
                                <tr>
                                    <th>Index</th>
                                    <th>Time</th>
                                    <th>Member Namne</th>
                                    <th>Type</th>
                                    <th>Page</th>
                                    <th>Event</th>
                                </tr>
                            </thead>
                            <tbody id="tbody1" style="background-color: #F2F1F1;text-align: center; font-size: 1.8vmin; vertical-align: middle;">
                                <tr>
                                    <td>1</td>
                                    <td>2024/02/19 13:30:20</td>
                                    <td>Esther</td>
                                    <td>Tightening</td>
                                    <td>Job</td>
                                    <td style="text-align: left">0.6 N.m\223 Deg\P1\OK</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>2024/02/19 13:30:20</td>
                                    <td>Peter</td>
                                    <td>Select point</td>
                                    <td>Operation</td>
                                    <td style="text-align: left">task1[2]>task2[1]\(111,120)[200]>(222,120)[200]</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modals Job Select -->
    <div id="modalJobSelect" class="modal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="top: 150px; width: 710px">
                <span class="close-btn" onclick="closeModal('JobSelect')">&times;</span>
                <div class="modal-column modalselect">
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
                <div class="modal-column modalselect">
                    <h4>Sequence</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">
                            <div id="Seq-list" style="display: none">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-column modalselect">
                    <h4>Task</h4>
                    <div class="scrollbar-jobselect" id="style-jobselect">
                        <div class="force-overflow-jobselect">
                            <div id="Task-list" style="display: none">
                              
                            </div>
                        </div>
                    </div>
                </div>

                <!--<span class="Save-button" onclick='Save_job()'>Save</span>-->
            </div>
        </div>
    </div>
</div>

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


// JavaScript open modal
    function openModal(inputId)
    {
        document.getElementById('modal' + inputId).style.display = 'flex';
        document.getElementById(inputId).focus();
    }

    // JavaScript close modal
    function closeModal(inputId)
    {
        document.getElementById('modal' + inputId).style.display = 'none';
    }

    // press the Esc button close modal
    document.addEventListener('keydown', function(event)
    {
        if (event.key === 'Escape') {
            closeModal('JobSelect');
        }
    });



    // Close the modal when clicking outside the modal content
    window.addEventListener('click', function(event) {
        if (event.target === document.getElementById('modalJobSelect')) {
            closeModal('JobSelect');
        }
    });


// Next To Info
function NextToInfo()
{
    // Show DetailInfo
    // Hide FasteningDisplay
    document.getElementById('DetailInfoDisplay').style.display = 'block';
    document.getElementById('FasteningDisplay').style.display = 'none';
}


function WorkFlowLogInfo()
{
    // Show Work Flow Log Info
    document.getElementById('WorkFlowLogInfoDisplay').style.display = 'block';

    // Hide Work Flow Log
    document.getElementById('WorkFlowLogDisplay').style.display = 'none';
}

/*function cancelSetting()
{
    var FasteningDisplay = document.getElementById('FasteningDisplay');
    var detailInfo = document.getElementById('DetailInfoDisplay');
    var combinedata = document.getElementById('CombineDataDisplay');
    var workflowlog = document.getElementById('WorkFlowLogInfoDisplay');

    // Check the current state and toggle accordingly
    if (detailInfo.style.display === 'block')
    {
        FasteningDisplay.style.display = 'block';
        detailInfo.style.display = 'none';
    }
    else if (combinedata.style.display === 'block')
    {
        // If cmombinedata is currently displayed, switch to FasteningDisplay
        FasteningDisplay.style.display = 'block';
        combinedata.style.display = 'none';
    }
    else if (workflowlog.style.display === 'block')
    {
        // If WorkFlowLogInfoDisplay is currently displayed, switch to WorkFlowLogDisplay
        WorkFlowLogDisplay.style.display = 'block';
        workflowlog.style.display = 'none';
    }
    else
    {
        // If FasteningDisplay is currently displayed or both are hidden, do nothing or handle it as needed
    }
}*/

function toggleMenu() {
    var menuContent = document.getElementById("myMenu");
    menuContent.style.display = (menuContent.style.display === "block") ? "none" : "block";
}

function printChart() {

}

/// Onclick event for row background color
$(document).ready(function () {
    // Call highlight_row function with table id
    highlight_row('fastening-table');
    highlight_row('WorkFlowLog-table');
    highlight_row('UserAccess-table');
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
</style>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>


<!----nextinfo op----->
<?php  if (strpos($path, "nextinfo") !== false && $data['chart_info']['chat_mode'] != "6") {?>
<script>
    var x_data_val = <?php echo  $data['chart_info']['x_val']; ?>;
    var y_data_val = <?php echo  $data['chart_info']['y_val']; ?>;

    var min_val = <?php echo  $data['chart_info']['min'];?>;
    var max_val = <?php echo  $data['chart_info']['max'];?>;

    var xaxislabel = '<?php echo $data['chart_info']['x_title'];?>';
    var yaxislabel = '<?php echo $data['chart_info']['y_title'];?>';

    var type = '<?php echo $data['chart_info']['chat_mode'];?>';

    var chartOptions_info = {
    bindto: '#chartinfo',
    data: {
        x: 'x',
        columns: [
            ['x'].concat(x_data_val),
            ['Torque'].concat(y_data_val)
        ]
    },

    axis: {
        x: {
            label: xaxislabel,
            position: 'outer-center',
        },
        y: {
            label: yaxislabel,
            tick: {}
        }
    },

    grid: {
        y: {}
    },
    subchart: {
        show: true
    }
    };
    // 根據limit_val 的值決定是否顯示上下限
    if (limit_val == 1) {
        chartOptions_info.grid.y.lines = [
            {value: min_val, text: 'Low Torque', position: 'middle', class: 'grid-upper'},
            {value: max_val, text: 'High Torque', position: 'middle', class: 'grid-upper'}
        ];

    }

    var chart = c3.generate(chartOptions_info);

</script>
<?php } ?>

<?php  if (strpos($path, "nextinfo") !== false && $data['chart_info']['chat_mode'] == "6") {?>
<script>
        var x_data_val  = <?php echo  $data['chart_info']['x_val']; ?>;
        var y_data_val  = <?php echo  $data['chart_info']['y_val']; ?>;
        var y_data_val1 = <?php echo  $data['chart_info']['y_val_1'];?>;

        var min_val = <?php echo  $data['chart_info']['min'];?>;
        var max_val = <?php echo  $data['chart_info']['max'];?>;

        var min_val1 = <?php echo  $data['chart_info']['min1'];?>;
        var max_val1 = <?php echo  $data['chart_info']['max1'];?>;

        

        var xaxislabel = '<?php echo $data['chart_info']['x_title'];?>';
        var yaxislabel = '<?php echo $data['chart_info']['y_title'];?>';

        var chartOptions_info = {
            bindto: '#chartinfo',
            data: {
                x: 'x',
                columns: [
                    ['x'].concat(x_data_val),
                    ['Torque'].concat(y_data_val),
                    ['Angle'].concat(y_data_val1)
                ]
            },

            axis: {
                x: {
                    label: xaxislabel,
                    position: 'outer-center',
                },
                y: {
                    label: 'Angle',
                    tick: {}
                },
                y2: {
                    show: true,
                    label: {
                        text: 'Torque',
                        position: 'outer-middle'
                    }
                }
            },

            grid: {
                y: {}
            },
            subchart: {
                show: true
            }
            };
            // 根據limit_val 的值決定是否顯示上下限
            if (limit_val == 1) {
                chartOptions_info.grid.y.lines = [
                    {value: min_val, text: 'Low Torque', position: 'middle', class: 'grid-upper'},
                    {value: max_val, text: 'High Torque', position: 'middle', class: 'grid-upper'},
                    {value: min_val1, text: 'Low Angle', position: 'middle', class: 'grid-upper'},
                    {value: max_val1, text: 'High Angle', position: 'middle', class: 'grid-upper'},
                ];
            }

            var chart = c3.generate(chartOptions_info);




        
</script>
<?php }?>
<!----nextinfo ed----->

<!----combine op----->
<?php if ($path == "combinedata"){?>
<script>
    //整理X軸跟Y軸的數據data
    var x_data  = <?php echo  $data['chart1_xcoordinate']; ?>;
    var y_data  = <?php echo  $data['chart1_ycoordinate']; ?>;


    var min = <?php echo $data['chart1_ycoordinate_min'];?>;
    var max = <?php echo $data['chart1_ycoordinate_max'];?>;


    var chartOptions = {
        bindto: '#chart',
        data: {
            x: 'x',
            columns: [
                ['x'].concat(x_data),
                ['Torque'].concat(y_data)
            ]
        },

        axis: {
            x: {
                label: 'Time (ms)',
                position: 'outer-center',
            },
            y: {
                label: 'Torque',
                tick: {}
            }
        },

        grid: {
            y: {}
        },
        subchart: {
            show: true
        }
    };

    // 根據limit_val 的值決定是否顯示上下限
    if (limit_val == 1) {
        chartOptions.grid.y.lines = [
            {value: min, text: 'Low Torque', position: 'middle', class: 'grid-upper'},
            {value: max, text: 'High Torque', position: 'middle', class: 'grid-upper'}
        ];
    }

    var chart = c3.generate(chartOptions);
    var chartTitle = document.getElementById('chart-title');
    chartTitle.style.textAlign = 'center';
    chartTitle.style.fontSize = '21px'; 
    chartTitle.style.color = 'blue'; 

</script>


<script>

    //整理X軸跟Y軸的數據data
    var x_data = <?php echo  $data['chart2_xcoordinate']; ?>;
    var y_data = <?php echo  $data['chart2_ycoordinate']; ?>;

    var min = <?php echo $data['chart2_ycoordinate_min'];?>;
    var max = <?php echo $data['chart2_ycoordinate_max'];?>;




    var chartOptions1 = {
        bindto: '#chart1',
        data: {
            x: 'x',
            columns: [
                ['x'].concat(x_data),
                ['Torque'].concat(y_data)
            ]
        },

        axis: {
            x: {
                label: 'Time (ms)',
            },
            y: {
                label: 'Torque',
                tick: {}
            }
        },

        grid: {
            y: {}
        },
        subchart: {
            show: true
        }
    };

    //根據limit_val 的值決定是否顯示上下限
    if (limit_val == 1) {
        chartOptions1.grid.y.lines = [
            {value: min, text: 'Low Torque', position: 'middle', class: 'grid-upper',size:15  },
            {value: max, text: 'High Torque', position: 'middle', class: 'grid-upper',size:15 }
        ];
    }

    var chart1 = c3.generate(chartOptions1);
    var chartTitle2 = document.getElementById('chart-title2');
    chartTitle2.style.textAlign = 'center';
    chartTitle2.style.fontSize = '21px';
    chartTitle2.style.color = 'blue'; 

</script>
<?php } ?>


<!----combine ed----->
<style>
    .grid-upper line {
        stroke: red;
    }
    .grid-lower line {
        stroke: red;
    }
    .region-upper rect {
        fill: rgba(255, 0, 0, 0.2);
    }
    .region-lower rect {
        fill: rgba(255, 0, 0, 0.2);
    }
    .c3 .grid line.grid-upper {
        stroke-width: 2px;
    }

    .empty-div {
        width: 200px;
        height:150px;
    }
     .empty-div1 {
        width: 200px;
        height:500px;
    }
      .empty-div3 {
        width: 200px;
        height:50px;
    }
</style>

<script>
function chat_mode_change(selectOS){
    var selectElement = document.getElementById('chartseting');
    var selectedOptions = [];
    // 獲取所有被選中的選項
    for (var i = 0; i < selectElement.options.length; i++) {
        var option = selectElement.options[i];
        if (option.selected) {
            selectedOptions.push(option.value);
        }
    }   
     
    document.cookie = "chat_mode_change=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    history.go(0);
}


function get_png(){
     // 使用 DOM to Image 將 c3.js 圖表轉換為圖像
    domtoimage.toBlob(document.getElementById('chart'), { bgcolor: '#ffffff' })
        .then(function(blob) {
            // 創建下載連結
            var downloadLink = document.createElement("a");
            downloadLink.href = URL.createObjectURL(blob);
            downloadLink.download = "chart_screenshot_0.png"; 

            // 模擬點擊下載連結
            downloadLink.click();
            get_png_1();
            
    });

}

function get_png_1(){
     // 使用 DOM to Image 將 c3.js 圖表轉換為圖像
    domtoimage.toBlob(document.getElementById('chart1'), { bgcolor: '#ffffff' })
        .then(function(blob) {
            // 創建下載連結
            var downloadLink = document.createElement("a");
            downloadLink.href = URL.createObjectURL(blob);
            downloadLink.download = "chart_screenshot_1.png"; 

            // 模擬點擊下載連結
            downloadLink.click();
    });

}
</script>
