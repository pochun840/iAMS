<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <!-- 引入 ECharts 库 -->
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 在此放置圖表容器 -->
    <div id="chart" style="width: 700px; height: 400px;"></div>

    <script>

        var myChart = echarts.init(document.getElementById('chart'));


        //新的定義配置
        var x_data_val = <?php echo  $data['chart_info']['x_val']; ?>;
        var y_data_val = <?php echo  $data['chart_info']['y_val']; ?>;

        var min_val = <?php echo  $data['chart_info']['min'];?>;
        var max_val = <?php echo  $data['chart_info']['max'];?>;

        var option = {
            tooltip: {
                trigger: 'axis',
                position: function (pt) {
                    return [pt[0], '10%'];
                },
                formatter: function (params) {
                    var state = '<p class="tooltip-text">Torque</p>'; 
                    var state = 'Torque'; 
                    var value = params[0].value; 
                    return state + ': ' + value; 
                },
                
            },
            title: {
                left: 'center',
                text: '',
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
            dataZoom: [{
                type: 'inside',
                start: 0,
                end: 10
            }, {
                show: false, 
                type: 'slider',
                start: 0,
                end: 10,
                handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
                handleSize: '80%',
                handleStyle: {
                    color: '#fff',
                    shadowBlur: 3,
                    shadowColor: 'rgba(0, 0, 0, 0)',
                    shadowOffsetX: 0,
                    shadowOffsetY: 0
                }
            }],
            series: [
                {
                    name:'',
                    type:'line',
                    //smooth:true,
                    symbol: 'none',
                    sampling: 'average',
                    
                    itemStyle: {
                        normal: {
                            color: 'rgb(255,0,0)'
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
                            width: 1.25
                    },
                    data: y_data_val
                }
            ]
        };
        myChart.setOption(option);
    </script>
</body>
</html>
<style>
.tooltip-text {
    color: red;
}
</style>