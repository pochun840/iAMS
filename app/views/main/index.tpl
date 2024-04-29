<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">


<?php echo $data['nav']; ?>

<div class="container-ms">
    <header>
        <div class="home">
            <img id="header-img" src="./img/home-head.svg">Home
        </div>

        <div class="notification">
            <i style="width:auto; height:40px" class="fa fa-bell" onclick="ClickNotification()"></i>
            <span id="messageCount" class="badge"></span>
        </div>
        <div class="personnel"><i style="width:auto; height: 40px" class="fa fa-user"></i> Esther</div>
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

    <div class="w3-white w3-border">
        <marquee>iAMS - Intelligen Alarm Management System</marquee>
    </div>
    <div style="margin-top: 0%; text-align: center; font-size: 50px"><b>Kilews</b></div>

    <div class="scrollbar" id="style-all">
        <div class="scrollbar-force-overflow">
            <div class="container">
                <div class="menu-button">
                    <div style="margin: 30px 100px" class="w3-center">
                        <button class="menu-item" onclick="window.location.href='?url=Products'">
                            <img src="./img/job.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Job</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Equipments'">
                            <img src="./img/equipment.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Equipment</span>
                        </button>
                        <button class="menu-item"onclick="window.location.href='?url=Plugins'">
                            <img src="./img/plugins.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Plugin</span>
                        </button>
                        <button class="menu-item"onclick="window.location.href='?url=Charts'">
                            <img src="./img/chart.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Chart</span>
                        </button>
                        <br><br>

                        <button id="operation" class="menu-item" onclick="window.location.href='?url=Operations'">
                            <img src="./img/operation.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Operation</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Templates'">
                            <img src="./img/templates.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Templates</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Calibrations'">
                            <img src="./img/calibration.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Calibration</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Monitors'">
                            <img src="./img/monitor.svg" alt="">
                            <span style="font-size: 18px; line-height: 60px">Monitor</span>
                        </button>

                        <br><br>

                        <button class="menu-item" onclick="window.location.href='?url=Users'">
                            <img src="./img/identity.svg" alt="" style="margin-bottom: 10px;">
                            <span style="font-size: 18px; line-height: 1.5">Identity Management</span>
                        </button>
                        <button class="menu-item"  onclick="DB2GTCS()">
                            <img src="./img/database.svg" alt="" style="margin-bottom: 10px;">
                            <span style="font-size: 18px; line-height: 1.5">GTCS-DB Sync</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Historicals'">
                            <img src="./img/historical.svg" alt="" style="margin-bottom: 10px">
                            <span style="font-size: 18px; line-height: 1.5">Historical Record</span>
                        </button>
                        <button class="menu-item" onclick="window.location.href='?url=Settings'">
                            <img src="./img/system-setting.svg" alt="" style="margin-bottom: 10px">
                            <span style="font-size: 18px; line-height: 1.5">System Setting</span>
                        </button>

                        <br><br>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>

.container-ms
{
    margin: 0 auto;
    padding: 0px;
    overflow: hidden;
    width: calc(100%);
    position: static;
    padding-left: 68px;
}

header
{
    background-color: red;
    font-size: 26px;
    width: 100%;
    color: white;
    height:50px;
    margin-bottom: 0px;
    align-items: center;
}

.home
{
    float: left;
    margin-left: 10px;
    margin:3px;
    font-size: 26px;
    vertical-align: middle;
}

#header-img
{
    width: auto;
    height:36px;
    margin: 2px;
    padding-right: 5px;
    margin-left: 10px;
    float: left;
    color:white;
}

.personnel
{
    float: right;
    margin: 0 15px;
    font-size: 24px;
    vertical-align: middle;
    padding: 4px;
    bottom: 0;
}

/* Start Notification */
.notification
{
    float: right;
    font-size: 24px;
    margin-right: 20px;
    padding: 4px;
    vertical-align: middle;
    bottom: 0;
}

.topnav-message
{
    width: 100%;
    overflow: hidden;
    background-color:#fff;
    border: 1px solid #BBBBBB;
    border-radius: 5px;
    padding: 0px;
}

.messageBox
{
    display: none;
    position: absolute; /* Thay vi position: fixed */
    border-radius: 10px;
    right: 10px;
    top: 45px;
    float: right;
    width: 400px;
    box-shadow: 0px 5px 10px 0px rgba(0,0,0,0.2);
    background-color: #fff;
    border: 0px solid #000;
    padding: 0px;
    z-index: 1000;
}

.notification .badge
{
    position: absolute;
    height: auto;
    width: auto;
    text-align: center;
    top: -3px;
    right: 8px;
    padding: 2px 8px;
    border-radius: 50%;
    color: white;
}

**
* Checkbox Four
*/
.checkboxFour
{
    width: 0px;
    height: 0px;
    background: #ddd;
    margin: 0px 0px;
    border-radius: 100%;
    position: relative;
}

/**
* Create the online and offline button
*/
.checkboxFour label
{
    display: block;
    position: fixed;
    width: 11px;
    height: 11px;
    border-radius: 100px;
    transition: all .5s ease;
    cursor: pointer;
    position: absolute;
    right: 8px;
    z-index: 1;
    background: #CFCFCF;
}

/**
* Create the checked state
*/
.checkboxFour input[type=checkbox]:checked + label
{
    background: #0083FF;
}

/* scrollbar Notification Mess */
.scrollbar-message
{
    float: left;
    height: calc(100vh - 300px);
    width: 100%;
    overflow-y: scroll;
}

.force-overflow-message
{
    min-height: 60vh;
}

/**  STYLE Message */
#style-message::-webkit-scrollbar
{
    display: none;
    width: 12px;
    background-color: #F5F5F5;
}

#style-message::-webkit-scrollbar-thumb
{
    border-radius: 10px;
    background: linear-gradient(left, #96A6BF, #63738C);
    box-shadow: inset 0 0 1px 1px #5C6670;
}

#style-message::-webkit-scrollbar-track
{
    border-radius: 10px;
    background: #eee;
    box-shadow: 0 0 1px 1px #bbb, inset 0 0 7px rgba(0,0,0,0.3)
}

#style-message::-webkit-scrollbar-thumb:hover
{
    background: linear-gradient(left, #8391A6, #536175);
}

#messageCount
{
    text-align: center;
}

.close-message
{
    color: #4F576D;
    float: right;
    margin: 0 auto;
    padding: 0px;
    top: 0;
    margin-right: 10px;
    font-size: 30px;
    font-weight: bold;
    vertical-align: middle;
}

.close-message:hover,
.close-message:focus
{
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
.recyclebox{color: #14A800; background-color: #E8F9F1; border-radius: 10px; padding-right: 5%; padding: 0 5px;}
.workstation{color: #555555; background-color: #DDDDDD; border-radius: 10px; padding: 0 5px}
/* End Notification */

/* Clearfix to clear the float */
header::after
{
    content: "";
    display: table;
    clear: both;
}

.container
{
    display: flex;
    justify-content: center;
    align-items: center;
}

.container
{
   width: 100%;
}

@media (max-width: 768px)
{
    .container
    {
        width: 100%;
    }
}

button
{
    border-radius: 50%;
    border: #D9D9D9 solid 1px;
    background: #FFFFFF;
    width: 130px;
    height: 130px;
    color: Black;
    text-align: center;
    font-weight: bolder;
    box-shadow: 0 3px 7px 1px #AAA;
    margin: 0px 20px;
}

.menu-button
{
    display: inline-block;
    padding: 5px;
}

.menu
{
    width: 80px;
    height: 80px;
    text-align: center;
    box-sizing: border-box;
    font-size: 30px;
    margin: 0px 10px;

}

.menu-item
{
    padding: 5px;
    align-items: center;
    text-align: center;
    margin-bottom: 50px;
}

.menu-item:hover
{
    background: #EEEEEE;
    color: #3290B1;
}

/* scrollbar style */
.scrollbar
{
    float: left;
    height: 75vh;
    width: 100%;
    overflow-y: scroll;
}

.scrollbar-force-overflow
{
    min-height: 75vh;
}

#wrapper
{
    text-align: center;
    margin: auto;
}

#style-all::-webkit-scrollbar
{
    display: none;
    width: 12px;
    background-color: #F5F5F5;
}

/**  STYLE Y */
#style-all::-webkit-scrollbar-thumb
{
    border-radius: 10px;
    background: linear-gradient(left, #96A6BF, #63738C);
    box-shadow: inset 0 0 1px 1px #5C6670;
}

#style-all::-webkit-scrollbar-track
{
    border-radius: 10px;
    background: #eee;
    box-shadow: 0 0 1px 1px #bbb, inset 0 0 7px rgba(0,0,0,0.3)
}

#style-all::-webkit-scrollbar-thumb:hover
{
    background: linear-gradient(left, #8391A6, #536175);
}

</style>

<script type="text/javascript">
    function DB2GTCS(argument)
    {
        var yes = confirm('你確定嗎？');

        if (yes) {
            let url = '?url=Settings/GTCS_DB_SYNC';
            $.ajax({
                type: "POST",
                data: { },
                // dataType: "json",
                url: url,
                beforeSend: function() {
                    $('#overlay').removeClass('hidden');
                },
            }).done(function(data) { //成功且有回傳值才會執行
                $('#overlay').addClass('hidden');
                // console.log(data);
                alert('success');
            }).fail(function() {
                // history.go(0);//失敗就重新整理
            });
        } else {

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

<?php require APPROOT . 'views/inc/footer.tpl'; ?>