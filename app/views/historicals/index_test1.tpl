<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>曲線圖</title>
    <!-- 引入 ECharts -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.0/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 用來顯示曲線圖的容器 -->
    <div id="chart" style="width: 800px; height: 400px;"></div>

    <script>
        var myChart = echarts.init(document.getElementById('chart'));

        // 假設以下數據是從 PHP 中獲取的
        var x_data_val = <?php echo $data['chart_info']['x_val']; ?>; // X軸
        var y_data_val = <?php echo $data['chart_info']['y_val']; ?>; // Y軸1(torque)
        var y_data_val_1 = <?php echo $data['chart_info']['y_val_1']; ?>; // Y軸2(angle)

        var max_val = <?php echo $data['chart_info']['max']; ?>; // Y軸1的上限
        var min_val = <?php echo $data['chart_info']['min']; ?>; // Y軸1的下限

        var max_val_1 = <?php echo $data['chart_info']['max1']; ?>; // Y軸2的上限
        var min_val_1 = <?php echo $data['chart_info']['min1']; ?>; // Y軸2的上限

        var option = {
            tooltip: {
                trigger: 'axis',
                position: function (pt) {
                    return [pt[0], '10%'];
                },
                formatter: function (params) {
                    return 'Torque: ' + params[0].value + '<br/>Angle: ' + params[1].value;
                }
            },
            title: {
                left: 'center',
                text: 'Torque & Angle'
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                name: 'Time(ms)',
                data: x_data_val
            },
            yAxis: [
                {
                    type: 'value',
                    name: 'Torque',
                    min: min_val,
                    max: max_val
                },
                {
                    type: 'value',
                    name: 'Angle',
                    min: min_val_1,
                    max: max_val_1
                }
            ],
            series: [
                {
                    name: 'Torque',
                    type: 'line',
                    yAxisIndex: 0,
                    symbol: 'none',
                    sampling: 'average',
                    itemStyle: {
                        color: 'rgb(255,0,0)'
                    },
                    lineStyle: {
                        width: 1.25
                    },
                    data: y_data_val
                },
                {
                    name: 'Angle',
                    type: 'line',
                    yAxisIndex: 1,
                    symbol: 'none',
                    sampling: 'average',
                    itemStyle: {
                        color: 'rgb(0,0,255)'
                    },
                    lineStyle: {
                        width: 1.25
                    },
                    data: y_data_val_1
                }
            ]
        };

        myChart.setOption(option);
    </script>
</body>
</html>
