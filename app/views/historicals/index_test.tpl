<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DOM to Image 與 C3.js 下載示例</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.18/c3.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>
</head>
<body>

<!-- 定義一個用於顯示 c3.js 曲線圖的容器 -->
<div id ='eeww'>
    <p>jjjejej</p>
    <br><br><br><br>
    <div id="chart"></div>
</div>

<!-- 添加截圖並下載的按鈕 -->
<button onclick="downloadChart()">截圖並下載</button>
<a onclick="alert('1')">超連結1</a><br>

<script>
// 生成 c3.js 曲線圖
var data1 = ['data1'];
var data2 = ['data2'];
for (var i = 0; i < 900; i++) {
    data1.push(Math.floor(Math.random() * 1000)); // 添加隨機數據
    data2.push(Math.floor(Math.random() * 1000)); // 添加隨機數據
}

var chart = c3.generate({
    bindto: '#chart',
    data: {
        columns: [
            data1,
            data2
        ],
        type: 'line' // 設置曲線圖類型
    }
});

function downloadChart() {
    // 使用 DOM to Image 將 c3.js 圖表轉換為圖像
    domtoimage.toBlob(document.getElementById('eeww'), { bgcolor: '#ffffff' }) // 設置背景顏色為白色
        .then(function(blob) {

            console.log('eeeer');

            // 創建下載連結
            var downloadLink = document.createElement("a");
            downloadLink.href = URL.createObjectURL(blob);
            downloadLink.download = "chart_screenshot.png"; // 下載的文件名稱

            // 模擬點擊下載連結
            downloadLink.click();
        });
}
</script>

</body>
</html>
