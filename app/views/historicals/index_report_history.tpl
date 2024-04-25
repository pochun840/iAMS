
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/print-history-excel.css">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/datatables.min.css">
<!-----echart.js 測試-->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.0/dist/echarts.min.js"></script>



</head>

<body>

    <div class="excel-sheet">
        <header class="border-bottom">
            <h2><img src="./img/logo.jpg" alt="Logo"></h2>
            <p  style="font-weight: bold; font-size: 34px; padding-bottom: 5px">Fastening Statistics Report</p>
        </header>

        <div style="padding-top: 10px;">
            <table class="table table-bordered" style="">
                <tr>
                    <td colspan="4" style="text-align: left; padding-left: 5.7%"> Report Time : <?php echo date("Y-m-d H:i:s");?></td>
                </tr>
                <tr>
                    <td>Screw drivers : 3</td>
                    <td>Program : 3</td>
                    <td>Sample quantity : 65</td>
                    <td>Operator : Esther</td>
                </tr>
                <tr>
                    <td>Station : station1</td>
                    <td>Job quantity: 20</td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
        <label style="font-weight: bold">Lock Status Statistics</label> <label style="font-weight: bold; margin-left: 50%">Fastening Status</label>
        <div style="padding-bottom: 20px">
            <img src="img/fastening-log.png" width="60%" height="220" alt=""><img src="img/fastening-status.png" width="40%" height="165px" alt="">
        </div>
        <hr>
        <label style="font-weight: bold">Screw Time</label> <label style="font-weight: bold; margin-left: 60%">Job V.s Time</label>
        <div style="padding-bottom: 20px">
            <img src="img/screw-time.png" width="60%" height="200" alt=""><img src="img/job-time.png" width="40%" height="155px" alt="">
        </div>
        <hr>
        <label style="font-weight: bold">Station Time</label>
        <div style="padding-bottom: 20px">
            <img src="img/station-time.png" width="70%" height="200" alt="">
        </div>
        
        <label style="font-weight: bold; margin-top: 5%">NG Reason</label>
        <div style="padding-bottom: 20px">
            


        </div>
        <hr>
        <label style="font-weight: bold">NG Error v.s Operator</label>
        <div style="padding-bottom: 20px">
            <img src="img/NG v.s Operator.png" width="60%" height="200" alt="">
        </div>
    </div>
</body>
</html>




