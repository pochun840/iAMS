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
<button id="downloadBtn">截圖並下載</button>

<script>
// 生成 c3.js 曲線圖
var chart = c3.generate({
    bindto: '#chart',
    data: {
        columns: [
            ['data1', 30, 200, 100, 400, 150, 250],
            ['data2', 130, 100, 140, 200, 150, 50]
        ],
        type: 'line' // 設置曲線圖類型
    }
});

// 點擊按鈕時執行截圖並下載
document.getElementById("downloadBtn").addEventListener("click", function() {
    // 使用 DOM to Image 將 c3.js 圖表轉換為圖像
    domtoimage.toBlob(document.getElementById('chart'), { bgcolor: '#ffffff' }) // 設置背景顏色為白色
        .then(function(blob) {
            // 創建下載連結
            var downloadLink = document.createElement("a");
            downloadLink.href = URL.createObjectURL(blob);
            downloadLink.download = "chart_screenshot.png"; // 下載的文件名稱

            // 模擬點擊下載連結
            downloadLink.click();
        });
});
</script>


</body>
</html>
