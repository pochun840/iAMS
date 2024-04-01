<?php require APPROOT . 'views/inc/header.tpl'; ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/operation.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/clickcircle.css" type="text/css">

<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<?php echo $data['nav']; ?>
<style>
.t1{color: #14A800; background-color: #E8F9F1; border-radius: 10px; padding-right: 5%; padding: 0 5px;}


.t2{color: #555555; background-color: #DDDDDD; border-radius: 10px; padding: 0 5px}


</style>
<div class="container-ms">

    <header>
        <div class="operation">
            <img id="header-img" src="./img/operation-head.svg">Operation
        </div>

        <div class="notification">
            <i style=" width:auto; height: 40px;" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel">
            <i style=" width:auto; height: 40px" class="fa fa-desktop"></i> Esther
        </div>

        <div style="display: none;">
            <input id="job_id" value="<?php echo $data['job_id']; ?>" disabled>
            <input id="seq_id" value="<?php echo $data['seq_id']; ?>" disabled>
            <input id="task_id" value="<?php echo $data['task_id']; ?>" disabled>
            <input id="task_count" value="<?php echo $data['task_count']; ?>" disabled>
            <input id="total_seq_count" value="<?php echo $data['total_seq']; ?>" disabled>
            <input id="modbus_switch" value="1" >
            <input id="tool_status" value="1" > 
        </div>
        <div id="task_coordinate" style="display:none;">
            <?php foreach ($data['task_list'] as $key => $task){
                echo '<input id="task_'.$task['task_id'].'_x" value="'.$task['position_x'].'">';
                echo '<input id="task_'.$task['task_id'].'_y" value="'.$task['position_y'].'">';
                echo '<input id="task_'.$task['task_id'].'_tolerance" value="'.$task['tolerance'].'">';
                echo '<input id="task_'.$task['task_id'].'_gtcs_job_id" value="'.$task['gtcs_job_id'].'">';
                
                echo '<input id="task_'.$task['task_id'].'_targettype" value="'.$task['last_targettype'].'">'; //targettype
                if($task['last_targettype'] == 1){// angle
                    echo '<input id="task_'.$task['task_id'].'_target_value" value="'.$task['last_step_targetangle'].'">'; //target torque
                    echo '<input id="task_'.$task['task_id'].'_target_hi" value="'.$task['last_step_highangle'].'">'; //hi angle
                    echo '<input id="task_'.$task['task_id'].'_target_lo" value="'.$task['last_step_lowangle'].'">'; //lo angle
                }else{// torque
                    echo '<input id="task_'.$task['task_id'].'_target_value" value="'.$task['program']['step_targettorque'].'">'; //target torque
                    echo '<input id="task_'.$task['task_id'].'_target_hi" value="'.$task['program']['step_hightorque'].'">'; //hi torque
                    echo '<input id="task_'.$task['task_id'].'_target_lo" value="'.$task['program']['step_lowtorque'].'">'; //lo torque
                    echo '<input id="task_'.$task['task_id'].'_target_value" value="'.$task['last_step_targettorque'].'">'; //target torque
                    echo '<input id="task_'.$task['task_id'].'_target_hi" value="'.$task['last_step_hightorque'].'">'; //hi torque
                    echo '<input id="task_'.$task['task_id'].'_target_lo" value="'.$task['last_step_lowtorque'].'">'; //lo torque
                }
            }?>

        </div>

    </header>

    <!-- Notification -->
    <div id="messageBox" class="messageBox" style="display: none;">
        <div class="topnav-message">
            <label type="text" style="font-size: 24px; padding-left: 3%; margin: 7px 0; color: #000"><b>Notification</b></label>
            <span class="close w3-display-topright" onclick="ClickNotification()">&times;</span>
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
                        <label class="t1">Recycle box</label>
                        <label class="t2">workstation 3</label>
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
                        <label class="t1">Recycle box</label>
                        <label class="t2">workstation 3</label>
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
                        <label class="t1">Recycle box</label>
                        <label class="t2">workstation 3</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Virtual Message -->
    <div id="VirtualMessage" class="virtual-message" style="display: none;vertical-align: middle;">
        <div class="topnav">
            <label type="text" style="font-size: 20px; padding-left: 3%; margin: 7px 0"><b>Virtual Message</b></label>
            <span class="close w3-display-topright" onclick="ClickVirtualMessage()">&times;</span>
        </div>
        <div class="scrollbar-Message_text" id="style-Message_text">
            <div class="force-overflow_Message_text">
                <div id="Message_text" style="padding-left: 6%">
                    <form action="">
                        <textarea id="w3review" name="w3review" rows="4" cols="40">Kilews A professional electric screwdriver manufacturer.</textarea>
                    </form>
                </div>
                <div style="padding-left: 6%;">
                    <img src="./img/message.svg" style="height: 250px; width: 300px" alt="Nature">
                </div>
            </div>
        </div>
        <label style="bottom:0px; float:right; color:red; margin-right: 5px; padding: 5px">Close in 5 sec</label>
    </div>

    <!-- Identity Verify -->
    <div id="IdentityVerify" class="identity-verify" style="display: none;vertical-align: middle;">
        <div class="topnav">
            <label type="text" style="font-size: 20px; padding-left: 3%; margin: 7px 0"><b>Identity verify</b></label>
            <span class="close w3-display-topright" onclick="toggleIdentityVerify()">&times;</span>
        </div>
        <div class="w3-center identity-input">
            <label style="text-align: center; font-size: 18px">Enter identity verification</label>
            <input type="text" class="form-control" id="Operator" maxlength="" value="">
        </div>
        <button class="VerifyButton" id="VerifyButton">Verify</button>
    </div>


        <div class="input-group mb-1">
            <span class="input-group-text" style="background-color: #F2F1F1; font-size: 2vmin">Barcode</span>
            <input id="barcode" type="text" class="form-control"  style="font-size: 2vmin; background-color: #fff;">&nbsp;&nbsp;

            <span class="input-group-text" style="background-color: #F2F1F1; font-size: 2vmin">Job name</span>
            <input id="job_name" type="text" class="form-control"  disabled="disabled" style="font-size: 2vmin; background-color: #DDDDDD;">
            <button class="btn btn-secondary" type="button" style="vertical-align: sub;font-size: 2vmin;" onclick="document.getElementById('change_job').style.display='block'">Call Job</button>&nbsp;&nbsp;

            <span class="input-group-text" style="background-color: #F2F1F1; font-size: 2vmin">Seq name</span>
            <input id="seq_name" type="text" class="form-control"  disabled="disabled" style="font-size: 2vmin; background-color: #DDDDDD;">&nbsp;&nbsp;

            <span class="input-group-text" style="background-color: #F2F1F1; font-size: 2vmin">Task time</span>
            <input id="task_time" type="text" class="form-control"  disabled="disabled" style="font-size: 2vmin; background-color: #DDDDDD;">
            <span class="input-group-text" style="font-size: 2vmin">sec</span>
        </div>

    <div class="main-content">
        <div class="left">
            <div class="highlight" style="font-size: 2vmin">Tightening Status</div>
            <div class="container  my-1 custom-border">
                <div id="tightening_status" class="container center-text">Ready</div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">TR</span>
                    <input id="tightening_repeat" type="text" class="form-control" placeholder=" 0 / 2" style="font-size: 1.8vmin">
                    <button class="btn btn-secondary" type="submit" style="font-size: 1.8vmin">&#8635;</button>
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">Time</span>
                    <input id="tightening_time" type="text" class="form-control" placeholder="100" style="font-size: 1.8vmin">
                    <span class="input-group-text" style="font-size: 1.5vmin">sec</span>
                </div>
            </div>

            <div class="container my-1 custom-border">
                <div class="highlight" style="margin-bottom: 3%; font-size: 2vmin">Target Torque</div>
                <div class="container row" id="Torque"  style="margin-left: 1px">
                    <div id="target_torque" class="col text-black" style="font-size: 4vmin">00.6</div>
                    <div class="col text-black" style="font-size: 1.5vmin">Nm</div>
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">Hi Q</span>
                    <input id="high_torque" type="text" class="form-control" placeholder="00.7" style="font-size: 1.8vmin">
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">Lo Q</span>
                    <input id="low_torque" type="text" class="form-control" placeholder="00.3" style="font-size: 1.8vmin">
                </div>
            </div>

            <div class="container my-1">
                <div class="highlight" style="margin-bottom: 3%; font-size: 2vmin">Target Angle</div>
                <div class="container row" id="Thread" style="margin-left: 1px">
                    <div id="target_angle" class="col text-black" style="font-size: 4vmin">1080</div>
                    <div class="col text-black" style="font-size: 1.5vmin">deg</div>
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">Hi A</span>
                    <input id="high_angle" type="text" class="form-control" placeholder="1380" style="font-size: 1.8vmin">
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text" style="font-size: 1.8vmin">Lo A</span>
                    <input id="low_angle" type="text" class="form-control" placeholder="760" style="font-size: 1.8vmin">
                </div>
            </div>
        </div>

        <div class="center">
            <div class="center-content">
                <div id="img-container" class="img">
                    <?php
                        if( !empty($data['task_list'] )){
                            // echo $data['task_list'][count($data['task_list'])-1]['circle_div'];

                            echo '<img id="imgId" style="width: 100%;height: auto;" src="'.$data['seq_img'].'">';
                            foreach ($data['task_list'] as $key => $value) {
                                echo '<div class="circle" data-id="'.($key+1).'" '.$value['circle_div'].'>';
                                echo '<span class="">'.($key+1).'</span>';
                                echo '<div class="circle-border"></div>';
                                echo '</div>';
                            }
                        }

                    ?>
                </div>
            </div>

            <!-- Sequence Select Modal -->
            <div id="SeqSelect" class="modal" style="top: 34%; left: 18%">
                <form class="w3-modal-content w3-animate-zoom" action="" style="width:280px; height: 150px">
                    <div class=" w3-light-grey">
                        <header class=" w3-container modal-header">
                            <span onclick="document.getElementById('SeqSelect').style.display='none'"
                            class="w3-button w3-dark-grey w3-display-topright" style="margin: 0px; height: 48px; width: 45px">&times;</span>
                            <div style="text-align:center; font-size: 20px; color: #000">Seq List</div>
                        </header>
                        <table id="seq_list" style="margin: 5px 10px 0px">
                            <tr>
                                <td align="left">Total Seq :
                                    <input style="text-align: center; margin-bottom: 2%" id="RecordCnt" name="RecordCnt" readonly="readonly" disabled size="3" maxlength="3" value="<?php echo $data['total_seq']; ?>">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <select style="margin: center" id="JobName" name="JobNameSelect" size="215">
                                         <?php foreach ($data['seq_list'] as $key => $seq) {
                                            echo "<option value=".$seq['seq_id'].">{$seq['seq_id']} &nbsp;{$seq['seq_name']}</option>";
                                        } ?>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <div class="modal-footer justify-content-center">
                             <button type="button" class="btn btn-primary" onclick="change_seq('')" >OK</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="btn-menu">
                <button id="" class="btn-previous" onclick="change_seq('previous')">&#10094;</button>
                <button id="" class="btn-seq-list" onclick="document.getElementById('SeqSelect').style.display='block'">&#9776;</button>
                <button id="" class="btn-next" onclick="change_seq('next')">&#10095;</button>
            </div>
        </div>

        <!-- Call Job -->
        <div id="change_job" class="modal" style="top: 15%; ">
            <form class="w3-modal-content w3-animate-zoom" action="" style="width: 250px;">
                <div class=" w3-light-grey">
                    <header class=" w3-container modal-header">
                        <span onclick="document.getElementById('change_job').style.display='none'"
                        class="w3-button w3-dark-grey w3-display-topright" style="margin: 0px; height: 48px; width: 45px">&times;</span>
                        <div style="text-align:center; font-size:20px; color: #000">Job List</div>
                    </header>
                    <table id="job_list" style="margin: 5px 10px 0px;width: 100%; height: 80px">
                        <tr>
                            <td style=" text-align: center; ">
                                <select style="font-size: larger; width: 180px" id="Change_Job_Id">
                                <?php
                                    foreach ($data['job_list'] as $key => $job) {
                                    echo '<option value="'.$job['job_id'].'">'.$job['job_name'].'</option>';
                                }
                                ?>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-primary" onclick="change_job(1);">OK</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="right">
            <div id="task-setting" class="container my-3">
                <div class="input-group mb-3">
                    <span class="input-group-text"  style="font-size: 1.8vmin">Task</span>
                    <input id="task_serail" type="text" class="form-control" placeholder="2 / 2"  style="font-size: 1.8vmin">
                    <button class="btn btn-secondary" type="submit"  style="font-size: 1.8vmin">&#8635;</button>
                </div>
                <div id="task_list" class="tasklist">
                    <?php
                        echo '<ol>';
                        foreach ($data['task_list'] as $key => $value) {
                            // echo '<ol>';
                            echo '<div>';
                            if($value['last_targettype'] == 1){//angle
                                echo '<a id="step'.$value['task_id'].'" ><img src="./img/angle.png" alt="" style="height: 25px; width: 25px; float: left"> | SGT-CS303 | step'.$value['last_step_count'].' | '.$value['last_step_name'].' | '.$value['last_step_targetangle'].'&ordm;</a>';
                                echo '<div class="dropdown-content" id="target_torque-'.$value['task_id'].'" style="display:none;" step-id="'.$value['task_id'].'">';

                                if($value['last_job_type'] == 'normal'){
                                    echo '<div id="">Step1 '. $value['last_step_name'] .' | <span>'.$value['last_step_targetangle'].'&ordm;| Hi '.$value['last_step_highangle'].' | Lo '.$value['last_step_lowangle'].'</span></div>';
                                }else{
                                    foreach ($value['program'] as $key => $value) {
                                        if($value['step_targettype'] == 1 ){//angle
                                            echo '<div id="">Step'.($key+1).' '. $value['step_name'] .' | <span>'.$value['step_targetangle'].'&ordm;| Hi '.$value['step_highangle'].' | Lo '.$value['step_lowangle'].'</span></div>';
                                        }else{
                                            echo '<div id="">Step'.($key+1).' '. $value['step_name'] .' | <span>'.$value['step_targettorque'].'-Nm| Hi '.$value['step_hightorque'].' | Lo '.$value['step_lowtorque'].'</span></div>';
                                        }
                                    }
                                }

                                
                            }else{//torque
                                echo '<a id="step'.$value['task_id'].'" ><img src="./img/torque.png" alt="" style="height: 25px; width: 25px; float: left"> | SGT-CS303 | step'.$value['last_step_count'].' | '.$value['last_step_name'].' | '.$value['last_step_targettorque'].'-Nm</a>';
                                echo '<div class="dropdown-content" id="target_torque-'.$value['task_id'].'" style="display:none;" step-id="'.$value['task_id'].'">';

                                if($value['last_job_type'] == 'normal'){
                                    echo   '<div id="">Step1 '. $value['last_step_name'] .' | <span>'.$value['last_step_targettorque'].'-Nm| Hi '.$value['last_step_hightorque'].' | Lo '.$value['last_step_lowtorque'].'</span></div>';
                                }else{
                                    foreach ($value['program'] as $key => $value) {
                                        if($value['step_targettype'] == 1 ){//angle
                                            echo '<div id="">Step'.($key+1).' '. $value['step_name'] .' | <span>'.$value['step_targetangle'].'&ordm;| Hi '.$value['step_highangle'].' | Lo '.$value['step_lowangle'].'</span></div>';
                                        }else{
                                            echo '<div id="">Step'.($key+1).' '. $value['step_name'] .' | <span>'.$value['step_targettorque'].'-Nm| Hi '.$value['step_hightorque'].' | Lo '.$value['step_lowtorque'].'</span></div>';
                                        }
                                    }
                                }
                                
                            }
                            echo    '</div>';
                            echo '</div>';
                            // echo '</ol>';
                        }
                        echo '</ol>';
                    ?>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div id="screw_info_div" class="column">
            <div class="zoom">
                <h5 style="font-size: 2.3vmin; line-height: 30px; text-align: left">Screw info</h5>
                <label style="color: green; font-size: 2.8vmin;"><b><span id="screw_info">Retry or NG 2/2</span></b></label>
           </div>
        </div>

        <div id="arm_div" class="column">
            <div class="zoom" style="">
                <h5 style="font-size: 2.3vmin; line-height: 30px; text-align: left"><img class="images" src="./img/operation-arm.svg" style="float: left">ARM</h5>
                <label style="color: #FFFF00; font-size: 2.5vmin; text-align: left;padding-left: 31px"><b><span id="coordinate"></span></b></label>
            </div>
        </div>

        <div id="tool_div" class="column" onclick="completeTask()">
            <div class="zoom" style="">
                <h5 style="font-size: 2.3vmin; text-align: left;">
                    <img class="images" src="./img/torque.png" style="float: left; height: 20px;">Tool<br><span id="tool_name" style="padding-left:3px">SGT-CS303</span>
                </h5>
                <div id="completedIcon" style="display:block; text-align: left;padding-left: 31px">
                    <span id="tool_task_id" style="color: #000">P1</span>
                    <span id="tool_status_icon">
                    <!-- <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="green">
                        <path d="M0 0h24v24H0z" fill="none"/>
                        <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"/>
                    </svg> -->
                    </span>
                </div>
            </div>
        </div>

        <div id="socket_tray_div" class="column">
            <div class="zoom">
                <h5 style="font-size: 2.3vmin; line-height: 30px; text-align: left"><img class="images" src="./img/socket-tray.png" style="float: left">Socket tray</h5>
            </div>
        </div>

        <div id="picking_module" class="column">
            <div class="zoom">
                <h5 style="font-size: 2.3vmin; line-height: 30px; text-align: left"><img class="images" src="./img/picking-module.png" style="float: left; height: 20px; width: 30px">Picking module</h5>
            </div>
        </div>

        <div id="screw_feeder_div" class="column">
            <div class="zoom">
                <h5 style="font-size: 2.3vmin; line-height: 30px; text-align: left">Screw feeder</h5>
            </div>
        </div>
    </footer>

</div>
<style>
#completedIcon
{
    display: none;
    color: #2A7E54;
}
</style>


<script>
// Get the modal
var modal = document.getElementById('SeqSelect');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<script>

    function completeTask()
    {
        var completedIcon = document.getElementById('completedIcon');
        completedIcon.style.display = 'block';
        completedIcon.style.fontSize = "3vmin";
    }

    // function updateParameters()
    // {

    //     var target_detail = document.getElementById('target_detail');
    //     if (target_detail.style.display === 'none')
    //     {
    //         target_detail.style.display = 'block';
    //     }
    //     else
    //     {
    //         target_detail.style.display = 'none';
    //     }

    // }

    function updateParameters(index)
    {
        var target_torque = document.getElementById('target_torque-'+index);
        var step = document.getElementById('step'+index);
        var last_step = document.getElementById('step'+ (index - 1 ) );

        let targettype = document.getElementById('task_'+index+'_targettype');
        let target_value = document.getElementById('task_'+index+'_target_value');
        let target_hi = document.getElementById('task_'+index+'_target_hi');
        let target_lo = document.getElementById('task_'+index+'_target_lo');

        //先關閉全部
        var Divs = document.querySelectorAll("div[id^='target_torque-']");
        Divs.forEach(function(div) {        
            div.style.display = 'none';
            // div.previousElementSibling.style.color = 'black';
            // div.previousElementSibling.style.backgroundColor = '#fff';
            div.classList.remove("seleted");
        });

        if (target_torque.style.display.trim() === 'none')
        {
            target_torque.style.display = 'block';
            // step.style.color = 'white';
            // step.style.backgroundColor = '#2A7E54';
            target_torque.classList.add("seleted");
        }
        else
        {
            target_torque.style.display = 'none';
            // step.style.color = 'black';
            // step.style.backgroundColor = '#fff';
            target_torque.classList.remove("seleted");
        }

        //index bg-color = #44d0ff => runnuing
        step.style.backgroundColor = '#44d0ff';

        //smaller index-1 bg-color = green => finished
        if(last_step != null){
            last_step.style.color = 'white';
            last_step.style.backgroundColor = 'green';
            last_step.style.borderColor = 'green';
        }

        console.log('task_'+index+'_targettype')
        console.log(targettype.value);
        console.log(target_hi.value);
        console.log(target_lo.value);
        console.log(target_value.value);
        if(targettype.value == 1){//angle
            document.getElementById('target_angle').innerHTML = target_value.value;
            document.getElementById('high_angle').value = target_hi.value;
            document.getElementById('low_angle').value = target_lo.value;
            document.getElementById('target_torque').innerHTML = 0;
        }else{//torque
            document.getElementById('target_torque').innerHTML = target_value.value;
            document.getElementById('high_torque').value = target_hi.value;
            document.getElementById('low_torque').value = target_lo.value;
            document.getElementById('target_angle').innerHTML = 0;
            document.getElementById('high_angle').value = 999999;
            document.getElementById('low_angle').value = 0;
        }

        document.getElementById('tool_task_id').innerHTML = 'Task'+index;


    }


</script>

<script type="text/javascript">
let isSendingRequest = false;

$(document).ready(function () {
    initail();
    //img帶入
    document.getElementById('imgId').src = '<?php echo $data['seq_img']; ?>';
});

function initail() {
    // body...
    document.getElementById('barcode').value = '';
    document.getElementById('job_name').value = '<?php echo $data['job_data']['job_name']; ?>';
    document.getElementById('seq_name').value = '<?php echo $data['seq_data']['seq_name']; ?>';
    // document.getElementById('task_time') = '';
    document.getElementById('tightening_status').innerHTML = '';
    document.getElementById('tightening_repeat').value = ' 0 / 1';
    document.getElementById('tightening_time').value = '0';
    document.getElementById('target_torque').innerHTML = '<?php echo $data['task_list'][0]['last_step_targettorque']; ?>';
    document.getElementById('high_torque').value = '<?php echo  $data['task_list'][0]['last_step_hightorque']; ?>';
    document.getElementById('low_torque').value = '<?php echo  $data['task_list'][0]['last_step_lowtorque']; ?>';
    document.getElementById('target_angle').innerHTML = '<?php echo  $data['task_list'][0]['last_step_targetangle']; ?>';
    document.getElementById('high_angle').value = '<?php echo  $data['task_list'][0]['last_step_highangle']; ?>';
    document.getElementById('low_angle').value = '<?php echo  $data['task_list'][0]['last_step_lowangle']; ?>';
    // document.getElementById('screw_info_div').value = '';
    document.getElementById('screw_info').innerHTML = ' - ';
    // document.getElementById('arm_div').value = '';
    // document.getElementById('coordinate').innerHTML = '';
    // document.getElementById('tool_div').value = '';
    // document.getElementById('tool_name').innerHTML = '';
    document.getElementById('task_serail').value = '<?php echo $data['task_id'].'  /  '.$data['task_count'] ?>';
    // document.getElementById('task_list') = '';
    document.getElementById('task_time').value = 0;
    let task_id = document.getElementById('task_id').value;
    updateParameters(task_id);
    let aa = document.querySelector("div[data-id='"+task_id+"']");
    // aa.classList.add('running')
    aa.style.backgroundColor = '#44d0ff';
    aa.childNodes[1].classList.add('running');
    call_job();
    document.getElementById('Change_Job_Id').value = document.getElementById('job_id').value;
}
   
</script>

<!-- arm socket link -->
<script type="text/javascript">
    const wsServer = 'ws://192.168.0.115:9527';
    const websocket = new WebSocket(wsServer);
    
    websocket.onopen = function (evt) {
        console.log("Connected to WebSocket server.");
        let random = Math.floor(Math.random() * 100) + 1;
        document.getElementById('arm_div').classList.remove('gray-out');
        // send(random);
    };

    websocket.onclose = function (evt) {
        console.log("Disconnected");
        //把arm div反灰 gray-out
        document.getElementById('arm_div').classList.add('gray-out');
    };

    websocket.onmessage = function (evt) {
        // console.log('Retrieved data from server: ' + evt.data);
        let axis = evt.data.split(',');
        coordinate(axis);
        // document.getElementById('axis_x').value = axis[0];
        // document.getElementById('axis_y').value = axis[1];
    };

    websocket.onerror = function (evt, e) {
        console.log('Error occured: ' + evt.data);
    };

    function coordinate(axis) {
        // 关节角度（以弧度表示）
        let theta1 = deg2rad(axis[0]/32767 * 360); // 第一个关节的角度（弧度）
        let theta2 = deg2rad(axis[1]/32767 * 360 + 180); // 第二个关节的角度（弧度）

        // 机械臂长度
        let L1 = 50; // 第一个关节到第二个关节的长度
        let L2 = 50; // 第二个关节到末端的长度

        // 计算末端执行器的位置
        let x = L1 * Math.cos(theta1) + L2 * Math.cos(theta1 + theta2);
        let y = L1 * Math.sin(theta1) + L2 * Math.sin(theta1 + theta2);

        // document.getElementById('axis_x').value = x;
        // document.getElementById('axis_y').value = y;
        // console.log(`theta1: ${theta1}, theta2: ${theta2}`);
        // console.log(`x: ${x}, y: ${y}`);
        
        let round_x = Math.round(x*100);
        let round_y = Math.round(y*100);
        // document.getElementById('coordinate').innerHTML = round_x+','+round_y+'['++']';

        let task_id = document.getElementById('task_id').value;

        let target_x = +document.getElementById('task_'+task_id+'_x').value;
        let target_y = +document.getElementById('task_'+task_id+'_y').value;
        let bias = +document.getElementById('task_'+task_id+'_tolerance').value;

        document.getElementById('coordinate').innerHTML = round_x+','+round_y+'['+bias+']';

        // console.log(target_x)
        // console.log(target_y)
        // console.log(bias)

        let modbus_switch = document.getElementById('modbus_switch').value;
        let current_tool_status = document.getElementById('tool_status').value;

        if(round_x >= target_x-bias && round_x<= target_x+bias && round_y >= target_y-bias && round_y<= target_y+bias){
            document.getElementById('coordinate').style.backgroundColor = 'green';
            
            if(modbus_switch == 1 && current_tool_status == 0 && isSendingRequest == false){ //目前起子與要改變的狀態相反才發送
                // isSendingRequest = true;
                // websocket.send('enable');
                // isSendingRequest = false;
                console.log('send enable');
                switch_tool(1);
            }
        }else{
            document.getElementById('coordinate').style.backgroundColor = 'red';
            if(modbus_switch == 1 && current_tool_status == 1 && isSendingRequest == false){ //目前起子與要改變的狀態相反才發送
                // isSendingRequest = true;
                // websocket.send('disable');
                // isSendingRequest = false;
                console.log('send disable');
                switch_tool(0);
            }
        }
    }

    function deg2rad(degrees) {
      return degrees * (Math.PI / 180);
    }

</script>

<!-- operation -->
<script type="text/javascript">

    const fasten_status = [
          { index: 0, status: "Initialize", color: "" },
          { index: 1, status: "Tool Ready", color: "" },
          { index: 2, status: "Tool running", color: "" },
          { index: 3, status: "Reverse", color: "" },
          { index: 4, status: "OK", color: "green" },
          { index: 5, status: "OK-SEQ", color: "green" },
          { index: 6, status: "OK-JOB", color: "green" },
          { index: 7, status: "NG", color: "red" },
          { index: 8, status: "NG Stop", color: "red" },
          { index: 9, status: "Setting", color: "" },
          { index: 10, status: "EOC", color: "" },
          { index: 11, status: "C1", color: "" },
          { index: 12, status: "C2", color: "" },
          { index: 13, status: "C4", color: "" },
          { index: 14, status: "C5", color: "" },
          { index: 15, status: "BS", color: "" },
        ];
  //----------------------------------------
  let socket; // WebSocket对象
  const server_ip = '<?php echo CONTROLLER_IP; ?>';
  const serverUrl = 'ws://'+server_ip+':9501';

  const ipToTableRow = new Map();

  function connectWebSocket() {
      socket = new WebSocket(serverUrl);

      socket.addEventListener('open', (event) => {
          console.log('WebSocket连接已建立');
          // 在连接建立时可以执行其他逻辑
      });

      socket.addEventListener('message', (event) => {
          // 处理接收到的WebSocket消息
          handleWebSocketMessage(event);
          // console.log(event);
      });

      socket.addEventListener('close', (event) => {
          console.log('WebSocket连接已关闭');
          // 连接关闭时，设置定时器以尝试重新连接
          setTimeout(connectWebSocket, 5000); // 2秒后重新连接
      });

      socket.addEventListener('error', (event) => {
          console.error('WebSocket连接发生错误', event);
          // 在发生错误时也可以执行其他逻辑
      });
  }  

  // 初始连接
  connectWebSocket();

let retry_time = 0;
const tt = new Map();
tt.set('start_time',new Date())
// var date = new Date();
// console.log(tt)

  function handleWebSocketMessage(event) {
      const message = event.data;

      // 检查消息是否以 "client X said:" 开头
      const match = message.match(/^Client (\d+) said: (.*)/);

      if (match) {
          const clientNumber = match[1];
          const jsonMessage = match[2];

          try {
              const data = JSON.parse(jsonMessage);

              // console.log(data);
              
              // tt.set(ket,value);
              //判斷是否要更新
              let record_data_time = data.data_time
              // let record_date = new Date('6/29/2011 4:52:48 PM UTC+8');
              let formattedDate = record_data_time.substring(0, 4) + "-" + record_data_time.substring(4, 6) + "-" + record_data_time.substring(6, 8) + " " + record_data_time.substring(9) + ' UTC+0';
              var date = new Date(formattedDate);
              date.toString(); // "Wed Jun 29 2011 09:52:48 GMT-0700 (PDT)"

              // record_data_time = Date(formattedDate)
              let task_id = +document.getElementById('task_id').value;
              let gtcs_job_id = document.getElementById('task_'+task_id+'_gtcs_job_id').value;
              let task_count = document.getElementById('task_count').value;
              let start_time = tt.get('start_time');

              // console.log(start_time)
              // console.log(date)

              if(date > start_time){//紀錄比開啟網頁的時間還新

                if(data.job_id == gtcs_job_id && tt.has(data.system_sn) == false ){
                    console.log('---123----');
                    document.getElementById('modbus_switch').value = 0;
                    // alert(456);
                    tt.set(data.system_sn,data.system_sn)
                    //確認紀錄是否為當前設定對應的job
                    //yes:更新顯示 > 觸發下一個task(要更新task_id、加總task time) > call new job
                    //no:不作動

                    document.getElementById('tightening_status').innerHTML = fasten_status[data.fasten_status].status;
                    document.getElementById('tightening_status').style.backgroundColor = fasten_status[data.fasten_status].color;
                    document.getElementById('tightening_repeat').value = ' 1 / 1';
                    document.getElementById('tightening_time').value = data.fasten_time;
                    let ttime = +document.getElementById('task_time').value
                    ttime = ttime + +data.fasten_time;
                    ttime = ttime.toFixed(2);
                    document.getElementById('task_time').value = ttime;
                    document.getElementById('screw_info').value = data.fasten_torque;

                    if(task_id <= task_count){ 
                        let current_circle = document.querySelector("div[data-id='"+task_id+"']");
                        current_circle.childNodes[1].classList.remove('running')
                        // current_circle.classList.remove('running')
                        current_circle.classList.remove('ng')

                        if(data.fasten_status == 4 || data.fasten_status == 5 || data.fasten_status == 6 ){
                            //OK、OK-JOB、OK-SEQ
                            retry_time = 0;//retry測試歸零
                            document.getElementById('screw_info').innerHTML = retry_time + ' / '+ '-';
                            current_circle.classList.add('finished')
                            current_circle.childNodes[1].classList.remove('circle-border')
                            // current_circle.childNodes[0].classList.remove('inner-text');
                            task_id = task_id + 1;
                            if(task_id <= task_count){
                                document.getElementById('task_id').value = task_id;
                                updateParameters(task_id)
                                call_job();
                                // document.getElementById('modbus_switch').value = 1;
                                let next_circle = document.querySelector("div[data-id='"+task_id+"']");
                                // next_circle.classList.add('running')
                                next_circle.childNodes[1].classList.add('running')
                                next_circle.style.backgroundColor = '#44d0ff';
                                // next_circle.childNodes[0].classList.add('inner-text');
                                document.getElementById('task_serail').value = task_id+' / '+task_count;
                            }else{
                                document.getElementById('step'+(task_id-1)).style.color = 'white';
                                document.getElementById('step'+(task_id-1)).style.backgroundColor = 'green';
                                document.getElementById('step'+(task_id-1)).style.borderColor = 'green';
                                document.getElementById('tightening_status').innerHTML = 'OK-ALL';
                                document.getElementById('tightening_status').style.backgroundColor = 'yellow';
                                // document.getElementById('step'+task_id);
                                // isSendingRequest = false;
                                // setTimeout(() => { force_switch_tool(0); }, 1000);
                                
                                // switch_tool(0);
                                // switch_tool(0);
                                document.getElementById('modbus_switch').value = 0;
                                // setTimeout(() => { websocket.send('disable'); }, 1000);
                                
                                // isSendingRequest = true;
                                let current_seq_id = +document.getElementById('seq_id').value;
                                let total_seq_count = +document.getElementById('total_seq_count').value;
                                if(current_seq_id < total_seq_count){
                                    //change to next seq
                                    // change_job(current_seq_id + 1);
                                    setTimeout(() => { change_job(current_seq_id + 1); }, 500);
                                }else{
                                    setTimeout(() => { force_switch_tool(0); }, 1000);
                                    document.getElementById('modbus_switch').value = 0;
                                }
                            }
                        }else if(data.fasten_status == 7 || data.fasten_status == 8){
                            //NG、NG-STOP
                            current_circle.childNodes[1].classList.add('running')
                            current_circle.classList.add('ng');
                            retry_time = retry_time + 1;
                            document.getElementById('step'+task_id).style.backgroundColor = 'red';

                            document.getElementById('screw_info').innerHTML = retry_time + ' / '+ '-';
                            document.getElementById('modbus_switch').value = 1;
                        }

                    }
                }

              }


              
          } catch (error) {
              console.error("Error parsing JSON message: " + error);
          }
      }
  }

function call_job() {
    let task_id = +document.getElementById('task_id').value;
    let gtcs_job_id = document.getElementById('task_'+task_id+'_gtcs_job_id').value;
    let url = '?url=Operations/Call_Controller_Job';

    document.getElementById('modbus_switch').value = 0;

    setTimeout(() => {
        $.ajax({
            type: "POST",
            url: url,
            data: { 'job_id': gtcs_job_id },
            // dataType: "json",
            // async:false
        }).done(function(response) { //成功且有回傳值才會執行
            // alert(123)
            document.getElementById('modbus_switch').value = 1;
        });
    }, 666);

    
}

function change_job(seq_id){
    let job_id = document.getElementById('Change_Job_Id').value
    // let seq_id = 1;
    $.ajax({
        type: "POST",
        url: '?url=Operations/Change_Job',
        data: { 'job_id': job_id,'seq_id': seq_id },
    }).done(function(response) { //成功且有回傳值才會執行
        // alert(123)
        console.log(response);
        history.go(0);
    });
}

function change_seq(direction) {

    let seq_id = document.getElementById('seq_id').value;
    let total_seq = document.getElementById('total_seq_count').value;
    if (direction == 'previous') {
        seq_id = +seq_id - 1; 
    }else if(direction == 'next'){
        seq_id = +seq_id + 1; 
    }else{
        seq_id = document.getElementById('SeqName').value;
    }

    if (seq_id > total_seq) {
        alert('last seq');
        return 0;
    }

    if (seq_id < 1) {
        alert('first seq');
        return 0;
    }

    change_job(seq_id)
}


// let isSendingRequest = false;

setInterval(function() {

    let modbus_switch = document.getElementById('modbus_switch').value
    // 發送 AJAX 請求到服務器
    if (isSendingRequest || modbus_switch == 0) {
        // 如果正在發送，不執行新的请求
        return;
    }
    isSendingRequest = true;
    $.ajax({
        url: '?url=Operations/ToolStatusCheck', // 指向服務器端檢查更新的 PHP 腳本
        method: 'GET',
        dataType: "json",
        success: function(response) {
            // 處理服務器返回的響應
            document.getElementById('tool_status').value = response.result;
            if(response.result == 1){//tool enable
                document.getElementById('tool_status_icon').innerHTML = '<svg width="24px" height="24px" viewBox="0 0 281.25 281.25" id="svg2" version="1.1" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <defs id="defs4"></defs> <g id="layer1" transform="translate(6693.6064,-4597.9898)"> <path d="m -6552.9808,4636.829 c -56.159,0 -101.7865,45.6275 -101.7865,101.7865 0,56.1591 45.6274,101.7847 101.7865,101.7847 56.1592,0 101.7847,-45.6256 101.7847,-101.7847 0,-56.159 -45.6256,-101.7865 -101.7847,-101.7865 z m 0,9.375 c 51.0925,0 92.4097,41.319 92.4097,92.4115 0,51.0925 -41.3171,92.4097 -92.4097,92.4097 -51.0924,0 -92.4115,-41.3172 -92.4115,-92.4097 0,-51.0925 41.3191,-92.4115 92.4115,-92.4115 z m 48.0341,54.2413 a 4.6875,4.6875 0 0 0 -3.3142,1.3733 l -63.1055,63.1055 -28.1653,-26.0669 a 4.6875,4.6875 0 0 0 -6.6229,0.2563 4.6875,4.6875 0 0 0 0.2563,6.6248 l 31.4722,29.1284 a 4.6879687,4.6879687 0 0 0 6.5002,-0.1245 l 66.2934,-66.2952 a 4.6875,4.6875 0 0 0 0,-6.6284 4.6875,4.6875 0 0 0 -3.3142,-1.3733 z" id="circle1193" style="color:#008000;fill:#008000;fill-opacity:1;fill-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;-inkscape-stroke:none"></path> </g> </g></svg>';
            }else{//tool disable
                document.getElementById('tool_status_icon').innerHTML = '<svg width="24px" height="24px" viewBox="0 0 1024 1024" fill="red" class="icon" version="1.1" xmlns="http://www.w3.org/2000/svg" stroke="red"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><path d="M512 897.6c-108 0-209.6-42.4-285.6-118.4-76-76-118.4-177.6-118.4-285.6 0-108 42.4-209.6 118.4-285.6 76-76 177.6-118.4 285.6-118.4 108 0 209.6 42.4 285.6 118.4 157.6 157.6 157.6 413.6 0 571.2-76 76-177.6 118.4-285.6 118.4z m0-760c-95.2 0-184.8 36.8-252 104-67.2 67.2-104 156.8-104 252s36.8 184.8 104 252c67.2 67.2 156.8 104 252 104 95.2 0 184.8-36.8 252-104 139.2-139.2 139.2-364.8 0-504-67.2-67.2-156.8-104-252-104z" fill=""></path><path d="M707.872 329.392L348.096 689.16l-31.68-31.68 359.776-359.768z" fill=""></path><path d="M328 340.8l32-31.2 348 348-32 32z" fill=""></path></g></svg>';
            }

            isSendingRequest = false;
        },
        complete: function(XHR, TS) {
            XHR = null;
            // console.log("执行一次"); 
        },
        error: function(xhr, status, error) {
            // console.log("fail");
        }
    });
}, 300); // 每隔5秒發送一次請求，可以根據需要調整時間間隔



function switch_tool(status) {
    let modbus_switch = document.getElementById('modbus_switch').value;
    if (isSendingRequest || modbus_switch == 0) {
        // 如果正在發送，不執行新的请求
        return;
    }
    isSendingRequest = true;
    $.ajax({
        url: '?url=Operations/Switch_Tool_Status', // 指向服務器端檢查更新的 PHP 腳本
        method: 'POST',
        data: { 'tool_status': status },
        dataType: "json",
        success: function(response) {
            // 處理服務器返回的響應
            // document.getElementById('tool_status').value = response.result;

            isSendingRequest = false;
        },
        complete: function(XHR, TS) {
            XHR = null;
            // console.log("执行一次"); 
        },
        error: function(xhr, status, error) {
            // console.log("fail");
        }
    });
}


function force_switch_tool(status) {

    console.log(666)
    let done = true;

    while(done){

        let modbus_switch = document.getElementById('modbus_switch').value;
        console.log(isSendingRequest)
        console.log(modbus_switch)
        document.getElementById('modbus_switch').value = 1;
        isSendingRequest = false;
        if (isSendingRequest || modbus_switch == 0) {
            // 如果正在發送，不執行新的请求
            continue;
        }
        isSendingRequest = true;
        document.getElementById('modbus_switch').value = 0;
        // isSendingRequest = true;
        $.ajax({
            url: '?url=Operations/Switch_Tool_Status', // 指向服務器端檢查更新的 PHP 腳本
            method: 'POST',
            data: { 'tool_status': status },
            dataType: "json",
            success: function(response) {
                // 處理服務器返回的響應
                // document.getElementById('tool_status').value = response.result;
                document.getElementById('tool_status_icon').innerHTML = '<svg width="24px" height="24px" viewBox="0 0 1024 1024" fill="red" class="icon" version="1.1" xmlns="http://www.w3.org/2000/svg" stroke="red"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><path d="M512 897.6c-108 0-209.6-42.4-285.6-118.4-76-76-118.4-177.6-118.4-285.6 0-108 42.4-209.6 118.4-285.6 76-76 177.6-118.4 285.6-118.4 108 0 209.6 42.4 285.6 118.4 157.6 157.6 157.6 413.6 0 571.2-76 76-177.6 118.4-285.6 118.4z m0-760c-95.2 0-184.8 36.8-252 104-67.2 67.2-104 156.8-104 252s36.8 184.8 104 252c67.2 67.2 156.8 104 252 104 95.2 0 184.8-36.8 252-104 139.2-139.2 139.2-364.8 0-504-67.2-67.2-156.8-104-252-104z" fill=""></path><path d="M707.872 329.392L348.096 689.16l-31.68-31.68 359.776-359.768z" fill=""></path><path d="M328 340.8l32-31.2 348 348-32 32z" fill=""></path></g></svg>';
                isSendingRequest = false;
                // document.getElementById('modbus_switch').value = 0;
            },
            complete: function(XHR, TS) {
                XHR = null;
                // console.log("执行一次"); 
            },
            error: function(xhr, status, error) {
                // console.log("fail");
            }
        });

        done = false;
    }


    
}

</script>


<script>

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



function ClickVirtualMessage()
{
    let VirtualMessage = document.getElementById('VirtualMessage');
    let closeBtn = document.getElementsByClassName("close")[0];
    VirtualMessage.style.display = (VirtualMessage.style.display === 'block') ? 'none' : 'block';
}

function toggleIdentityVerify()
{
    let IdentityVerify = document.getElementById('IdentityVerify');
    let closeBtn = document.getElementsByClassName("close")[0];
    IdentityVerify.style.display = (IdentityVerify.style.display === 'block') ? 'none' : 'block';
}

</script>

<style>
    .running {
/*      width: 200px;*/
/*      height: 200px;*/
      background-color: #00bcd400;
      color: black;
      border-color: #44d0ff !important;
      border: 2px dashed #000;
      display: flex;
      justify-content: center;
      align-items: center;
      animation: container-rotate 2s linear infinite;
    }

    .inner-text {
      transform: rotate(0deg);
      animation: no-rotate 2s linear infinite;
    }

    .finished {
      background-color: green !important;
      color: black;
      border: none;
    }

    .waitting {

    }

    .ng {
      background-color: red !important;
      color: black;
      border: none;
    }

    @keyframes no-rotate {
      0% {
        transform: rotate(-0deg);
      }
      100% {
        transform: rotate(-360deg);
      }
    }

    @keyframes container-rotate {
      0% {
        transform: rotate(0deg) scale(1.2);
      }
      50% {
        transform: rotate(180deg) scale(1.5);
      }
      100% {
        transform: rotate(360deg) scale(1.2);
      }
    }

    .gray-out {
      pointer-events: none;
      opacity: 0.5;
    }

</style>

<style>
.circle{
    scale:<?php echo (1 + 1*($data['job_data']['point_size']/100) );?>;
}
</style>



<?php require APPROOT . 'views/inc/footer.tpl'; ?>