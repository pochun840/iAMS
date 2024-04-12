<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chart.js Line Chart with Mousemove</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <canvas id="myChart" width="300" height="40"></canvas>
<script>

    var maxWidth = 1500; // 最大寬度
    var chartCanvas = document.getElementById('myChart'); // 取得Canvas元素
    var chartWidth = chartCanvas.offsetWidth; // 取得Canvas元素的寬度

    // 如果圖表寬度超過最大寬度，將寬度設置為最大寬度
    if (chartWidth > maxWidth) {
        chartCanvas.style.width = maxWidth + 'px';
    }

    var ctx = document.getElementById('myChart').getContext('2d');

    // 生成隨機數據
    var data = [];
    for (var i = 0; i < 1000; i++) {
        var xVal = i;
        var yVal = Math.random() * 100;
        data.push({x: xVal, y: yVal});
    }

    // 設置 x 軸的步長
    var stepSize = 6; // 設置每個節點之間的距離
    var xAxisConfig = {
        type: 'linear',
        position: 'bottom',
        min: 0,
        ticks: {
            stepSize: stepSize, // 設置 x 軸的步長
            maxRotation: 0, // 最大旋轉角度
            minRotation: 0 // 最小旋轉角度
        },
        title: {
            display: true,
            text: 'SSSS',
            align: 'end',
        }
};


  



    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            datasets: [{
                label: 'Random Data',
                data: data,
                fill: false,
                tension: 0.1,
                pointRadius: 3, // 設置節點半徑
                borderWidth: 2, // 設置線條寬度
            }]
        },
        options: {
            scales: {
                 x: xAxisConfig,
               
                y: {
                    min: 0,
                    title: {
                        display: true,
                        text: 'EDDD',
                    }
                }
            },
            plugins: {
                tooltip: {
                    enabled: true,
                }
            }
        }
    });

</script>

</body>
</html>
