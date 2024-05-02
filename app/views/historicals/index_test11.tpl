<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ECharts Example</title>
    <!-- 引入 ECharts 库 -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.2.1/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 在此放置圖表容器 -->
    <div id="chart" style="width: 700px; height: 400px;"></div>

    <script>

        var myChart = echarts.init(document.getElementById('chart'));


        //新的定義配置
        //no1 
        var x_data_val = <?php echo  $data['chart_info']['x_val']; ?>;
        var y_data_val = <?php echo  $data['chart_info']['y_val']; ?>;
        var min_val = <?php echo  $data['chart_info']['min'];?>;
        var max_val = <?php echo  $data['chart_info']['max'];?>;


        //no2
        var x_data_val_1 = <?php echo  $data['chart_info1']['x_val']; ?>;
        var y_data_val_1 = <?php echo  $data['chart_info1']['y_val']; ?>;
        var min_val_1 = <?php echo  $data['chart_info1']['min'];?>;
        var max_val_1 = <?php echo  $data['chart_info1']['max'];?>;



        var option = {
              tooltip: {
                trigger: 'axis',
                position: function (pt) {
                    return [pt[0], '10%'];
                },
                formatter: function (params) {
                    var state = 'Torque'; 
                    var value = params[0].value; 
                    return state + ': ' + value; 
                }
            },

    xAxis: {
        type: 'category',
        boundaryGap: false,
        name: 'Time(ms)',
        data: x_data_val
    },
    yAxis: {
        type: 'value',
        name: 'Torque',
        boundaryGap: [0, '100%']
    },
    dataZoom: [
        {
            type: 'inside', // 內置的 dataZoom 類型
            start: 0, // 起始位置百分比
            end: 100 // 結束位置百分比
        },
        {
            show: false, // 顯示滑塊型的 dataZoom
            type: 'slider', // 滑塊型的 dataZoom 類型
            start: 0, // 初始的起始位置百分比
            end: 100, // 初始的結束位置百分比
            handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z', // 自定義滑塊的圖標
            handleSize: '80%', // 滑塊的大小
            handleStyle: {
                color: '#fff', // 滑塊的顏色
                shadowBlur: 3, // 滑塊的陰影模糊度
                shadowColor: 'rgba(0, 0, 0, 0)', // 滑塊的陰影顏色
                shadowOffsetX: 2, // 滑塊的陰影 X 方向偏移
                shadowOffsetY: 2 // 滑塊的陰影 Y 方向偏移
            }
        }
    ],
    series: [
        {
            name: '曲線1', // 第一條曲線的名稱
            type: 'line',
            symbol: 'none',
            sampling: 'average',
            itemStyle: {
                normal: {
                    color: 'rgb(0, 0, 255)' // 藍色
                }
            },
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255,255,255)'
                    }, {
                        offset: 1,
                        color: 'rgb(255,255,255)'
                    }])
                }
            },
            lineStyle: {
                width: 2 // 設置線條粗細
            },
            data: y_data_val // 第一條曲線的數據
        },
        {
            name: '曲線2', // 第二條曲線的名稱
            type: 'line',
            symbol: 'none',
            sampling: 'average',
            itemStyle: {
                normal: {
                    color: 'rgb(0, 255, 0)' // 綠色
                }
            },
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255,255,255)'
                    }, {
                        offset: 1,
                        color: 'rgb(255,255,255)'
                    }])
                }
            },
            lineStyle: {
                width: 0.75 // 設置線條粗細
            },
            data: y_data_val_1 // 第二條曲線的數據
        }
    ]
};

        myChart.setOption(option);
    </script>
</body>
</html>
