<?php date_default_timezone_set('Asia/Taipei');?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/print-history-excel.css">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/datatables.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.5.0/jszip.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script src="<?php echo URLROOT; ?>js/historical.js?v=202405021000"></script>
</head>

<body>
    
    <div class="excel-sheet">
        <header class="border-bottom">
            <h2><img src="./img/logo.jpg" alt="Logo"></h2>
            <p  style="font-weight: bold; font-size: 34px; padding-bottom: 5px">Fastening Statistics Report</p>
                <!--<button id="downloadHtmlBtn">Download HTML</button>-->

        </header>

        <div style="padding-top: 10px;">
            <table class="table table-bordered" style="">
                <tr>
                    <td colspan="4" style="text-align: left; padding-left: 5.7%"> Report Time :<?php echo date("Y-m-d H:i:s");?></td>
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
        <label style="font-weight: bold">Lock Status Statistics</label> 
        
        <!--<label style="font-weight: bold; margin-left: 50%">Fastening Status</label>-->
        <div style="padding-bottom: 20px">
    
            <!--<img src="img/fastening-log.png" width="60%" height="220" alt="">-->
            <div id="lineChart" style="width: 950px;height:400px;"></div>
            <div  align="center" id="fastening_status_chart" style="width: 40%; height: 400px;"></div>
        </div>
        <hr>
        <label style="font-weight: bold">Screw Time</label> 
        <div style="padding-bottom: 20px">
            
            <div id="main" style="width: 60%;height:350px;"></div>
            
            <!--<img src="img/job-time.png" width="40%" height="155px" alt="">-->
            <div id="jobtime" style="width: 40%;height:400px;"></div>
        </div>
        <hr>
        <label style="font-weight: bold">Station Time</label>
        <div style="padding-bottom: 20px">
            <img src="img/station-time.png" width="70%" height="200" alt="">
        </div>
        
        <!--<label style="font-weight: bold; margin-top: 5%">NG Reason</label>-->
        <div style="padding-bottom: 20px">
            <div id="chart" style="width: 600px; height: 400px;"></div>
        </div>
        <hr>
        <label style="font-weight: bold">NG Error v.s Operator</label>
        <div style="padding-bottom: 20px">
            <img src="img/NG v.s Operator.png" width="60%" height="200" alt="">
        </div>
    </div>
</body>
</html>
<script>
    var ng_reason = <?php echo $data['ng_reason_json']; ?>;
    var myChart = echarts.init(document.getElementById('chart'));
    var option = {
        title: {
            text: 'NG Reason',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ng_reason.map(function(item) { return item.name; })
        },
        series: [
            {
                name: 'Error Type',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: ng_reason,
                animationType: 'scale', // 添加動畫效果
                animationEasing: 'elasticOut' // 彈性彈跳效果
            }
        ]
    };
    myChart.setOption(option);

    var job_time = <?php echo $data['job_time_json']; ?>;
    var jobtimeChart = echarts.init(document.getElementById('jobtime'));
      var option = {
        title: {
            text: 'JOB VS TIME',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: job_time.map(function(item) { return item.name; })
        },
        series: [
            {
                name: 'Time Required',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: job_time,
                animationType: 'scale', // 添加動畫效果
                animationEasing: 'elasticOut' // 彈性彈跳效果
            }
        ]
    };
    jobtimeChart.setOption(option);



    var fastening_status =<?php echo $data['fastening_status']; ?>;
    var fChart = echarts.init(document.getElementById('fastening_status_chart'));
    var option = {
        title: {
            text: 'fastening_status',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: fastening_status.map(function(item) { return item.name; })
        },
        series: [
            {
                name: 'Status',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: fastening_status,
                animationType: 'scale', // 添加動畫效果
                animationEasing: 'elasticOut' // 彈性彈跳效果
            }
        ]
    };
    fChart.setOption(option);

    var maimchart = echarts.init(document.getElementById('main'));
    var job_name  =<?php echo $data['job_info']['job_name']; ?>;
    var fasten_time  =<?php echo $data['job_info']['fasten_time']; ?>;

    var option = {
        tooltip: {
            trigger:'axis',
            formatter: '{b0}({a0}): {c0}'
        },
        legend: {
            data:['']
        },
        xAxis: {
            data: job_name
        },
        yAxis: [ {
            type: 'value',
            name: '毫秒',
            show:true,
            interval: 10,
            axisLine: {
                lineStyle: {
                    color: '#5e859e',
                    width: 2
                }
            }
        },{
            type: 'value',
            name: '',
            //min: 0,
            //max: 100,
            interval: 10,
            axisLabel: {
                //formatter: '{value} %'
            },
            axisLine: {
                lineStyle: {
                    color: '#5e859e',//纵坐标轴和字体颜色
                    width: 2
                }
            }
        }],
        series: [{
            name: '毫秒',
            type: 'bar',
            barWidth : '50%',
            data: fasten_time
        }]
    };

    maimchart.setOption(option);

    var lineChart = echarts.init(document.getElementById('lineChart'));

    var line_title =<?php echo $data['statistics']['date'];?>;
    var line_ng =<?php echo $data['statistics']['ng'];?>;
    var line_ok =<?php echo $data['statistics']['ok'];?>;
    var line_okall =<?php echo $data['statistics']['ok_all'];?>;

        // ECharts 的配置選項
        var options = {
            title: {
                text: ''
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:['', '', '']
            },
            xAxis: {
                type: 'category',
                data: line_title
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    name: 'OK',
                    type: 'line',
                    data: line_ok
                },
                {
                    name: 'NG',
                    type: 'line',
                    data: line_ng
                },
                {
                    name: 'OKALL',
                    type: 'line',
                    data: line_okall
                }
            ]
        };

    lineChart.setOption(options);

    function downloadHtml() {

        const htmlContent = document.documentElement.outerHTML;
        const blob = new Blob([htmlContent], { type: 'text/html' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'current_page.html';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }
        




</script>