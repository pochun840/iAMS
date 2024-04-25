<!DOCTYPE html>
<html>
<head>
    <title>图表导出为图片</title>
    <!-- 引入 D3.js 库 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.16.0/d3.min.js"></script>
    <!-- 引入 C3.js 库 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.js"></script>
</head>
<body>
    <button onclick="exportChart()">导出图表为图片</button>

    <div id="chartContainer"></div>

    <script>
        // 创建 c3.js 曲线图
        var chart = c3.generate({
            bindto: '#chartContainer',
            data: {
                columns: [
                    ['data1', 30, 200, 100, 400, 150, 250],
                    ['data2', 50, 20, 10, 40, 15, 25]
                ]
            }
        });

        // 导出图表为图片函数
        function exportChart() {
            // 使用 c3.js 提供的图片导出功能
            chart.exportChart({
                format: 'png',
                filename: 'chart',
                done: function() {
                    alert('图表已成功导出为图片！');
                }
            });
        }
    </script>
</body>
</html>
