<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D3.js Curved Line Chart with Moveable X-Axis and Y-Axis</title>
    <script src="https://d3js.org/d3.v5.min.js"></script>
    <style>
        .chart-container {
            position: relative;
            width: 800px;
            height: 400px;
            margin: 0 auto;
        }
        .chart {
            width: 100%;
            height: 100%;
        }
        .x-axis-slider {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 40px;
        }
        .tooltip {
            position: absolute;
            background-color: white;
            padding: 5px;
            border: 1px solid black;
            pointer-events: none;
            display: none;
        }
        .line {
            fill: none;
            stroke: steelblue;
            stroke-width: 2px;
        }
        .y-axis {
            font-size: 12px;
        }
    </style>
</head>
<body>

<div class="chart-container">
    <svg class="chart"></svg>
    <input type="range" min="0" max="100" value="0" class="x-axis-slider" id="xAxisSlider">    
</div>


<script>
    var data = [];
    for (var i = 0; i < 500; i++) {
        data.push({ x: i, y: Math.random() * 100 });
    }

    var margin = { top: 20, right: 20, bottom: 60, left: 50 },
        width = 800 - margin.left - margin.right,
        height = 400 - margin.top - margin.bottom;

    var svg = d3.select(".chart")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var xScale = d3.scaleLinear()
        .domain([0, 499]) 
        .range([0, width]);

    var yScale = d3.scaleLinear()
        .domain([0, d3.max(data, d => d.y)])
        .range([height, 0]);

    var line = d3.line()
        .x(d => xScale(d.x))
        .y(d => yScale(d.y))
        .curve(d3.curveBasis); // 曲线类型

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", line);

    svg.append("g")
        .attr("class", "x-axis")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(xScale));

    svg.append("g")
        .attr("class", "y-axis")
        .call(d3.axisLeft(yScale));

    var xAxisSlider = document.getElementById("xAxisSlider");
    xAxisSlider.addEventListener("input", function() {
        var sliderValue = +this.value;
        var newXScale = d3.scaleLinear()
            .domain([sliderValue, sliderValue + 399])
            .range([0, width]);
        var newLine = d3.line()
            .x(d => newXScale(d.x))
            .y(d => yScale(d.y))
            .curve(d3.curveBasis); 
        svg.select(".line").attr("d", newLine);
        svg.select(".x-axis").call(d3.axisBottom(newXScale));
    });


</script>

</body>
</html>
