
document.addEventListener('DOMContentLoaded', function() {
    // 等待DOM完全加載
    var datainfo = document.getElementById('datainfo');
    if (datainfo) {
        datainfo.addEventListener('click', function(event) {
            var target = event.target.closest('tr');
            if (target) {
                var id = target.getAttribute('data-id');
                localStorage.setItem('chicked_id', id ); 
                
            }
        });
    } else {
        //console.error('Unable to find element with ID "datainfo"');
    }
});

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
        backgroundColor: '#fff' // 背景為白色
    });


    if (save_type3 === "html") {
        
        var today = new Date();
        var day = String(today.getDate()).padStart(2, '0');
        var month = String(today.getMonth() + 1).padStart(2, '0'); 
        var year = today.getFullYear();

        today = year + month + day;
    


    } else if (save_type3 === "xml") {
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
                console.error('获取 XML 数据时出错:', error);
            });
    } else if (save_type3 === "csv") {
        var table = document.getElementById('datainfo'); 
        var data = []; 
        for (var i = 0; i < table.rows.length; i++) {
            var row = table.rows[i]; 
            var rowData = []; 
           
            for (var j = 0; j < row.cells.length; j++) {
                rowData.push(row.cells[j].innerText); 
            }
    
            data.push(rowData); 
        }

    
        var header ='id,datatime,operator,toolsn,torque,unit,max_torque,min_torque,avg_torque,high_percent,low_percent,customize';
        data.unshift(header.split(','));

        var csvContent = "data:text/csv;charset=utf-8," + data.map(row => row.join(",")).join("\n");

        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", fileName1 + ".csv");
        document.body.appendChild(link); 
        link.click(); 

    } else if(save_type3 === "jpg"){
        downloadChartAsImage(chartDataURL, fileName3, 'jpg');

    }else if(save_type3 === "png"){
        downloadChartAsImage(chartDataURL, fileName3, 'png');
    }else {
        console.log("不支持的保存類型.");
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


function JobCheckbox() {
    var checked_jobid = document.querySelector('input[type="checkbox"][name="jobid"]:checked');
    
      // 取消其他复选框的选中状态
      checkboxes.forEach(function(checkbox) {
        if (checkbox !== clickedCheckbox) {
            checkbox.checked = false;
        }
    });
    

    // 如果有选中的复选框
    if (checked_jobid !== null) {
        checkedjobidarr.push(checked_jobid.value);
        $.ajax({
            type: "POST",
            data: { job_id: checkedjobidarr },
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
                console.error('Error:', error);
            }
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
            url: 'http://192.168.0.152/imas/public/index.php?url=Calibrations/tidy_data',
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
