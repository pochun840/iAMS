<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pie Chart Example</title>
    <!-- 引入 ECharts -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.0/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 這裡放置圖表 -->
    <div id="pie-chart" style="width: 600px; height: 400px;"></div>

    <script>
        // 初始化 ECharts 實例
        var myChart = echarts.init(document.getElementById('pie-chart'));

        // 圖表的配置選項
        var option = {
            title: {
                text: '簡單圓餅圖示例',
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 10,
                data: ['類別一', '類別二', '類別三', '類別四', '類別五']
            },
            series: [
                {
                    name: '資料',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [
                        {value: 335, name: '類別一'},
                        {value: 310, name: '類別二'},
                        {value: 234, name: '類別三'},
                        {value: 135, name: '類別四'},
                        {value: 1548, name: '類別五'}
                    ],
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        // 使用剛剛定義的選項來繪製圖表
        myChart.setOption(option);
    </script>
</body>
</html>
