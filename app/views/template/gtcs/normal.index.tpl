<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/program_normal.css" type="text/css">

<?php echo $data['nav']; ?>

<style>

.t1{font-size: 17px; margin: 3px 0px; display: flex; align-items: center;}
.t2{font-size: 17px; margin: 3px 0px;}
</style>

<div class="container-ms">

    <header>
        <div class="program">
            <img id="header-img" src="./img/template-head.svg">Program Template
        </div>
        <div class="notification"><i style=" width:auto; height: 40px" class="fa fa-bell"></i> Notification</div>
        <div class="personnel"><i style=" width:auto; height: 40px" class="fa fa-desktop"></i> Personnel IP</div>
    </header>

    <div class="topnav">
        <label type="text" style="font-size: 22px; margin: 6px;">Program - Normal</label>
        <div class="topnav-right">
            <button class="btn" id="back-btn" type="button" onclick="location.href = '?url=Templates/';">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
    </div>

    <div class="main-content">
        <div class="center-content">
            <div class="row" style="margin-bottom: 5px;">
                <div for="controller-type" class="col-1 t1">Controller :</div>
                <div class="col-1 t2" style="margin-right: 3%">
                    <input type="text" class="form-control input-ms" id="controller-type" value="GTCS" maxlength="" disabled="disabled">
                </div>

                <div for="controller-type" class="col-1 t1">Screw Tool :</div>
                <div class="col-2 t2" style="margin-right: 2%">
                    <input type="text" class="form-control input-ms" id="screw-type" value="SGT-CS303" maxlength="" disabled="disabled">
                </div>

                <div class="col">
                    <button id="add-program" type="button" onclick="new_program()">
                        <img id="img-program" src="./img/add-program.svg" alt="">Add Program
                    </button>

                    <button id="copy-program" type="button" onclick="copy_program_div()">
                        <img id="img-copy" src="./img/program-copy.svg" alt="">Copy
                    </button>

                    <button id="delete-program" type="button" onclick="delete_program()">
                        <img id="img-delete" src="./img/program-delete.svg" alt="">Delete
                    </button>
                </div>
            </div>

            <div class="scrollbar" id="style-program">
                <div class="force-overflow">
                    <table class="table table-bordered" id="table">
                        <thead id="header-table" style="background-color: #A3A3A3; font-size: 2vmin">
                            <tr style="text-align: center">
                                <th width="5%"></th>
                                <th width="10%">Program ID</th>
                                <th width="20%">Program Name</th>
                                <th width="20%">Target Q</th>
                                <th width="15%">Target A</th>
                                <th width="10%">Edit</th>
                                <th width="18%">Hi / Lo</th>
                            </tr>
                        </thead>
                        <tbody id="tbody" style="background-color: #F2F1F1; font-size: 2vmin; text-align: center">
                            <?php
                            foreach ($data['NormalSteps'] as $key => $value) {
                                echo '<tr>';
                                echo  '<td><input class="form-check-input" type="checkbox" name="" id="" value="0" style="zoom:1.0; vertical-align: middle"></td>';
                                echo  '<td>'.$value['template_program_id'].'</td>';
                                echo  '<td>'.$value['step_name'].'</td>';
                                echo  '<td>'.$value['step_targettorque'].' Nm'.'</td>';//target torque
                                echo  '<td>'.$value['step_targetangle'].' &#186;</td>';//target angle
                                echo  '<td style="text-align: center">';

                                if($value['step_targettype'] == 2){  //edit image
                                    echo  '<img src="./img/torque.png" width="40" height="40" alt="" onclick="edit_program('.$value['template_program_id'].')">';
                                }else{
                                    echo  '<img src="./img/angle.png" width="40" height="40" alt="" onclick="edit_program('.$value['template_program_id'].')">';
                                }

                                echo  '</td>';
                                echo  '<td style="text-align: left; display: flex;justify-content: space-between;align-items: center;">';

                                if($value['step_targettype'] == 2){  //
                                    echo    $value['step_hightorque'].' / '.$value['step_lowtorque'].'Nm';// Hi-Q / Lo-Q value
                                }else{
                                    echo    $value['step_highangle'].'º / '.$value['step_lowangle'].'º';// Hi-Q / Lo-Q value
                                }

                                echo    '<div class="dropdown">';
                                echo        '<label><img src="./img/info-30.png" alt="" onclick="toggleDropdown('.$value['template_program_id'].')" class="right-aligned-image"></label>';//target type
                                echo        '<div id="Detail-Dropdown-'.$value['template_program_id'].'" class="dropdown-content">';

                                if($value['step_targettype'] == 2){  //
                                    echo '<a>Thredhold Type :<i style="float: right">'.'Torque'.'</i></a>';
                                }else{
                                    echo '<a>Thredhold Type :<i style="float: right">'.'Angle'.'</i></a>';
                                }

                                echo            '<a>Thredhold Torque :<i style="float: right">'.$value['step_targettorque'].'</i></a>';
                                echo            '<a>Thredhold Angle :<i style="float: right">'.$value['step_targetangle'].'</i></a>';
                                echo            '<a>Downshif Enable :<i style="float: right">'.$value['step_downshift_enable'].'</i></a>';
                                echo            '<a>Downshif Torque :<i style="float: right">'.$value['step_downshift_torque'].'</i></a>';
                                echo            '<a>Downshif Speed :<i style="float: right">'.$value['step_downshift_speed'].'</i></a>';
                                // echo            '<a>Over Angle Stop :<i style="float: right">'.$value['template_program_id'].'</i></a>'; //新功能
                                echo            '<a>Hi Angle :<i style="float: right">'.$value['step_highangle'].'&#186;</i></a>';
                                echo            '<a>Lo Angle :<i style="float: right">'.$value['step_lowangle'].'</i></a>';
                                echo            '<a>Pre-Run :<i style="float: right">'.$value['step_prr'].'</i></a>';
                                echo            '<a>Pre-Run RPM :<i style="float: right">'.$value['step_prr_rpm'].'</i></a>';
                                echo            '<a>Pre-Run Angle :<i style="float: right">'.$value['step_prr_angle'].'</i></a>';
                                echo        '</div>';
                                echo    '</div>';
                                echo '</td>';
                                echo '</tr>';
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

     <!-- New Program -->
    <div id="ProgramNew" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width:100%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('ProgramNew').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3 id="modal_head">New Program</h3>
                </header>

                <div class="modal-body">
                    <form id="new_task_form">
                        <div class="row t1">
                            <div for="new_task_form" class="col-3 t1" style="font-size: 18px"><b>Target Type :</b></div>
                            <div class="col t2">
                                <div class="col-4 form-check form-check-inline">
                                    <input class="form-check-input t2" type="radio" checked="checked" name="Target-Type" id="Target-Torque" value="2" onclick="TargetTypeCheckbox()" style="zoom:1.2; vertical-align: middle">
                                    <label class="form-check-label t2" for="Target-Torque">Torque Parameter</label>
                                </div>
                          	    <div class="col-4 form-check form-check-inline">
                                    <input class="form-check-input t2" type="radio" name="Target-Type" id="Target-Angle" value="1" onclick="TargetTypeCheckbox()" style="zoom:1.2; vertical-align: middle">
                                    <label class="form-check-label t2" for="Target-Angle">Angle Parameter</label>
                                </div>
                            </div>
                        </div>

                        <!-- Torque Setting -->
                        <div id="Torque_Parameter" style="display: block">
                            <div class="row t1">
                                <div class="col-4 t1" style="padding-left: 5%">
                                    <img src="./img/torque.png" width="40" height="40" alt="">&nbsp;&nbsp;
                                    <b>Torque Parameter</b>
                                </div>
                            </div>
                            <div class="scrollbar-modal" id="style-torque">
                                <div class="modal-force-overflow">
                                    <div style="padding-left: 5%; background-color: #D9D9D9">
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Max Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="max-torque" class="form-control input-ms" value="5.0" maxlength="" disabled="disabled">
                                            </div>
                                            <div class="col t2">N.m</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Program ID :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="" disabled="disabled">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Program Name :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="program-name" class="form-control input-ms" value="SEQ-1" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Target Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="target-torque" class="form-control input-ms" value="0.6" maxlength="">
                                            </div>
                                            <div class="col t2">N.m</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Joint Offset :</div>
                                            <div class="col-1 t2">
                              					<select id="joint-offset" style="width: 50px; height: 32px; border: 0">
                               					    <option value="0">&#10010;</option>
                               					    <option value="1">&#9866;</option>
                                  				</select>
                                            </div>
                                            <div class="col-3 t2">
                                                <input type="text" id="offset-value" class="form-control input-ms" value="0.0" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Hi Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="hi-torque" class="form-control input-ms" value="0.7" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Lo Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="Lo-torque" class="form-control input-ms" value="0.0" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Run Down Speed :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="run-down-speed" class="form-control input-ms" value="100" maxlength="">
                                            </div>
                                            <div class="col t2">max rpm 1100</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">Threshold Type :</div>
                                            <div class="col t2">
                                     	        <div class="col-3 form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" checked="checked" name="Threshold-Type" id="TypeTorque" value="0"style="zoom:1.2; vertical-align: middle">
                                                    <label class="form-check-label" for="TypeTorque">Torque</label>
                                                </div>
                                      	        <div class="col form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="Threshold-Type" id="TypeAngle" value="1" style="zoom:1.2; vertical-align: middle">
                                                    <label class="form-check-label" for="TypeAngle">Angle</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Threshold Torque :</div>
                                            <div class="col-4 t2">
                                                <input id="threshold_torque" type="text" value="0.0" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Threshold Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="threshold_angle" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Enable :</div>
                                            <div class="switch Downshift col-5 t2">
                                                <input id="Downshift-ON-OFF" type="checkbox">
                                                <label><i></i></label>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Torque :</div>
                                            <div class="col-4 t2">
                                                <input id="downshift-torque" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Speed :</div>
                                            <div class="col-4 t2">
                                                <input id="downshift-speed" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Monitoring Angle :</div>
                                            <div class="switch Monitoring col-5 t2">
                                                <input id="Monitoring-ON-OFF" type="checkbox">
                                                <label><i></i></label>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Hi Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="hi-angle" type=text" value="30600" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Lo Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="lo-angle" type="text" value="0" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run :</div>
                                            <div class="switch PreRun col-5 t2">
                                                <input id="Pre-run" type="checkbox">
                                                <label><i></i></label>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run RPM :</div>
                                            <div class="col-4 t2">
                                                <input id="pre-run-rpm" type="text" value="200" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="pre-run-angle" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Angle Setiing -->
                        <div id="Angle_Parameter" style="display: none;">
                            <div class="row t1">
                                <div class="col-4 t1" style="padding-left: 3%">
                                    <img src="./img/angle.png" width="40" height="40" alt="">&nbsp;&nbsp;
                                    <b>Angle Parameter</b>
                                </div>
                            </div>
                            <div class="scrollbar-modal" id="style-angle">
                                <div class="modal-force-overflow">
                                    <div style="padding-left: 5%; background-color: #D9D9D9">
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Max Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="max-torque-a" class="form-control input-ms" value="5.0" maxlength="" disabled="disabled">
                                            </div>
                                            <div class="col t2">N.m</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Program ID :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="program-id-a" class="form-control input-ms" value="1" maxlength="" disabled="disabled">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Program Name :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="program-name-a" class="form-control input-ms" value="Progam-1" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Target Angle(&#186;) :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="target-angle-a" class="form-control input-ms" value="1800" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Hi Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="hi-angle-a" type="text" value="30600" class="form-control input-ms" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Lo Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="lo-angle-a" type="text" value="0" class="form-control input-ms" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Hi Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="hi-torque-a" class="form-control input-ms" value="0.7" maxlength="">
                                            </div>
                                            <div class="col t2">N.m</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Lo Torque :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="Lo-torque-a" class="form-control input-ms" value="0.0" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Joint Offset :</div>
                                            <div class="col-1 t2">
                              					<select id="joint-offset-a" style="width: 50px; height: 32px; border: 0" >
                               					    <option value="0">&#10010;</option>
                               					    <option value="1">&#9866;</option>
                                  				</select>
                                            </div>
                                            <div class="col-3 t2">
                                                <input type="text" id="offset-value-a" class="form-control input-ms" value="0.0" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" for="">Run Down Speed :</div>
                                            <div class="col-4 t2">
                                                <input type="text" id="run-down-speed-a" class="form-control input-ms" value="100" maxlength="">
                                            </div>
                                            <div class="col t2">max rpm 1100</div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1" style="font-size: 20px">Threshold Type :</div>
                                            <div class="col t2">
                                     	        <div class="col-3 form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="Threshold-Type-a" id="TypeTorque-a" value="0"style="zoom:1.2; vertical-align: middle">
                                                    <label class="form-check-label" for="TypeTorque-a">Torque</label>
                                                </div>
                                      	        <div class="col form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" checked="checked" name="Threshold-Type-a" id="TypeAngle-a" value="1" style="zoom:1.2; vertical-align: middle">
                                                    <label class="form-check-label" for="TypeAngle-a">Angle</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Threshold Torque :</div>
                                            <div class="col-4 t2">
                                                <input id="threshold_torque-a" type="text" value="0.0" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Threshold Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="threshold_angle-a" type="text" value="1800" class="form-control input-ms" maxlength="">
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Enable :</div>
                                            <div class="switch Downshift col-5 t2">
                                                <input id="Downshift-ON-OFF-a" type="checkbox">
                                                <label><i></i></label>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Torque :</div>
                                            <div class="col-4 t2">
                                                <input id="downshift-torque-a" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Downshift Speed :</div>
                                            <div class="col-4 t2">
                                                <input id="downshift-speed-a" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run :</div>
                                            <div class="switch PreRun col-5 t2">
                                                <input id="Pre-run-a" type="checkbox">
                                                <label><i></i></label>
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run RPM :</div>
                                            <div class="col-4 t2">
                                                <input id="pre-run-rpm-a" type="text" value="200" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                        <div class="row t1">
                                            <div class="col-3 t1">Pre-Run Angle :</div>
                                            <div class="col-4 t2">
                                                <input id="pre-run-angle-a" type="text" value="1800" class="form-control input-ms" maxlength="" >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="new_program_save()">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('ProgramNew').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Program Copy Modal -->
    <div id="CopyProgram" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width: 430px">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('CopyProgram').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Copy Program</h3>
                </header>

                <div class="modal-body">
                    <form id="copy_Pro_form">
                        <div class="col" style="font-size: 20px; margin: 5px 0px 5px"><b>Copy From</b></div>
                        <div style="padding-left: 20px;">
        		            <div class="row">
        				        <div for="from_pro_id" class="col-5 t1">Program ID :</div>
        				        <div class="col-5 t2">
        				            <input type="text" class="form-control" id="from_pro_id" disabled>
        				        </div>
        				    </div>
                            <div class="row">
                                <div for="from_pro_name" class="col-5 t1">Program Name :</div>
                                <div class="col-5 t2">
                                    <input type="text" class="form-control" id="from_pro_name" disabled>
                                </div>
                            </div>
                        </div>

                        <div for="from_pro_id" class="col" style="font-size: 20px; margin: 5px 0px 5px"><b>Copy To</b></div>
                        <div style="padding-left: 20px;">
                            <div class="row">
                                <div for="to_pro_id" class="col-5 t1">Program ID :</div>
                				<div class="col-5 t2">
                				    <input type="text" class="form-control" id="to_pro_id">
                				</div>
            				</div>
                            <div class="row">
                                <div for="to_pro_name" class="col-5 t1">Program Name :</div>
                                <div class="col-5 t2">
                                    <input type="text" class="form-control" id="to_Program_name">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="copy_program()">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('CopyProgram').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

<script>

// Get the modal
var modal = document.getElementById('ProgramNew');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}


/* Hi-Q Lo-Q dropdown */
function toggleDropdown(item)
{
    var Divs = document.querySelectorAll("div[id^='Detail-Dropdown']");
    // 迭代所有符合條件的 div 元素，移除 class
    Divs.forEach(function(div) {
        // if(!div.hasClass('show'))
        if( $(div)[0].id != "Detail-Dropdown-"+item){
            div.classList.remove("show"); // 將 "yourClassNameToRemove" 替換為你想要移除的 class 名稱
        }
    });

    document.getElementById("Detail-Dropdown-"+item).classList.toggle("show");

}

// Close the dropdowns if the user clicks outside of them
window.onclick = function(event)
{
    if (!event.target.matches('.dropdown img')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}


// choose Target Type  //
function TargetTypeCheckbox()
{
    var targettorque = document.getElementById("Target-Torque");
    var torque = document.getElementById("Torque_Parameter");

    var targetangle = document.getElementById("Target-Angle");
    var angle = document.getElementById("Angle_Parameter");

    if (targettorque.checked == true) {
        torque.style.display = "block";
    } else {
        torque.style.display = "none";
    }

    if (targetangle.checked == true) {
        angle.style.display = "block";
    } else {
        angle.style.display = "none";
    }
}

</script>

<script>
$(document).ready(function () {
        highlight_row();
    });

function highlight_row() {
    var table = document.getElementById('table');
    var cells = table.getElementsByTagName('td');

    for (var i = 0; i < cells.length; i++) {
        // Take each cell
        var cell = cells[i];
        // do something on onclick event for cell

        cell.onclick = function() {
            // Get the row id where the cell exists
            var rowId = this.parentNode.rowIndex;

            var rowsNotSelected = table.getElementsByTagName('tr');
            for (var row = 0; row < rowsNotSelected.length; row++) {
                rowsNotSelected[row].style.backgroundColor = "";
                rowsNotSelected[row].classList.remove('selected');
            }
            var rowSelected = table.getElementsByTagName('tr')[rowId];
            rowSelected.style.backgroundColor = "#9AC0CD";
            rowSelected.className += " selected";

            //hide div
        }
    }

} //end of function

//get job_id
function get_program_id() {

    $.ajax({
        type: "POST",
        url: "?url=Templates/get_head_program_id",
        data: {},
        dataType: "json",
        encode: true,
        async: false, //等待ajax完成
    }).done(function(data) { //成功且有回傳值才會執行
        program_id = data['missing_id'];
    });

    return program_id;
}

//new program 按下new seq button
function new_program() {

    //get new program_id
    let program_id = get_program_id();
    if (program_id > 50) { //避免新增超過50個program
        return 0;
    }

    document.getElementById('modal_head').innerHTML = 'New Program'; //'New Program'
    // //帶入預設值
    document.getElementById("program-id").value = program_id;
    document.getElementById("program-id-a").value = program_id;

    //torque element
    document.getElementById("program-name").value = '';
    document.getElementById("target-torque").value = '0.5';
    document.getElementById("joint-offset").value = '0';
    document.getElementById("offset-value").value = '0.0';
    document.getElementById("hi-torque").value = '0.6';
    document.getElementById("Lo-torque").value = '0.0';
    document.getElementById("run-down-speed").value = '100';
    // document.querySelector('input[name="Threshold-Type"]:checked').value = 0; //radio
    $("input[name=Threshold-Type][value='0']").attr('checked',true); 
    document.getElementById("threshold_torque").value = '0.0';
    document.getElementById("threshold_angle").value = '0';
    document.getElementById("Downshift-ON-OFF").checked = false;//checkbox
    document.getElementById("downshift-torque").value = '0.0';
    document.getElementById("downshift-speed").value = '0';
    document.getElementById("Monitoring-ON-OFF").checked = false;//checkbox
    document.getElementById("hi-angle").value = '30600';
    document.getElementById("lo-angle").value = '0';
    document.getElementById("Pre-run").checked = false;//checkbox
    document.getElementById("pre-run-rpm").value = '200';
    document.getElementById("pre-run-angle").value = '1800';

    //angle element
    document.getElementById("program-name-a").value = '';
    document.getElementById("target-angle-a").value = '1800';
    document.getElementById("hi-angle-a").value = '30600';
    document.getElementById("lo-angle-a").value = '0';
    document.getElementById("hi-torque-a").value = '0.6';
    document.getElementById("Lo-torque-a").value = '0.0';
    document.getElementById("joint-offset-a").value = '0';//disabled
    document.getElementById("offset-value-a").value = '0';//disabled
    document.getElementById("run-down-speed-a").value = '100';
    // document.querySelector('input[name="Threshold-Type-a"]:checked').value = 0; //radio
    $("input[name=Threshold-Type-a][value='0']").attr('checked',true); 
    document.getElementById("threshold_torque-a").value = '0.0';
    document.getElementById("threshold_angle-a").value = '0';
    document.getElementById("Downshift-ON-OFF-a").checked = false;//checkbox
    document.getElementById("downshift-torque-a").value = '0.0';
    document.getElementById("downshift-speed-a").value = '60';
    document.getElementById("Pre-run-a").checked = false;//checkbox
    document.getElementById("pre-run-rpm-a").value = '200';
    document.getElementById("pre-run-angle-a").value = '1800';

    //show modal
    document.getElementById('ProgramNew').style.display = 'block'

}

//new program 按下save鍵
function new_program_save() {
    //get target type Target-Type
    let target_type = document.querySelector('input[name="Target-Type"]:checked').value; //torque:2 angle:1

    let program_id = document.getElementById("program-id").value;
    let program_name = document.getElementById("program-name").value;
    let target_torque = document.getElementById("target-torque").value;
    let target_angle = document.getElementById("target-angle-a").value;
    let joint_offset = document.getElementById("joint-offset").value
    let offset_value = document.getElementById("offset-value").value;
    let hi_torque = document.getElementById("hi-torque").value;
    let Lo_torque = document.getElementById("Lo-torque").value;
    let run_down_speed = document.getElementById("run-down-speed").value;
    let Threshold_Type = document.querySelector('input[name="Threshold-Type"]:checked').value; //radio
    let threshold_torque = document.getElementById("threshold_torque").value;
    let threshold_angle = document.getElementById("threshold_angle").value;
    let Downshift_ON_OFF = document.getElementById("Downshift-ON-OFF").checked;//checkbox
    let downshift_torque = document.getElementById("downshift-torque").value;
    let downshift_speed = document.getElementById("downshift-speed").value;
    let Monitoring_ON_OFF = document.getElementById("Monitoring-ON-OFF").checked;//checkbox
    let hi_angle = document.getElementById("hi-angle").value;
    let lo_angle = document.getElementById("lo-angle").value;
    let Pre_run = document.getElementById("Pre-run").checked;//checkbox
    let pre_run_rpm = document.getElementById("pre-run-rpm").value;
    let pre_run_angle = document.getElementById("pre-run-angle").value;

    if(target_type == 2){
        program_id = document.getElementById("program-id").value;
        program_name = document.getElementById("program-name").value;
        target_torque = document.getElementById("target-torque").value;
        joint_offset = document.getElementById("joint-offset").value
        offset_value = document.getElementById("offset-value").value;
        hi_torque = document.getElementById("hi-torque").value;
        Lo_torque = document.getElementById("Lo-torque").value;
        run_down_speed = document.getElementById("run-down-speed").value;
        Threshold_Type = document.querySelector('input[name="Threshold-Type"]:checked').value; //radio
        threshold_torque = document.getElementById("threshold_torque").value;
        threshold_angle = document.getElementById("threshold_angle").value;
        Downshift_ON_OFF = document.getElementById("Downshift-ON-OFF").checked;//checkbox
        downshift_torque = document.getElementById("downshift-torque").value;
        downshift_speed = document.getElementById("downshift-speed").value;
        Monitoring_ON_OFF = document.getElementById("Monitoring-ON-OFF").checked;//checkbox
        hi_angle = document.getElementById("hi-angle").value;
        lo_angle = document.getElementById("lo-angle").value;
        Pre_run = document.getElementById("Pre-run").checked;//checkbox
        pre_run_rpm = document.getElementById("pre-run-rpm").value;
        pre_run_angle = document.getElementById("pre-run-angle").value;
    }else if(target_type == 1){
        program_id = document.getElementById("program-id-a").value;
        program_name = document.getElementById("program-name-a").value;
        target_angle = document.getElementById("target-angle-a").value;
        hi_angle = document.getElementById("hi-angle-a").value;
        lo_angle = document.getElementById("lo-angle-a").value;
        hi_torque = document.getElementById("hi-torque-a").value;
        Lo_torque = document.getElementById("Lo-torque-a").value;
        joint_offset = document.getElementById("joint-offset-a").value;
        offset_value = document.getElementById("offset-value-a").value;
        run_down_speed = document.getElementById("run-down-speed-a").value;
        Threshold_Type = document.querySelector('input[name="Threshold-Type-a"]:checked').value; //radio
        threshold_torque = document.getElementById("threshold_torque-a").value;
        threshold_angle = document.getElementById("threshold_angle-a").value;
        Downshift_ON_OFF = document.getElementById("Downshift-ON-OFF-a").checked;//checkbox
        downshift_torque = document.getElementById("downshift-torque-a").value;
        downshift_speed = document.getElementById("downshift-speed-a").value;
        Pre_run = document.getElementById("Pre-run-a").checked;//checkbox
        pre_run_rpm = document.getElementById("pre-run-rpm-a").value;
        pre_run_angle = document.getElementById("pre-run-angle-a").value;
        Monitoring_ON_OFF = false;//checkbox
    }

    //true false轉int
    Downshift_ON_OFF = +Downshift_ON_OFF
    Pre_run = +Pre_run
    Monitoring_ON_OFF = +Monitoring_ON_OFF


    var formData = new FormData();
    // 添加表单数据
    formData.append('program_id', program_id);
    formData.append('program_name', program_name);
    formData.append('target_type', target_type);
    formData.append('target_angle', target_angle);
    formData.append('target_torque', target_torque);
    formData.append('hi_angle', hi_angle);
    formData.append('lo_angle', lo_angle);
    formData.append('hi_torque', hi_torque);
    formData.append('Lo_torque', Lo_torque);
    formData.append('joint_offset', joint_offset);
    formData.append('offset_value', offset_value);
    formData.append('run_down_speed', run_down_speed);
    formData.append('Threshold_Type', Threshold_Type);
    formData.append('threshold_torque', threshold_torque);
    formData.append('threshold_angle', threshold_angle);
    formData.append('Downshift_ON_OFF', Downshift_ON_OFF);
    formData.append('downshift_torque', downshift_torque);
    formData.append('downshift_speed', downshift_speed);
    formData.append('Pre_run', Pre_run);
    formData.append('pre_run_rpm', pre_run_rpm);
    formData.append('pre_run_angle', pre_run_angle);
    formData.append('Monitoring_ON_OFF', Monitoring_ON_OFF);

    let url = '?url=Templates/edit_program';
    $.ajax({
        type: "POST",
        data: formData,
        dataType: "json",
        url: url,
        processData: false,
        contentType: false,
        success: function(response) {
            // 成功回調函數，處理伺服器的回應
            console.log(response); // 在控制台輸出伺服器的回應
            // history.go(0);
            if (response.error == '') {
                history.go(0);
            } else {

            }
        },
        error: function(error) {
            // 失敗回調函數，處理錯誤情況
            // console.error('Error:', error); // 在控制台輸出錯誤訊息
        }
    }).fail(function() {
        // history.go(0); //失敗就重新整理
    });
}

function edit_program(program_id) {

    let url = '?url=Templates/get_program_by_id';
    $.ajax({
        type: "POST",
        data: { 'program_id': program_id },
        dataType: "json",
        url: url,
        success: function(response) {
            // 成功回調函數，處理伺服器的回應
            // console.log(response); // 在控制台輸出伺服器的回應

            // //帶入預設值
            document.getElementById("program-id").value = response['template_program_id'];
            document.getElementById("program-id-a").value = response['template_program_id'];
            // $("input[name=Target-Type][value='"+response['step_targettype']+"']")[0].checked = true;
            $("input[name=Target-Type]").attr('checked',false); 
            $("input[name=Target-Type][value='"+response['step_targettype']+"']").attr('checked',true); 
            TargetTypeCheckbox() //切換div

            //torque element
            document.getElementById("program-name").value = response['step_name'];
            document.getElementById("target-torque").value = response['step_targettorque'];
            document.getElementById("joint-offset").value = response['step_offsetdirection'];
            document.getElementById("offset-value").value = response['step_torque_jointoffset'];
            document.getElementById("hi-torque").value = response['step_hightorque'];
            document.getElementById("Lo-torque").value = response['step_lowtorque'];
            document.getElementById("run-down-speed").value = response['step_rpm'];
            // document.querySelector('input[name="Threshold-Type"]:checked').value = response['step_threshold_mode']; //radio
            $("input[name=Threshold-Type]").attr('checked',false); 
            $("input[name=Threshold-Type][value='"+response['step_threshold_mode']+"']").attr('checked',true); 
            // $("input[name=Threshold-Type][value='"+response['step_threshold_mode']+"']")[0].checked = true

            document.getElementById("threshold_torque").value = response['step_threshold_torque'];
            document.getElementById("threshold_angle").value = response['step_threshold_angle'];
            document.getElementById("Downshift-ON-OFF").checked = +response['step_downshift_enable'];//checkbox
            document.getElementById("downshift-torque").value = response['step_downshift_torque'];
            document.getElementById("downshift-speed").value = response['step_downshift_speed'];
            document.getElementById("Monitoring-ON-OFF").checked = +response['step_monitoringangle'];//checkbox
            document.getElementById("hi-angle").value = response['step_highangle'];
            document.getElementById("lo-angle").value = response['step_lowangle'];
            document.getElementById("Pre-run").checked = +response['step_prr'];//checkbox
            document.getElementById("pre-run-rpm").value = response['step_prr_rpm'];
            document.getElementById("pre-run-angle").value = response['step_prr_angle'];

            //angle element
            document.getElementById("program-name-a").value = response['step_name'];
            document.getElementById("target-angle-a").value = response['step_targetangle'];
            document.getElementById("hi-angle-a").value = response['step_highangle'];
            document.getElementById("lo-angle-a").value = response['step_lowangle'];
            document.getElementById("hi-torque-a").value = response['step_hightorque'];
            document.getElementById("Lo-torque-a").value = response['step_lowtorque'];
            document.getElementById("joint-offset-a").value = response['step_offsetdirection'];
            document.getElementById("offset-value-a").value = response['step_torque_jointoffset'];
            document.getElementById("run-down-speed-a").value = response['step_rpm'];
            // document.querySelector('input[name="Threshold-Type-a"]:checked').value = 0; //radio
            $("input[name=Threshold-Type-a]").attr('checked',false); 
            $("input[name=Threshold-Type-a][value='"+response['step_threshold_mode']+"']").attr('checked',true); 
            // $("input[name=Threshold-Type-a][value='"+response['step_threshold_mode']+"']")[0].checked = true;
            document.getElementById("threshold_torque-a").value = response['step_threshold_torque'];
            document.getElementById("threshold_angle-a").value = response['step_threshold_angle'];
            document.getElementById("Downshift-ON-OFF-a").checked = +response['step_downshift_enable'];//checkbox
            document.getElementById("downshift-torque-a").value = response['step_downshift_torque'];
            document.getElementById("downshift-speed-a").value = response['step_downshift_speed'];
            document.getElementById("Pre-run-a").checked = +response['step_prr'];//checkbox
            document.getElementById("pre-run-rpm-a").value = response['step_prr_rpm'];
            document.getElementById("pre-run-angle-a").value = response['step_prr_angle'];

            document.getElementById('modal_head').innerHTML = 'Edit Program'; //'New Job'
            document.getElementById('ProgramNew').style.display = 'block'
        },
        error: function(error) {
            // 失敗回調函數，處理錯誤情況
            // console.error('Error:', error); // 在控制台輸出錯誤訊息
        }
    }).fail(function() {
        // history.go(0);//失敗就重新整理
    });

}

function copy_program_div() {
    let rowSelected = document.getElementsByClassName('selected');
    if (rowSelected.length != 0) {
        let pro_id = rowSelected[0].childNodes[1].innerHTML;
        let pro_name = rowSelected[0].childNodes[2].innerHTML;

        document.getElementById('from_pro_id').value=pro_id;
        document.getElementById('from_pro_name').value=pro_name;
        document.getElementById('CopyProgram').style.display='block'
    }
}

function copy_program() {
    let rowSelected = document.getElementsByClassName('selected');
    let pro_id = rowSelected[0].childNodes[1].innerHTML;
    let to_pro_id = document.getElementById('to_pro_id').value;
    let to_pro_name = document.getElementById('to_Program_name').value;

    let url = '?url=Templates/copy_program';
    $.ajax({
        type: "POST",
        data: {
            'from_pro_id': pro_id,
            'to_pro_id': to_pro_id,
            'to_pro_name': to_pro_name,
            'job_type': 'normal'
        },
        dataType: "json",
        url: url,
        success: function(response) {
            // 成功回調函數，處理伺服器的回應
            // console.log(response); // 在控制台輸出伺服器的回應
            history.go(0);
        },
        error: function(error) {
            // 失敗回調函數，處理錯誤情況
            // console.error('Error:', error); // 在控制台輸出錯誤訊息
        }
    }).fail(function() {
        // history.go(0);//失敗就重新整理
    });
}

function delete_program() {
    let rowSelected = document.getElementsByClassName('selected');
    let program_id = rowSelected[0].childNodes[1].innerHTML;

    var yes = confirm('你確定嗎？');

    if (yes) {
        let url = '?url=Templates/delete_program_by_id';
        $.ajax({
            type: "POST",
            data: { 'program_id': program_id},
            dataType: "json",
            url: url,
            success: function(response) {
                // 成功回調函數，處理伺服器的回應
                // console.log(response); // 在控制台輸出伺服器的回應
                history.go(0);
            },
            error: function(error) {
                // 失敗回調函數，處理錯誤情況
                // console.error('Error:', error); // 在控制台輸出錯誤訊息
            }
        }).fail(function() {
            // history.go(0);//失敗就重新整理
        });
    } else {

    }
}


</script>

</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>