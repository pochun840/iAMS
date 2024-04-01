<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/program.css" type="text/css">

<?php echo $data['nav']; ?>

<style>
.t1{font-size: 20px; margin: 5px 0px; display: flex; align-items: center;}
.t2{font-size: 18px; margin: 5px 0px;}
</style>

<div class="container-ms">

    <header>
        <div class="program">
            <img id="header-img" src="./img/template-head.svg">Program Template
        </div>
        <div class="notification"><i style=" width:auto; height: 40px" class="fa fa-bell"></i> Notification</div>
        <div class="personnel"><i style=" width:auto; height: 40px" class="fa fa-desktop"></i> Personnel IP</div>
    </header>

    <div class="main-content">
        <div class="center-content">
            <div class="Controller-setting">
                <div class="row t1">
                    <div class="col-4 t1">Choose Controller :</div>
                    <div class="custom-select">
                        <select id="ControllerSelect">
                            <option value="" disabled selected>Select option</option>
                            <option value="GTCS">GTCS</option>
                            <option value="TCG">TCG</option>
                        </select>
                    </div>
                </div>

                <div class="row t1">
                    <div class="col-4 t1">Screw Tool :</div>
                    <div class="custom-select">
                        <select class="selectem">
                            <option value="" disabled selected>Choose Tool</option>
                            <option value="tool1">SGT-CS303</option>
                            <!-- <option value="tool2">3-01007-7L-H</option> -->
                        </select>
                    </div>
                </div>

                <hr>

                <div id="jobTypeContainer">
                    <div class="t1">Choose Mode (Normal / Advance)</div>
                    <div class="row t1">
                        <div class="col-5 t2 radio">
                            <div class="col-3 form-check form-check-inline t1">
                                <label class="form-check-label" for="normal-job">
                                    <input class="form-check-input" id="normal-job" type="radio" name="jobType" value="normal" style="zoom:1; vertical-align: middle">
                                    Normal
                                </label>
                            </div>
                            <div class="col-3 form-check form-check-inline t1">
                                <label class="form-check-label" for="advance-job">
                                    <input class="form-check-input" id="advance-job" type="radio" name="jobType" value="advance" style="zoom:1; vertical-align: middle">
                                    Advance
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="nextButton" id="nextButton" onclick="go_to()">Next &#10144;</button>
            </div>
        </div>
    </div>
<script>
    document.getElementById('ControllerSelect').addEventListener('change', function () {
        var selectedValue = this.value;
        var jobTypeContainer = document.getElementById('jobTypeContainer');

        // Check if the selected value is "GTCS"
        if (selectedValue === 'GTCS') {
            // Display the job type container
            jobTypeContainer.style.display = 'block';
        } else {
            // Hide the job type container if the selected value is different
            jobTypeContainer.style.display = 'none';
        }

        // Rest of your code (radio buttons creation, etc.)
        // ...
    });

    document.getElementById('nextButton').addEventListener('click', function () {
        // var selectedRadioButton = document.querySelector('input[name="jobType"]:checked');
        // if (selectedRadioButton) {
        //     alert('You selected: ' + selectedRadioButton.value);
        //     // Add code to navigate to the next page or perform other actions
        // } else {
        //     alert('Please select a job type before proceeding.');
        // }
    });
</script>

<script type="text/javascript">
    function go_to(argument) {
        let selectedRadioButton = document.querySelector('input[name="jobType"]:checked');
        // alert(selectedRadioButton.value);
        if(selectedRadioButton.value == 'normal'){
            location.href = '?url=Templates/normalstep_index/';
        }else if(selectedRadioButton.value == 'advance'){
            location.href = '?url=Templates/advancedstep_index/';
        }
    }
</script>

</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>