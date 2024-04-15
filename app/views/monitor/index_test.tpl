<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chart Title with Styled Box</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <canvas id="myChart" width="400" height="400"></canvas>

    <script>
        var ctx = document.getElementById('myChart').getContext('2d');

        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                datasets: [{
                    label: 'Dataset 1',
                    data: [10, 20, 30, 40, 50, 60, 70],
                    borderColor: 'blue',
                    borderWidth: 1
                }]
            },
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: 'Chart Title',
                        font: {
                            size: 14
                        },
                        color: 'transparent', // 隐藏默认标题颜色
                        position: 'top',
                        align: 'start', // 左对齐标题
                        padding: {
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10
                        },
                        // 使用回调函数自定义标题内容
                        formatter: function(context) {
                            return '<div style="background-color: yellow; display: inline-block; padding: 5px; border-radius: 5px;">' + context.text + '</div>';
                        }
                    }
                },
                // 其他图表配置...
            }
        });
    </script>
</body>
</html>
