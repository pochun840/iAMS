<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Download Page with CSS</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div id="chart1"></div>
    <div id="chart2"></div>
    <div id="chart3"></div>

    <button id="downloadBtn">Download Page</button>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.16.0/d3.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.js"></script>
    <script>
        // Create sample C3.js charts
        var chart1 = c3.generate({
            bindto: '#chart1',
            data: {
                columns: [
                    ['data1', 30, 200, 100, 400, 150, 250],
                    ['data2', 50, 20, 10, 40, 15, 25]
                ]
            }
        });

        var chart2 = c3.generate({
            bindto: '#chart2',
            data: {
                columns: [
                    ['data1', 130, 100, 140, 200, 150, 50],
                    ['data2', 230, 200, 240, 250, 250, 100]
                ]
            }
        });

        var chart3 = c3.generate({
            bindto: '#chart3',
            data: {
                columns: [
                    ['data1', 30, 200, 100, 400, 150, 250],
                    ['data2', 130, 300, 200, 300, 250, 450]
                ]
            }
        });

        // Function to download the page as HTML file
        document.getElementById('downloadBtn').addEventListener('click', function() {
            var htmlContent = document.documentElement.outerHTML;
            var stylesheets = document.getElementsByTagName('link');

            // 下載頁面中使用的 CSS 文件
            Promise.all(Array.from(stylesheets).map(function(stylesheet) {
                var cssUrl = stylesheet.href;
                return fetch(cssUrl)
                    .then(response => response.text())
                    .then(cssContent => {
                        return {url: cssUrl, content: cssContent};
                    });
            })).then(function(cssFiles) {
                var cssString = cssFiles.map(cssFile => `<style>${cssFile.content}</style>`).join('\n');
                var fullHTML = `${cssString}\n${htmlContent}`;
                var blob = new Blob([fullHTML], { type: 'text/html' });

                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'page_with_css.html';
                link.click();
            });
        });
    </script>
</body>
</html>
