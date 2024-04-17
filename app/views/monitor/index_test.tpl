<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chart Example</title>
    <!-- 引入 Chart.js 库 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <canvas id="myChart" width="400" height="400"></canvas>

    <script>
        // 定义数据集
        var datasets = [{
            label: 'Dataset 1',
            borderColor: 'red',
            backgroundColor: 'rgba(255, 0, 0, 0.2)',
            data: [10, 20, 30, 40, 50]
        }];

        // 定义其他数据集变量
        var dataset2Variable = {
            label: 'Dataset 2',
            borderColor: 'orange',
            //data: [20, 30, 40, 50, 60] // 这里是示例数据，你可以根据需要修改
        };

        var dataset3Variable = {
            label: 'Dataset 3',
            borderColor: 'orange',
            //data: [30, 40, 50, 60, 70] // 这里是示例数据，你可以根据需要修改
        };

        var lineCookieValue = "1";

        if (lineCookieValue === "1") {
            datasets.push(dataset2Variable, dataset3Variable);
        }

        // 创建图表
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May'], // X轴标签
                datasets: datasets // 使用定义的数据集
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true // Y轴从0开始
                    }
                }
            }
        });
    </script>
</body>
</html>
