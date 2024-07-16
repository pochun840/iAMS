<?php require APPROOT . 'views/inc/header.tpl'; ?>


<link rel="stylesheet" href="<?php echo URLROOT; ?>css/setting.css" type="text/css">

<?php echo $data['nav']; ?>


<div class="container-ms">

    <header>
        <div class="setting">
            <img id="header-img" src="./img/setting-head.svg"> <?php echo $text['main_setting_text']; ?>
        </div>

        <div class="notification">
            <i style="width:auto; height:40px" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel"><i style="width:auto; height: 40px; font-size: 26px" class="fa fa-user"></i> <?php echo $_SESSION['user']; ?></div>
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
                        <a>Controller:GTCS has...........</a>
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
                <div class="navbutton active" onclick="handleButtonClick(this, 'operation')">
                    <span data-content="<?php echo $text['Operation_Setting_text']; ?>" onclick="showContent('operation')"></span><?php echo $text['Operation_Setting_text']; ?>
                </div>
                <div class="navbutton" onclick="handleButtonClick(this, 'system_setting')">
                    <span data-content="<?php echo $text['System_Setting_text']; ?>" onclick="showContent('system_setting')"></span><?php echo $text['System_Setting_text']; ?>
                </div>
            </div>

            <!-- System Operation -->
            <div id="operationContent" class="content">
                <div id="Operation_Setting" style="margin-top: 40px">
                    <div class="t1">
                        <div class="col-2 t2" style="font-weight: bold;margin-top: 15px"><?php echo $text['Manager_Verify_text']; ?>:</div>

                        <?php foreach ($data['all_roles'] as $key => $value) {
                            echo '<div class="t2 form-check form-check-inline" style="margin-left: -5px">';
                            // echo '<input class="form-check-input" type="checkbox" name="manager_role" id="Leader'.$key.'" value="'.$value['ID'].'" style="zoom:1.1; vertical-align: middle;">';
                            if (in_array($value['ID'], $data['button_auth']['role_checked'])) {
                                echo '<input class="form-check-input" type="checkbox" name="manager_role" id="Leader'.$key.'" value="'.$value['ID'].'" style="zoom:1.1; vertical-align: middle;" checked>';
                            }else{
                                echo '<input class="form-check-input" type="checkbox" name="manager_role" id="Leader'.$key.'" value="'.$value['ID'].'" style="zoom:1.1; vertical-align: middle">';
                            }

                            echo '<label class="form-check-label" for="Leader'.$key.'">'.$value['Title'].'</label>';
                            echo '</div>';
                        }?>
                    </div>
                    <div class="row t1">
                        <div class="col-3 t2" style="padding-left: 5%"><?php echo $text['Skip_Button_Access_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="switch_next_seq" type="checkbox" <?php if($data['button_auth']['switch_next_seq']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-3 t2" style="padding-left: 5%"><?php echo $text['Back_Button_Access_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="switch_previous_seq" type="checkbox" <?php if($data['button_auth']['switch_previous_seq']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-3 t2" style="padding-left: 5%"><?php echo $text['Task_Reset_Button_Access_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="task_reset" type="checkbox" <?php if($data['button_auth']['task_reset']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>

                    <div class="row t1" style="">
                        <div class="col-3 t2" style="padding-left: 5%"><?php echo $text['Job_Selection_Access_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="switch_job" type="checkbox" <?php if($data['button_auth']['switch_job']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>
                    <div class="row t1" style="padding-bottom: 2%">
                        <div class="col-3 t2" style="padding-left: 5%"><?php echo $text['Seq_Selection_Access_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="switch_seq" type="checkbox" <?php if($data['button_auth']['switch_seq']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>
                    <div class="row t1">
                        <div class="col-3 t3" style="padding-left: 0%; font-weight: bold"><?php echo $text['Stop_On_NG_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="stop_on_ng" type="checkbox" <?php if($data['button_auth']['stop_on_ng']){ echo 'checked';} ?>>
                            <label><i></i></label>
                        </div>
                    </div>
                    <button class="saveButton" onclick="save_manager_verify()"><?php echo $text['Save_text']; ?></button>
                </div>
            </div>

            <!-- Seytem Setting -->
            <div id="system_settingContent" class="content" style="display: none">
                <div id="System_Setting" style="margin-top: 40px">
                <div style="width: 95%">
                    <div class="row t1">
                        <div class="col-3 t1" style="padding-left: 3%;margin-top: 15px"><?php echo $text['Current_iAMS_version_text']; ?>:</div>
                        <div class=" col-1 t2 custom-file">
                            <label>1.00.1</label>
                        </div>
                    </div>
                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="row t1">
                            <div class="col-3 t1" style="padding-left: 3%"><?php echo $text['Export_specific_JOB_data_text']; ?>:</div>
                            <div class="col-4 t2 custom-file">
                                <select id="Export-Job" style="width: 190px">
                                    <option value="1">Job123</option>
                                    <option value="2">Job2</option>
                                    <option value="3">Job6768</option>
                                    <option value="4">Job324</option>
                                </select>
                            </div>
                            <div class="col-1 t2">
                                <button class="ExportButton" id="Export-job-btn"><?php echo $text['Export_text']; ?></button>
                            </div>
                        </div>
                    </form>

                    <div class="row t1">
                        <div class="col-7 t1" style="padding-left: 3%"><?php echo $text['Export_iAMS_data_text']; ?>:</div>
                        <div class="col-1 t2">
                            <button class="ExportButton" id="Export-iams-data"><?php echo $text['Export_text']; ?></button>
                        </div>
                    </div>

                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="row t1">
                            <div class="col-3 t1" style="padding-left: 3%"><?php echo $text['Import_specific_JOB_data_text']; ?>:</div>
                            <div class="col-4 t2">
                                <input type="file" name="image" id="Import-Job-Data" class="input-file">
                            </div>
                            <div class="col-1 t2">
                                <button class="ExportButton" id="Import-job-btn"><?php echo $text['Import_text']; ?></button>
                            </div>
                        </div>
                    </form>

                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="row t1">
                            <div class="col-3 t1" style="padding-left: 3%"><?php echo $text['Import_data_text']; ?>:</div>
                            <div class="col-4 t2">
                                <input type="file" name="image" id="Import-Data" class="input-file">
                            </div>
                            <div class="col-1 t2">
                                <button class="ExportButton" id="Import-data-btn"><?php echo $text['Import_text']; ?></button>
                            </div>
                        </div>
                    </form>

                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="row t1">
                            <div class="col-3 t1" style="padding-left: 3%"><?php echo $text['iAMS_Update_text']; ?>:</div>
                            <div class="col-4 t2">
                                <input type="file" name="image" id="iAMS-Update" class="input-file">
                            </div>
                            <div class="col-1 t2">
                                <button class="ExportButton" id="iAMS-Update-btn"><?php echo $text['Update_text']; ?></button>
                            </div>
                        </div>
                    </form>
                    <div class="row t1">
                        <div class="col-3 t2" style="padding-left: 3%;"><?php echo $text['Blackout_Recovery_text']; ?>:</div>
                        <div class="switch menu col-3 t4">
                            <input id="Blackout-Recovery" type="checkbox" checked="checked">
                            <label><i></i></label>
                        </div>
                    </div>
                </div>
                    <button class="saveButton" id="saveButton"><?php echo $text['Save_text']; ?></button>
                </div>
            </div>
        </div>
    </div>
<script>
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

// END Notification ....................

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
</script>

<script type="text/javascript">
    function save_manager_verify(argument) {
        let switch_next_seq = document.getElementById('switch_next_seq').checked;
        let switch_previous_seq = document.getElementById('switch_previous_seq').checked;
        let task_reset = document.getElementById('task_reset').checked;
        let switch_job = document.getElementById('switch_job').checked;
        let switch_seq = document.getElementById('switch_seq').checked;
        let stop_on_ng = document.getElementById('stop_on_ng').checked;

        let list = document.querySelectorAll("input[name='manager_role']:checked");
        let role_checked = '';
        for (var i = 0; i < list.length; i++) {
            role_checked += list[i].value + ','
        }
        role_checked = role_checked.slice(0, -1);

        $.ajax({
            type: "POST",
            data: {
                'switch_next_seq': +switch_next_seq,
                'switch_previous_seq': +switch_previous_seq,
                'task_reset': +task_reset,
                'switch_job': +switch_job,
                'switch_seq': +switch_seq,
                'stop_on_ng': +stop_on_ng,
                'role_checked': role_checked,
            },
            dataType: "json",
            url: "?url=Settings/Operation_Setting",
        }).done(function(notice) { //���\�B���^�ǭȤ~�|����
            if (notice.error != '') {} else {
                Swal.fire('Saved!', '', 'success');
                // window.location = window.location.href;
            }
        }).fail(function() {
            // history.go(0);//���ѴN���s��z
        });


    }


</script>
</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>
<style>
.t1{font-size: 18px; margin: 5px 0px; display: flex; align-items: center; padding-left: 3%}
.t2{font-size: 18px; margin: 5px 0px;}

.t3{font-size: 18px; margin: 5px 0px; display: flex; align-items: center; padding-left: 3%}
.t4{font-size: 15px; margin: 5px 0px;}

.form-check-inline
{
    display: inline-block;
    margin-right: 20px;
}
</style>
