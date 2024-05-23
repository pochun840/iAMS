function reset(){
    //搜尋區塊
    document.getElementById('datainfo').style.display = 'none';
    
    //曲線圖區塊
    document.getElementById('chart_block').style.display = 'none';
    
}

//下載CSV檔案 及TXT檔案
function file_download(){
    //檔名
    var fileName1 = document.getElementById('fileName1').value;
    //Save-as1
    var save_type = document.getElementById('Save-as1').value;

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

    if(save_type == "Excel"){

        // 如果是Excel，將資料存成CSV格式
        var header ='id,datatime,operator,toolsn,torque,unit,max_torque,min_torque,avg_torque,high_percent,low_percent,customize';
        data.unshift(header.split(','));

        var csvContent = "data:text/csv;charset=utf-8," + data.map(row => row.join(",")).join("\n");

        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", fileName1 + ".csv");
        document.body.appendChild(link); 
        link.click(); 

    } else if(save_type == "Notepad"){

        // 如果是Notepad，將資料存成txt格式
        var txtContent = data.map(row => row.join("\t")).join("\n");

        var encodedUri = encodeURI("data:text/plain;charset=utf-8," + txtContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", fileName1 + ".txt");
        document.body.appendChild(link); 
        link.click(); 
    } else {

        // 其他情況，可以進行錯誤處理或者提示
        console.log("Unsupported save type.");
    }
} 



function html_download(){
    var fileName3 = document.getElementById('fileName3').value;
    var save_type3 = document.getElementById('Save-as3').value;

    if(save_type3 =="html"){
        // 取得圖表的base64編碼
        var chartDataURL = myChart.getDataURL({
            pixelRatio: 2,
            backgroundColor: '#fff' // 背景為白色
        });

        var divContent = document.getElementById('container-fluid').outerHTML;
        var stylesheets = document.getElementsByTagName('link');
        var cssString = Array.from(stylesheets)
            .map(stylesheet => `<link rel="stylesheet" href="${stylesheet.href}">`)
            .join('\n');

  
            var fullHTML=`<!DOCTYPE html><html><head>${cssString}</head><body>${divContent}<img src="${chartDataURL}" alt="ECharts Chart" style="width:500px;height:300px;"></body></html>`;

        var blob = new Blob([fullHTML], { type: 'text/html' });
     
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = fileName3 + '.html';
        link.click();
    } 
    if(save_type3 =="xml"){
     
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
              console.error('Error fetching XML data:', error);
          });

    }
    else {
        console.log("Unsupported save type.");
    }

}


function pic_download(){

    var fileName2 = document.getElementById('fileName2').value;
    var save_type2 = document.getElementById('Save-as2').value;


    var chartDataURL = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff' // 背景為白色
    });

    if(save_type2 === "png"){
        downloadChartAsImage(chartDataURL, fileName2, 'png');
    } 
    else if(save_type2 === "jpg"){
        downloadChartAsImage(chartDataURL, fileName2, 'jpg');
    } 
    else{
        console.log("Unsupported save type.");
    }

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



