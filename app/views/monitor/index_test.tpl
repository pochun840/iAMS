<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>C3.js Line Chart with Custom Title</title>
<!-- 引入C3.js库 -->
<script src="https://d3js.org/d3.v7.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.css">
</head>
<body>

<!-- 使用自定义标题 -->
<div id="chart"></div>
<div id="chart-title">Custom Chart Title</div>

<script>
// 创建C3.js曲线图
var chart = c3.generate({
    bindto: '#chart',
    data: {
        columns: [
            ['data1', 30, 200, 100, 400, 150, 250],
            ['data2', 50, 20, 10, 40, 15, 25]
        ],
        types: {
            data1: 'line',
            data2: 'line'
        }
    }
});

// 自定义标题样式
var chartTitle = document.getElementById('chart-title');
chartTitle.style.textAlign = 'center';
chartTitle.style.fontSize = '24px'; // 设置标题字体大小
chartTitle.style.marginTop = '20px'; // 设置标题与图表的间距
</script>

</body>
</html>
