<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/tcg_step.css" type="text/css">

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
        <label type="text" style="font-size: 22px; margin: 8px;">Step-TCG</label>
        <div class="topnav-right">
            <button class="btn" id="back-btn" type="button" onclick="location.href = '?url=Templates/';">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>
    </div>

    <div class="main-content">
        <div class="center-content">
            <div class="row" style="margin-bottom: 5px;">
                <div class="col-1 t1">Program ID:</div>
                <div class="col-1 t2" style="margin-right: 3%">
                    <input type="text" class="form-control input-ms" id="Program_ID" value="1" maxlength="" disabled="disabled">
                </div>

                <div class="col-2 t1">Program Name:</div>
                <div class="col-2 t2" style="margin-right: 2%">
                    <input type="text" class="form-control input-ms" id="Program_Name" value="Program-1" maxlength="" disabled="disabled">
                </div>

                <div class="col">
                    <button id="add-step" type="button" onclick="document.getElementById('StepNew').style.display='block'">
                        <img id="img-add" src="./img/add-step.svg" alt="">Add Step
                    </button>

                    <button id="copy-step" type="button" onclick="document.getElementById('Copystep').style.display='block'">
                        <img id="img-copy" src="./img/step-copy.svg" alt="">Copy
                    </button>

                    <button id="delete-step" type="button" >
                        <img id="img-delete" src="./img/step-delete.svg" alt="">Delete
                    </button>
                </div>
            </div>

            <div class="scrollbar" id="style-program">
                <div class="force-overflow">
                    <table class="table table-bordered" id="table">
                        <thead id="header-table" style="background-color: #A3A3A3; font-size: 2vmin">
                            <tr style="text-align: center; vertical-align: middle;">
                                <th width="5%"></th>
                                <th width="8%">Step ID</th>
                                <th width="15%">Step Name</th>
                                <th width="10%">Target Q (N.m)</th>
                                <th width="10%">Target A (&#186;)</th>
                                <th width="10%">Hi Q</th>
                                <th width="10%">Lo Q</th>
                                <th width="10%">Hi A</th>
                                <th width="10%">Lo A</th>
                                <th width="10%">Edit</th>
                            </tr>
                        </thead>
                        <tbody id="tbody" style="background-color: #F2F1F1; font-size: 2vmin; text-align: center">
                            <tr>
                                <td>
                                    <input class="form-check-input" type="checkbox" name="" id="02" value="0" style="zoom:1.0; vertical-align: middle">
                                </td>
                                <td>1</td>
                                <td>Step-1</td>
                                <td>0.0</td>
                                <td>1800</td>
                                <td>0</td>
                                <td>0</td>
                                <td>3800</td>
                                <td>0</td>
                                <td style="text-align: center">
                                    <img src="./img/angle.png" width="40" height="40" alt="" onclick="document.getElementById('StepEdit').style.display='block'">
                                </td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="checkbox" name="" id="02" value="0" style="zoom:1.0; vertical-align: middle">
                            </td>
                                <td>2</td>
                                <td>Step-2</td>
                                <td>0.6</td>
                                <td>00</td>
                                <td>0.7</td>
                                <td>0.3</td>
                                <td>0</td>
                                <td>0</td>
                                <td style="text-align: center">
                                    <img src="./img/torque.png" width="40" height="40" alt="">
                                </td>
                             </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

     <!-- New Step -->
    <div id="StepNew" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width:100%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('StepNew').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>New Step</h3>
                </header>

                <div class="modal-body">
                    <form id="new_step_form">
                        <div style="padding-left: 5%">
                            <div class="row t1">
                                <div class="col-3 t1" for="">Program ID :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="" disabled="disabled">
                                </div>
                                <div class="col-3 t1" for="">Program Name :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="program-name" class="form-control input-ms" value="Program-1" maxlength="" disabled="disabled">
                                </div>
                            </div>
                        </div>

                        <div class="scrollbar-modal" id="style-AddStep">
                            <div class="modal-force-overflow">
                                <div style="padding-left: 5%; background-color: #D9D9D9">
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Step ID :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Step Name :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-name" class="form-control input-ms" value="Step-1" maxlength="">
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
                                       		    <option value="0">Q</option>
                                       			<option value="1">C</option>
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
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('StepNew').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

     <!-- Edit Step -->
    <div id="StepEdit" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width:100%">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('StepEdit').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Edit Step</h3>
                </header>

                <div class="modal-body">
                    <form id="new_step_form">
                        <div style="padding-left: 5%">
                            <div class="row t1">
                                <div class="col-1 t1"><img src="./img/angle.png" width="40" height="40" alt=""></div>
                                <div class="col-3 t1" for="">Program ID :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="" disabled="disabled">
                                </div>
                            </div>
                        </div>

                        <div class="scrollbar-modal" id="style-EditStep">
                            <div class="modal-force-overflow">
                                <div style="padding-left: 5%; background-color: #D9D9D9">
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Step ID :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-id" class="form-control input-ms" value="1" maxlength="" disabled="disabled">
                                        </div>
                                    </div>
                                    <div class="row t1">
                                        <div class="col-3 t1" for="">Step Name :</div>
                                        <div class="col-4 t2">
                                            <input type="text" id="program-name" class="form-control input-ms" value="Step-1" maxlength="">
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
                                       		    <option value="0">Q</option>
                                       		    <option value="1">C</option>
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
                                            <input id="lo-thread" type="text" value="0" class="form-control input-ms" maxlength="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('StepEdit').style.display='none'" class="cancelbtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Step Copy -->
    <div id="Copystep" class="modal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content w3-animate-zoom" style="width: 430px">
                <header class="w3-container modal-header">
                    <span onclick="document.getElementById('Copystep').style.display='none'"
                    class="w3-button w3-red w3-xxlarge w3-display-topright" style="padding: 7px; width: 60px">&times;</span>
                    <h3>Copy Step</h3>
                </header>

                <div class="modal-body">
                    <form id="copy_step_form">
                        <div class="col" style="font-size: 20px; margin: 5px 0px 5px"><b>Copy From</b></div>
                        <div style="padding-left: 20px;">
        		            <div class="row">
        				        <div for="from_step_id" class="col-5 t1">Step ID :</div>
        				        <div class="col-5 t2">
        				            <input type="text" class="form-control" id="from_step_id" disabled>
        				        </div>
        				    </div>
                            <div class="row">
                                <div for="from_step_name" class="col-5 t1">Step Name :</div>
                                <div class="col-5 t2">
                                    <input type="text" class="form-control" id="from_step_name" disabled>
                                </div>
                            </div>
                        </div>

                        <div for="from_step_id" class="col" style="font-size: 20px; margin: 5px 0px 5px"><b>Copy To</b></div>
                        <div style="padding-left: 20px;">
                            <div class="row">
                                <div for="to_step_id" class="col-5 t1">Step ID :</div>
                				<div class="col-5 t2">
                				    <input type="text" class="form-control" id="to_step_id">
                				</div>
            				</div>
                            <div class="row">
                                <div for="to_step_name" class="col-5 t1">Step Name :</div>
                                <div class="col-5 t2">
                                    <input type="text" class="form-control" id="to_step_name">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer justify-content-center">
                    <button id="button1" class="button button3" onclick="myFunction(true)">Save</button>
                    <button id="button2" class="button button3" onclick="document.getElementById('Copystep').style.display='none'" class="cancelbtn">Cancel</button>
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