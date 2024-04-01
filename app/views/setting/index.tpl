<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/setting.css" type="text/css">

<?php echo $data['nav']; ?>

<style>
.t1{font-size: 18px; margin: 3px 0px; display: flex; align-items: center; padding-left: 3%}
.t2{font-size: 18px; margin: 3px 0px;}
</style>

<div class="container-ms">

    <header>
        <div class="setting">
            <img id="header-img" src="./img/setting-head.svg"> Setting
        </div>

        <div class="notification">
            <i style="width:auto; height:40px" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel"><i style="width:auto; height: 40px; font-size: 26px" class="fa fa-user"></i> Esther</div>
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
                    <div class="navbutton active" onclick="handleButtonClick(this, 'controller')">
                        <span data-content="Controller setting" onclick="showContent('controller')"></span>Controller setting
                    </div>
                    <div class="navbutton" onclick="handleButtonClick(this, 'system')">
                        <span data-content="System setting" onclick="showContent('system')"></span>System setting
                    </div>
                    <div class="navbutton" onclick="handleButtonClick(this, 'barcode')">
                        <span data-content="Barcode setting" onclick="showContent('barcode')"></span>Barcode setting
                    </div>
                    <div class="navbutton" onclick="handleButtonClick(this, 'upload')">
                        <span data-content="Upload iAMS Version" onclick="showContent('upload')"></span>Upload iAMS Version
                    </div>
                </div>

                <div id="container">
                    <div id="controllerContent" class="content">
                        <div style="padding-left: 7%; padding: 10px">
                            <div class="col t1" style="padding: 10px"><b>Controller Setting</b></div>
                            <div class="row t1">
                                <div class="col-2 t1" >ID :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-id" class="form-control input-ms" value="">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="systemContent" class="content"  style="display: none;">
                        <div style="padding-left: 7%; padding: 0px">
                            <div class="col t1" style="padding: 10px"><b>Contrller Setting</b></div>
                            <div class="row t1">
                                <div class="col-3 t1" >ID :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-id" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="barcodeContent" class="content"  style="display: none;">
                        <div style="padding-left: 5%; padding: 0px">
                            <div class="row t1">
                                <div class="col t1" style="padding: 10px"><b>Barcode Setting</b></div>
                            </div>

                            <div class="scrollbar-barcode" id="style-barcode" style="padding: 0px 10px;">
                                <div class="force-overflow-barcode">
                                    <table class="table table-bordered table-hover" id="table">
                                        <thead id="header-table" style="text-align: center; vertical-align: middle;">
                                            <tr>
                                                <th style="width: 10%;">Job ID</th>
                                                <th style="width: 20%;">Job Name</th>
                                                <th style="width: 30%;">Barcode</th>
                                                <th style="width: 15%;">From</th>
                                                <th style="width: 15%;">To</th>
                                            </tr>
                                        </thead>

                                        <tbody id="tbody1" style="background-color: #F2F1F1; font-size: 1.8vmin;text-align: center; vertical-align: middle;">
                                            <tr>
                                                <td>1</td>
                                                <td>Job 1</td>
                                                <td>123456789</td>
                                                <td>--</td>
                                                <td>--</td>
                                            </tr>

                                            <tr>
                                                <td>2</td>
                                                <td>Job 2</td>
                                                <td>123456789</td>
                                                <td>--</td>
                                                <td>--</td>
                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td>Job 3</td>
                                                <td>123456789</td>
                                                <td>--</td>
                                                <td>--</td>
                                            </tr>
                                            <tr>
                                                <td>4</td>
                                                <td>Job 4</td>
                                                <td>123456789</td>
                                                <td>--</td>
                                                <td>--</td>
                                            </tr>
                                            <tr>
                                                <td>5</td>
                                                <td>Job 5</td>
                                                <td>123456789</td>
                                                <td>--</td>
                                                <td>--</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div style=" margin-top: 5px">
                                <div class="row t1">
                                    <div class="col-2 t1">Maintain Counts :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="maintain-counts" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                    </div>
                                </div>

                                <div class="row t1">
                                    <div class="col-2 t1">Refresh :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="refresh" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                    </div>
                                </div>

                                <div class="row t1">
                                    <div class="col-2 t1">Total Counts :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="total-counts" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                    </div>
                                </div>

                                <div class="row t1">
                                    <div class="col-2 t1">Max Torque :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="max-torque" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                    </div>
                                </div>

                                <div class="row t1">
                                    <div class="col-2 t1">Max Speed :</div>
                                    <div class="col-3 t2">
                                        <input type="text" id="max-speed" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="uploadContent" class="content"  style="display: none;">

                    </div>

                    <button class="saveButton" id="saveButton">Save</button>
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
</div>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>