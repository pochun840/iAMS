<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ECharts 折線圖範例</title>
    <!-- 引入 ECharts.js -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
</head>
<body>
    <!-- 定義一個具有指定大小（寬度和高度）的 div，用於顯示折線圖 -->
    <div id="chart" style="width: 800px; height: 600px;"></div>

    <script>
        // 初始化 ECharts 實例
        var myChart = echarts.init(document.getElementById('chart'));

        // 定義 x 軸的座標數據
        var xAxisData = [];
        for (var i = 0; i <= 1024; i++) {
            xAxisData.push(i);
        }

        // 定義 y 軸的數據（這裡以亂數生成）
        var seriesData = [];
        for (var i = 0; i <= 1024; i++) {
            seriesData.push(Math.random() * 100); // 生成 0 到 100 的隨機數
        }

        // 定義折線圖的配置項
        var option = {
            xAxis: {
                type: 'category',
                data: xAxisData
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: seriesData,
                type: 'line'
            }],
            // 設置 dataZoom，使用者可以縮放 x 軸的數據範圍
            dataZoom: [
                {
                    type: 'inside', // 內部的 dataZoom，使用滑桿縮放
                    start: 0,
                    end: 100 // 默認結束位置為 100%
                }
            ]
        };

        // 使用剛剛定義的配置項顯示折線圖
        myChart.setOption(option);
    </script>
</body>
</html>
