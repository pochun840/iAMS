
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/print-history-excel.css">
<link rel="stylesheet" type="text/css" href="<?php echo URLROOT; ?>css/datatables.min.css">
<!-----echart.js 測試-->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.0/dist/echarts.min.js"></script>

<!-- Include JSZip library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>

<!-- Include FileSaver.js library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>

<!-- PDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>



</head>

<body>

    <div class="excel-sheet">
        <header class="border-bottom">
            <h2><img src="./img/logo.jpg" alt="Logo"></h2>
            <p  style="font-weight: bold; font-size: 34px; padding-bottom: 5px">Fastening Statistics Report</p>

                
        </header>


        <div style="padding-top: 10px;">
            <table class="table table-bordered" style="">
                <tr>
                    <td colspan="4" style="text-align: left; padding-left: 5.7%"> Report Time : <?php echo date("Y-m-d H:i:s");?></td>
                </tr>
                <tr>
                    <td>Screw drivers : 3</td>
                    <td>Program : 3</td>
                    <td>Sample quantity : 65</td>
                    <td>Operator : Esther</td>
                </tr>
                <tr>
                    <td>Station : station1</td>
                    <td>Job quantity: 20</td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
        <label style="font-weight: bold">Lock Status Statistics</label> <label style="font-weight: bold; margin-left: 50%">Fastening Status</label>
        <div style="padding-bottom: 20px">
            <img src="img/fastening-log.png" width="60%" height="220" alt=""><img src="img/fastening-status.png" width="40%" height="165px" alt="">
        </div>
        <hr>
        <label style="font-weight: bold">Screw Time</label> <label style="font-weight: bold; margin-left: 60%">Job V.s Time</label>
        <div style="padding-bottom: 20px">
            <img src="img/screw-time.png" width="60%" height="200" alt=""><img src="img/job-time.png" width="40%" height="155px" alt="">
        </div>
        <hr>
        <label style="font-weight: bold">Station Time</label>
        <div style="padding-bottom: 20px">
            <img src="img/station-time.png" width="70%" height="200" alt="">
        </div>
        
        <label style="font-weight: bold; margin-top: 5%">NG Reason</label>
        <div style="padding-bottom: 20px">
            


        </div>
        <hr>
        <label style="font-weight: bold">NG Error v.s Operator</label>
        <div style="padding-bottom: 20px">
            <img src="img/NG v.s Operator.png" width="60%" height="200" alt="">
        </div>

            <!--<button id="downloadHtmlBtn">Download  HTML</button>-->
            <button id="download-btn">Download PDF</button>


    </div>

</body>
</html>


<script>

document.getElementById('download-btn').addEventListener('click', function() {
    const element = document.body;
    html2pdf().from(element).save('current_page.pdf');
});

document.getElementById('downloadHtmlBtn').addEventListener('click', function() {
    downloadPageAsHtmlWithImages();
});



function downloadPageAsHtmlWithImages() {
    var htmlContent = document.documentElement.outerHTML;
    var images = document.querySelectorAll('img');
    var imagePromises = [];

    images.forEach(function(image, index) {
        var imageUrl = image.src;
        var imageName = 'image_' + index + '.' + imageUrl.split('.').pop(); // Generate unique name for each image
        var imagePromise = fetch(imageUrl)
            .then(function(response) {
                return response.blob();
            })
            .then(function(blob) {
                return {
                    name: imageName,
                    blob: blob
                };
            });
        imagePromises.push(imagePromise);
    });

    Promise.all(imagePromises).then(function(imageDataArray) {
        var zip = new JSZip();
        zip.file('page.html', htmlContent); // Add HTML content to zip file

        imageDataArray.forEach(function(imageData) {
            zip.file(imageData.name, imageData.blob); // Add each image to zip file
        });

        zip.generateAsync({type:"blob"}).then(function(content) {
            saveAs(content, "page_with_images.zip"); // Download zip file
        });
    });
}
</script>
