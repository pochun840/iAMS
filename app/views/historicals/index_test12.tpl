<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chart Example</title>
    <!-- 引入 echarts 库 -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 用于呈现图表的容器 -->
    <div id="chartContainer" style="width: 600px; height: 400px;"></div>

    <script>
        // 初始化 echarts 实例
        var myChart = echarts.init(document.getElementById('chartContainer'));

        // 模拟的数据
        var x_data_val = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
        var y_data_val = [220, 182, 191, 234, 290, 330];
        var min_val = 200;
        var max_val = 320;

        // 配置项
        var option = {
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: x_data_val
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: y_data_val,
                type: 'line'
            }]
        };

        // 如果 limit_val=1 曲線圖 要顯示上下限 min_val 及 max_val
        // 则添加标记线
        var limit_val = 1;
        if (limit_val === 1) {
            option.series[0].markLine = {
                data: [
                    {yAxis: min_val, name: 'Lower Limit'}, // 下限
                    {yAxis: max_val, name: 'Upper Limit'}  // 上限
                ]
            };
        }

        // 使用配置项配置图表
        myChart.setOption(option);
    </script>
</body>
</html>
