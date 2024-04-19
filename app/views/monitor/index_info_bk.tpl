<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/nav.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>/css/datatables.min.css">



<!---擷取畫面JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="<?php echo URLROOT; ?>js/historical.js?v=202404111700"></script>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/historical.css?v=202404111200" type="text/css">

<script src="<?php echo URLROOT; ?>js/flatpickr.js"></script>


<?php if(isset($data['nav'])){
    echo $data['nav'];
}
if(!empty($_COOKIE['chat_mode'])){
    $chat_mode = $_COOKIE['chat_mode'];
}else{
    $chat_mode = '';
}

if(!empty($_COOKIE['unit_mode'])){
    $unit_mode = $_COOKIE['unit_mode'];
}else{
    $unit_mode = '';
}

if(!empty($_COOKIE['line_style'])){
    $line_style = $_COOKIE['line_style'];
}else{
    $line_style = '';
}
?>

<style>
.t1{font-size: 17px; margin: 3px 0px; display: flex; align-items: center;}
.t2{font-size: 17px; margin: 3px 0px;}
.t3{font-size: 17px; margin: 3px 0px; height: 29px;border-radius: 5px;}
.t4{font-size: 17px; margin-right: 5px; border-radius: 5px}
.t5{margin-left: 10px; text-align: center;}
.t6{width: 116px;margin-right:10%}

</style>

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
               

                <!-- Click Detail Fastening Record Info -->
                <div id="DetailInfoDisplay"  name="DetailInfoDisplay" style="display: block">
                    <div class="topnav">
                        <label type="text" style="font-size: 18px; padding-left: 1%; margin: 4px">Fastenig record &#62; Info</label>
                        <button id="back-setting" type="button" onclick="window.history.back()">
                            <img id="img-back" src="./img/back.svg" alt=""  onclick="window.history.back()">Back
                        </button>
                    </div>

                    <table class="table" style="font-size: 15px; border-collapse: collapse;">
                        <tr>
                            <td>Index : <?php echo $data['job_info'][0]['system_sn'];?></td>
                            <td>BarcodeSN : <?php echo $data['job_info'][0]['cc_barcodesn'];?></td>
                            <td>Time : <?php echo $data['job_info'][0]['data_time'];?></td>
                            <td>Operator :  </td>
                            <td>Equipment : </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Final Torque : <?php echo $data['job_info'][0]['fasten_torque'];?> kgf.cm</td>
                            <td>Torque range : <?php echo $data['job_info'][0]['step_lowtorque'];?> ~ <?php echo $data['job_info'][0]['step_hightorque'];?></td>
                            <td>Final Angle :  <?php echo  $data['job_info'][0]['fasten_angle'];?></td>
                            <td>Angle range :  <?php echo  $data['job_info'][0]['step_lowangle'];?> ~ <?php echo $data['job_info'][0]['step_highangle'];?></td>
                            <td>Direction :    <?php echo  $data['status_arr']['direction'][$data['job_info'][0]['count_direction']];?></td>
                            <td>Error code :   <?php echo  $data['status_arr']['error_msg'][$data['job_info'][0]['error_message']];?></td>
                        </tr>
                        <tr style="vertical-align: middle;">
                            <td>Job : <?php echo $data['job_info'][0]['job_name'];?></td>
                            <td>Seq/task :<?php echo $data['job_info'][0]['sequence_name']. "/". $data['job_info'][0]['cc_task_name'];?></td>
                            <td>Program : </td>
                            <td>Note : </td>
                            <td>Status : <a style="background-color: <?php echo $data['status_arr']['status_color'][$data['job_info'][0]['fasten_status']];?>; padding: 0 10px"><?php echo $data['status_arr']['status_type'][$data['job_info'][0]['fasten_status']];?></a></td>
                            <td>
                                <input class="form-check-input" type="checkbox" name="" id="myCheckbox"    style="zoom:1.2; float: left" value="0"   <?php if($line_style =="1"){ echo "checked";} ?> >&nbsp; display the high/low auxiliary lines.
                            </td>
                        </tr>

                        <tr style="vertical-align: middle">
                            <td>
                                Chart : <select id="Chart-seting" class="t6 Select-All" style="float: none"  onchange="chat_mode(this)">
                                            <?php foreach($data['chat_mode_arr'] as $k_chat => $v_chat){?>
                                                <option  value="<?php echo $k_chat;?>"  <?php if($chat_mode==$k_chat){echo "selected";}else{echo "";}?>  > <?php echo $v_chat;?> </option>
                                            <?php } ?>
                                                             
                                        </select>
                            </td>
                            <td>
                                Torque Unit:    <select id="Torque-Unit" class="Select-All" style="float: none; width: 100px" onchange="unit_change(this)">
                                                    <?php foreach($data['torque_mode_arr'] as $k_torque => $v_torque){?>
                                                            <option  value="<?php echo $k_torque;?>"  <?php if($unit_mode == $k_torque){echo "selected";}else{echo "";}?>  > <?php echo $v_torque;?> </option>
                                                    <?php } ?>
                                                </select>
                            </td>
                            <td>
                                Angle:  <select id="Angle" class="t6 Select-All" style="float: none; width: 100px" onchange="angle_change(this)">
                                            <option value="1">Total angle</option>
                                            <option value="2">Task angle</option>
                                        </select>
                            </td>
                            <!--<td>
                                Sampling:  <select id="SelectOutputSampling" class="t6 Select-All" style="float: none; width: 100px" onchange="ms_change(this)">
                                            <option value="1">1(ms)</option>
                                            <option value="2">0.5(ms)</option>
                                            <option value="3">2(ms)</option>
                                        </select>
                            </td>-->
                            <td>
                                <button id="Export-Excel" type="button" class="ExportButton" style="margin-top: 0">Export Excel</button>
                                <!--<button id="Save-info" type="button" style="margin-top: 0" onclick='save_option()'>Save</button>-->
                            </td>
                            <td></td>
                        </tr>
                    </table>
                        <div style="text-align: center" id ="dds">
                            <label style="float: left"><b>Diagram Display</b></label>
                            <label><?php echo $data['chat']['chat_name'];?></label>
                        </div>
                        <div id="chart-setting">
                            <div class="chart-container">
                                <div class="menu-chart" onclick="toggleMenu()">
                                    <i class="fa fa-bars" style="font-size: 26px"></i>
                                    <div class="menu-content" id="myMenu">
                                        <a  onclick="viewFullScreen()" class="view-fullscreen">View in full screen</a>
                                        <a  href="#" onclick="printChart()">Print chart</a>
                                        <a  onclick="takeScreenshot('png')">Download PNG</a>
                                        <a  onclick="takeScreenshot('jpg')">Download JEPG</a>
                                    </div>
                                </div>
                                 <br>
                                 <!---曲線圖資料---->
                                 <canvas id="myChart" width="300" height="60"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                
            </div>

            <!-- Work Flow Log Setting -->
     

             
            
            </div>

            <!-- User Access Setting -->
     
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
    //document.getElementById('DetailInfoDisplay').style.display = 'block';

    // Hide FasteningDisplay
    document.getElementById('FasteningDisplay').style.display = 'none';
}



function WorkFlowLogInfo()
{
    // Show Work Flow Log Info
    document.getElementById('WorkFlowLogInfoDisplay').style.display = 'block';

    // Hide Work Flow Log
    document.getElementById('WorkFlowLogDisplay').style.display = 'none';
}

function cancelSetting()
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
}


/// Chart menu button setting
window.onload = function()
{
    var fullScreenButton = document.querySelector('.menu-content a[href="#"][onclick="viewFullScreen()"]');
    fullScreenButton.style.display = "block"; // ?n nut Close full screen khi trang ???c t?i l?n ??u
};

function toggleMenu()
{
    var menuContent = document.getElementById("myMenu");
    menuContent.style.display = (menuContent.style.display === "block") ? "none" : "block";

    var fullScreenButton = document.querySelector('.menu-content a[href="#"][onclick="viewFullScreen()"]');
    var closeButton = document.querySelector('.menu-content a[href="#"][onclick="closeFullScreen()"]');

    if (fullScreenButton.style.display === "block")
    {
        fullScreenButton.style.display = "block";
        closeButton.style.display = "none";
    }
    else
    {
        fullScreenButton.style.display = "none";
        closeButton.style.display = "block";
    }
}

function viewFullScreen()
{
    var chartContainer = document.querySelector('.chart-container');
    chartContainer.classList.add('full-screen');

    var fullScreenButton = document.querySelector('.menu-content a[href="#"][onclick="viewFullScreen()"]');
    var closeButton = document.querySelector('.menu-content a[href="#"][onclick="closeFullScreen()"]');

    fullScreenButton.style.display = "none";
    closeButton.style.display = "block";
}

function closeFullScreen()
{
    var chartContainer = document.querySelector('.chart-container');
    chartContainer.classList.remove('full-screen');

    var fullScreenButton = document.querySelector('.menu-content a[href="#"][onclick="viewFullScreen()"]');
    var closeButton = document.querySelector('.menu-content a[href="#"][onclick="closeFullScreen()"]');

    fullScreenButton.style.display = "block";
    closeButton.style.display = "none";
}

function printChart()
{
    // Logic for printing the chart goes here
}

/// Onclick event for row background color
$(document).ready(function () {
    // Call highlight_row function with table id
    //highlight_row('fastening-table');
    //highlight_row('WorkFlowLog-table');
    //highlight_row('UserAccess-table');
});

/*function highlight_row(tableId)
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
}*/

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
<script>
    

    //整理曲線圖的數據 
    var datasets = [{
        label: '<?php echo $data['chat']['yaxis_title'];?>',
        data: [<?php echo $data['total_range'];?>],
        borderColor: 'rgba(0, 0, 255, 1)',  
        borderWidth: 2,
        pointRadius: 1,
        //borderWidth: 0,
    }];

    var dataset2Variable = {
        label: 'High Torque',
        borderColor: 'rgba(0, 0, 0, 0)', 
        backgroundColor: 'rgba(0, 0, 0, 0)', 
        pointRadius: 1,
    };

    var dataset3Variable = {
        label: 'Low Torque',
        Color: 'orange',
        borderColor: 'rgba(0, 0, 0, 0)', 
        backgroundColor: 'rgba(0, 0, 0, 0)', 
    };


    var dataset4Variable = {
        label: 'Low Torque',
        Color: 'orange',
        borderColor: 'rgba(0, 0, 0, 0)', 
        backgroundColor: 'rgba(0, 0, 0, 0)', 
    };

    //折線圖
    var checkbox = document.getElementById('myCheckbox');
    checkbox.addEventListener('change', function() {
        displayValue = this.checked;
        if (displayValue) {
            var line_style = '1';
        } else {
            var line_style = '0';
        }
        document.cookie = "line_style=" + line_style + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
        history.go(0);
    });
    


    // 設置 x 軸的長度
    var stepSize = 1; // 設置每個節點之間的距離
    var xAxisConfig = {
            type: 'linear',
            position: 'bottom',
            min: 0,
            ticks: {
                stepSize: stepSize,
                maxRotation: 0, 
                minRotation: 0 
            },
            title: {
                display: true,
                text: '<?php echo $data['chat']['xaxis_title'];?>',
                align: 'end',
            },
        };

    var yAxosConfig = {
        min: 0,
        suggestedMin: <?php echo $data['y_minvalue'];?>, 
        suggestedMax: <?php echo $data['y_maxvalue'];?>, 
    
        title: {
            display: true,
            text: '<?php echo $data['chat']['yaxis_title'];?>',
            align: 'top',
        },

       grid: {
            color: function(context) {
                //有勾選上下限的時候 才會執行下面
                if (lineCookieValue == "1") {
                    if (context.tick.value == low_val) {
                        return 'orange';
                    } else if (context.tick.value == high_val) {
                        return 'green';
                    }
                }

            }
        }
    }  

    
    //有勾選上下限的時候 才會把 dataset2Variable && dataset3Variable 加入
    //雖然裡面沒有資料 只是要秀在title上
    if (lineCookieValue === "1") {
        datasets.push(dataset2Variable, dataset3Variable);
    }

    var ctx = document.getElementById('myChart').getContext('2d');

    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
        labels: [<?php echo $data['x_nodal_point'];?>],
        datasets:datasets,
    },

        options: {
            scales: {
                x: xAxisConfig,
                y: yAxosConfig, 
            },
            plugins: {
                tooltip: {
                    enabled: true,
                }
            }
        },

    });
</script>
