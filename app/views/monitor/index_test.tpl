<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Line Chart with D3.js</title>
    <script src="https://d3js.org/d3.v7.min.js"></script>
</head>
<body>
    <div id="chart-container"></div>

    <script>
        var maxWidth = 1500; // 最大寬度
        var chartWidth = 2000; // 圖表寬度

        // 如果圖表寬度超過最大寬度，將寬度設置為最大寬度
        if (chartWidth > maxWidth) {
            chartWidth = maxWidth;
        }

        var svg = d3.select("#chart-container")
            .append("svg")
            .attr("width", chartWidth)
            .attr("height", 400); // 假設高度為400像素

        // 生成隨機數據
        var data = d3.range(1050).map(function(d, i) {
            return { x: i, y: Math.random() * 100 };
        });

        // 使用d3.js繪製折線圖
        var line = d3.line()
            .x(function(d) { return d.x; })
            .y(function(d) { return d.y; });

        svg.append("path")
            .datum(data)
            .attr("fill", "none")
            .attr("stroke", "steelblue")
            .attr("stroke-width", 2)
            .attr("d", line);
    </script>
</body>
</html>
