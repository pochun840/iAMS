

function undo(){
    var chicked_id = localStorage.getItem('chicked_id');
    console.log(chicked_id);
    if(chicked_id){
        $.ajax({
            url: "?url=Calibrations/del_info",
            method: "POST",
            data:{ 
                chicked_id: chicked_id

            },
            success: function(response) {
                console.log( response);
                alert(response);
            },
            error: function(xhr, status, error) {
                
            }
        });    
    }

}


function reset(){
    //搜尋區塊
    document.getElementById('datainfo').style.display = 'none';
    
    //曲線圖區塊
    document.getElementById('chart_block').style.display = 'none';
    
}

function html_download() {
    var fileName3 = document.getElementById('fileName3').value;
    var save_type3 = document.getElementById('Save-as3').value;

    var chartDataURL = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });


    if (save_type3 === "html") {
 
        document.getElementById('mychart').style.marginLeft  = "auto";
        document.getElementById('mychart').style.marginRight = "auto";

        var images = document.getElementsByTagName('img');
        var baseUrl = window.location.origin;

        var imagesHTML = Array.from(images)
            .map(image => {
                var src = image.src.startsWith(baseUrl) ? image.src : baseUrl + image.src;
                return `<img src="${src}" alt="${image.alt}">`;
            })
            .join('\n');
            


        var stylesheets = document.getElementsByTagName('link');
        var cssString = Array.from(stylesheets)
            .map(stylesheet => `<link rel="stylesheet" href="${stylesheet.href}">`)
            .join('\n');
        var newContent = ["<head>"];

        Array.from(stylesheets).forEach(function(stylesheet) {
            newContent.push(`<link rel="stylesheet" href="${stylesheet.href}">`);
        });

        newContent.push("</head><body>");
        newContent.push(document.documentElement.innerHTML);

        newContent.push("</body>");
        var blob = new Blob([newContent.join('\n')], { type: 'text/html' });
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download =  fileName3 + '.html';
        link.click();
             
    }else if(save_type3 === "xml") {
        // 下載 XML 檔案
        fetch('/imas/public/index.php?url=Calibrations/get_xml')
            .then(response => response.text())
            .then(xmlData => {
                var blob = new Blob([xmlData], { type: 'text/xml' });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = fileName3 + '.xml';
                link.click();
            })
            .catch(error => {
                //console.error('获取 XML 数据时出错:', error);
            });
    }else if(save_type3 === "csv") {
        var job_id = getCookie('job_id');
        if (job_id) {
            $.ajax({
                type: "POST",
                data: { job_id: job_id },
                xhrFields: {
                    responseType: 'blob'
                },
                url: '?url=Calibrations/csv_download',
                success: function (response) {
                    var filename = fileName3 + '.csv';
                    var blob = new Blob([response], { type: 'text/csv' });
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.setAttribute('download', filename);
    
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                },
                error: function (error) {
                    //console.error('下载 CSV 数据时出错:', error);
                    //alert('下载 CSV 数据时出错，请稍后重试');
                }
            });
        }else{
            //alert('未找到有效的 job_id，请检查您的设置。');
        }


    }else if(save_type3 === "jpg"){
        downloadChartAsImage(chartDataURL, fileName3, 'jpg');

    }else {
        //console.log("不支持的保存類型.");
    }
}

// 將 Data URI 轉換為 Blob 物件的輔助函式
function dataURItoBlob(dataURI) {
    var byteString = atob(dataURI.split(',')[1]);
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
    var ab = new ArrayBuffer(byteString.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ab], { type: mimeString });
}



function downloadChartAsImage(chartDataURL, fileName, format) {
 
    var blob = dataURLToBlob(chartDataURL);
    var link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = fileName + '.' + format;
    link.click();
}

function dataURLToBlob(dataURL) {
    var arr = dataURL.split(','),
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]),
        n = bstr.length,
        u8arr = new Uint8Array(n);

    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }

    return new Blob([u8arr], { type: mime });
}

function calljoball(){
    document.getElementById("get_joball").style.display = "block";
}


function JobCheckbox()
{
    //取得 job被checked的值
    var checked_jobid = document.querySelectorAll('input[type="checkbox"][name="jobid"]:checked');
    var checkedjobidarr = [];
    checked_jobid.forEach(function(checkbox) {
        checkedjobidarr.push(checkbox.value);
    });

    //checkedjobidarr 不等於空值 要取得對應的seq_id
    if(checkedjobidarr != '' ) {
        $.ajax({
            type: "POST",
            data: {job_id: checkedjobidarr},
            url: '?url=Calibrations/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Calibrations';

                } else {
                    var seqListElement = document.getElementById('Seq-list');
                    seqListElement.style.display = 'block';
                    document.getElementById("Seq-list").innerHTML = response;
                }
            },
            error: function(error) {
            }
        }).fail(function () {
        });

    }

}

function JobCheckbox_seq(){

    //取得 job被checked的值
    var checked_jobid = document.querySelectorAll('input[type="checkbox"][name="jobid"]:checked');
    var checkedjobidarr = [];
    checked_jobid.forEach(function(checkbox) {
        checkedjobidarr.push(checkbox.value);
    });

    //取得 seq被checked的值
    var checked_seqid = document.querySelectorAll('input[type="checkbox"][name="seqid"]:checked');
    var checkedseqidarr = [];
    checked_seqid.forEach(function(checkbox) {
        checkedseqidarr.push(checkbox.value);
    });

    //checkedjobidarr &&  checkedseqidarr  不等於空值 要取得對應的task_id
    if(checkedjobidarr != '' && checkedseqidarr  != ''){
         $.ajax({
            type: "POST",
            data: {job_id: checkedjobidarr,seq_id: checkedseqidarr},
            url: '?url=Calibrations/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Calibrations';

                } else {
                    var taskListElement = document.getElementById('Task-list');
                    taskListElement.style.display = 'block';
                    document.getElementById("Task-list").innerHTML = response;
                }
            },
            error: function(error) {
            }
        }).fail(function () {
        });


    }
}


//test connect
function Connect() {
    $.ajax({
        url: 'http://192.168.0.152/imas/api/serial_api.php',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log('Response received:', response);
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
        }
    })
    .then(data => {
        console.log('Data received:', data);
        alert(JSON.stringify(data));

        $.ajax({
            url: '?url=Calibrations/tidy_data',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('API response:', response);
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', error);
            }
        });
    })
    .catch(error => {
        //console.error('Error:', error);
    });
}

function getCookie(cookieName) {
    var cookies = document.cookie.split(';');
    
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].trim(); 
        if (cookie.startsWith(cookieName + '=')) {
            return cookie.substring(cookieName.length + 1); 
        }
    }
    return '';
}

/*function waitForECharts() {
    return new Promise(function(resolve, reject) {
  
        if (typeof myChart !== 'undefined') {

            myChart.on('finished', function() {
                resolve();
            });
        } else {
            // 如果 myChart 未定义，等待一段时间再尝试
            setTimeout(waitForECharts, 1000); // 等待 1 秒钟再检查
        }
    });
}*/