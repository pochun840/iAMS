<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/program_tcg.css" type="text/css">

<?php echo $data['nav']; ?>

<style>

.t1{font-size: 18px; margin: 3px 0px; display: flex; align-items: center;}
.t2{font-size: 18px; margin: 3px 0px;}
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
        <label type="text" style="font-size: 22px; margin: 8px;">Program - TCG</label>
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
                    <input type="text" class="form-control input-ms" id="screw-type" value="3-01007-7L-H" maxlength="" disabled="disabled">
                </div>

                <div class="col">
                    <button id="add-program" type="button" onclick="document.getElementById('ProgramNew').style.display='block'">
                        <img id="img-program" src="./img/add-program.svg" alt="">Add Program
                    </button>

                    <button id="copy-program" type="button" onclick="document.getElementById('CopyProgram').style.display='block'">
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
                                <th width="18%">Target type</th>
                                <th width="10%">Add Step</th>
                            </tr>
                        </thead>
                        <tbody id="tbody" style="background-color: #F2F1F1; font-size: 2vmin; text-align: center">
                            <tr>
                                <td><input class="form-check-input" type="checkbox" name="" id="02" value="0" style="zoom:1.0; vertical-align: middle"></td>
                                <td>1</td>
                                <td>program-1</td>
                                <td>0.6 Nm</td>
                                <td>00</td>
                                <td style="text-align: left">
                                    <img src="./img/torque.png" width="40" height="40" alt="" onclick="document.getElementById('ProgramEdit').style.display='block'" >
                                </td>
                                <td>
                                    <i id="add-step" class="fa fa-plus-square-o" style="font-size: 35px; height: 35px; display: inline-block; vertical-align: middle;"></i>
                                </td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="checkbox" name="" id="02" value="0" style="zoom:1.0; vertical-align: middle"></td>
                                <td>2</td>
                                <td>program-2</td>
                                <td>00</td>
                                <td>1800 &#186;</td>
                                <td style="text-align: left">
                                    <img src="./img/torque.png" width="40" height="40" alt="">
                                    <img src="./img/angle.png" width="40" height="40" alt="">
                                    <img src="./img/torque.png" width="40" height="40" alt="">
                                </td>
                                <td>
                                    <i id="add-step" class="fa fa-plus-square-o" style="font-size: 35px; height: 35px; display: inline-block; vertical-align: middle;"></i>
                                </td>
                            </tr>
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
                    <h3>New Program</h3>
                </header>

                <div class="modal-body">
                     <div class="scrollbar-NewProgram" id="style-NewProgram">
                        <div class="NewProgram-force-overflow">
                            <form id="new_task_form">
                                <div style="padding-left: 5%; background-color: #D9D9D9">
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Program ID :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Program Name :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-name" class="form-control input-ms" value="Program-1" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OKALL Alarm Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="okall-alam" class="form-control input-ms" value="1.0" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OK Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="ok-time" class="form-control input-ms" value="9.9" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">NG Stop :</div>
                                        <div class="switch NGStop col-5 t2">
                                            <input id="NGStop-ON-OFF" type="checkbox">
                                            <label><i></i></label>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OKALL Stop :</div>
                                        <div class="switch OKallStop col-5 t2">
                                            <input id="OKallStop-ON-OFF" type="checkbox">
                                            <label><i></i></label>
                                        </div>
                                    </div>

                                    <div class="row t1">
                                        <div class="col-3 t1" for="">RPM :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="rpm" class="form-control input-ms" value="100" maxlength="">
                                        </div>
                                        <div class="col t2">max rpm 1100</div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Joint Offset :</div>
                                        <div class="col-1 t2">
                                            <select id="joint-offset" style="width: 210px; height: 32px; border: 0">
                                       		    <option value="0">Torque</option>
                                       			<option value="1">Angle</option>
                                          	</select>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" style="font-size: 20px">Direction :</div>
                                        <div class="col t2">
                                            <div class="col-3 form-check form-check-inline">
                                                <input class="form-check-input" type="radio" checked="checked" name="direction-option" id="direction-cw" value="0"style="zoom:1.2; vertical-align: middle">
                                                <label class="form-check-label" for="direction-cw">CW</label>
                                            </div>
                                            <div class="col form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="direction-option" id="direction-ccw" value="1" style="zoom:1.2; vertical-align: middle">
                                                <label class="form-check-label" for="direction-cw">CCW</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Delay Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="target-angle" class="form-control input-ms" value="0.8" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Target Thread :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="target-thread" class="form-control input-ms" value="0.6" maxlength="">
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
                                        <div class="col-3 t1" for="">Hi Torque :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="hi-torque" class="form-control input-ms" value="0.8" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Lo Torque :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="Lo-torque" class="form-control input-ms" value="0.0" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Hi Thread :</div>
                                        <div class="col-4 t2">
                                            <input id="hi-thread" type="text" value="999.9" class="form-control input-ms" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Lo Thread :</div>
                                        <div class="col-4 t2">
                                            <input id="lo-thread" type="number" value="0" class="form-control input-ms" maxlength="">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('ProgramNew').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Program -->
    <div id="ProgramEdit" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width:100%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('ProgramEdit').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Edit Program</h3>
                </header>

                <div class="modal-body">
                    <div class="scrollbar-EditProgram" id="style-EditProgram">
                        <div class="EditProgram-force-overflow">
                            <form id="new_task_form">
                                <div style="padding-left: 5%; background-color: #D9D9D9">
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Program ID :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Program Name :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-name" class="form-control input-ms" value="Program-1" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OKALL Alarm Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="okall-alam" class="form-control input-ms" value="1.0" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OK Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="ok-time" class="form-control input-ms" value="9.9" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">NG Stop :</div>
                                        <div class="switch NGStop col-5 t2">
                                            <input id="NGStop-ON-OFF" type="checkbox">
                                            <label><i></i></label>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">OKALL Stop :</div>
                                        <div class="switch OKallStop col-5 t2">
                                            <input id="OKallStop-ON-OFF" type="checkbox">
                                            <label><i></i></label>
                                        </div>
                                    </div>

                                    <div class="row t1">
                                        <div class="col-3 t1" for="">RPM :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="rpm" class="form-control input-ms" value="100" maxlength="">
                                        </div>
                                        <div class="col t2">max rpm 1100</div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Joint Offset :</div>
                                        <div class="col-1 t2">
                                            <select id="joint-offset" style="width: 210px; height: 32px; border: 0">
                                       		    <option value="0">Torque</option>
                                       			<option value="1">Angle</option>
                                          	</select>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" style="font-size: 20px">Direction :</div>
                                        <div class="col t2">
                                            <div class="col-3 form-check form-check-inline">
                                                <input class="form-check-input" type="radio" checked="checked" name="direction-option" id="direction-cw" value="0"style="zoom:1.2; vertical-align: middle">
                                                <label class="form-check-label" for="direction-cw">CW</label>
                                            </div>
                                            <div class="col form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="direction-option" id="direction-ccw" value="1" style="zoom:1.2; vertical-align: middle">
                                                <label class="form-check-label" for="direction-cw">CCW</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Delay Time :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="target-angle" class="form-control input-ms" value="0.8" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Target Thread :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="target-thread" class="form-control input-ms" value="0.6" maxlength="">
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
                                        <div class="col-3 t1" for="">Hi Torque :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="hi-torque" class="form-control input-ms" value="0.8" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Lo Torque :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="Lo-torque" class="form-control input-ms" value="0.0" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Hi Thread :</div>
                                        <div class="col-4 t2">
                                            <input id="hi-thread" type="text" value="999.9" class="form-control input-ms" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1">Lo Thread :</div>
                                        <div class="col-4 t2">
                                            <input id="lo-thread" type="number" value="0" class="form-control input-ms" maxlength="">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('ProgramEdit').style.display='none'" class="cancelbtn">Cancel</button>
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
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
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

// Change rows backgroud color
document.addEventListener("DOMContentLoaded", function() {
    var tbody = document.getElementById("tbody");
    var rows = tbody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        rows[i].addEventListener("click", function() {
            // Reset color for all rows
            for (var j = 0; j < rows.length; j++) {
                rows[j].style.backgroundColor = "";
            }

            // Set color for the clicked row
            this.style.backgroundColor = "#9AC0CD";
        });
    }
});

</script>

</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>