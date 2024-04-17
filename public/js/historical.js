
var element = document.getElementById('DetailInfoDisplay');

//清除 資料  回到最原始的紀錄
function clear_button(){

    //預設status: ALL
    var status_val= '0';
    $.ajax({
        type: "POST",
        data: {
              status_val: status_val
              },
        url: '?url=Monitors/search_info_list',
        success: function(response) {
            if (response.trim() === '') {
               alert('查無資料');
               window.location.href = '?url=Monitors';
               history.go(0);

            } else {
                queryresult = response;
                document.getElementById("tbody1").innerHTML = response;
                history.go(0);
                
            }
        },
        error: function(error) {
        
        }
    }).fail(function () {

    });
    history.go(0); 
}


//刪除(可支援複選)
function delete_historyinfo() {
    var checkboxes = document.querySelectorAll('input[type="checkbox"][name="test1"]:checked');
    var checkedValues = [];

    checkboxes.forEach(function(checkbox) {
        checkedValues.push(checkbox.value);
    });

    var yes = confirm('確定是否要刪除選定的資料？');
    if (yes) {
         $.ajax({
                type: "POST",
                data: {values: checkedValues},
                url: '?url=Monitors/del_info',
                success: function(response) {
                    history.go(0);
                },
                error: function(error) {
 
                }
            }).fail(function () {
                // history.go(0);//失敗就重新整理
            });
    }else{

    }
}

// Next To Combine data(最多只能選2筆)
function NextToCombineData()
{    
    var checkboxes = document.querySelectorAll('input[type="checkbox"][name="test1"]:checked');
    var checkedValues = [];

    checkboxes.forEach(function(checkbox) {
        checkedValues.push(checkbox.value);
        
    });

    if(checkedValues.length > 2){
        alert('最多只能選取2筆鎖附記錄的資料');    
    }

    if(checkedValues.length < 2){
        alert('請選擇2筆鎖附記錄的資料');  
    }

    if(checkedValues.length == 2){
        var checkedsn = checkedValues.join(', ');
        document.cookie = "checkedsn=" + checkedsn + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
        window.location.href = '?url=Monitors/combinedata';    
    }
}


// 下載CSV
function csv_download(){

    if(queryresult === null) {
        alert("請先執行查詢結果");
        return;
    }else{
        var data_csv = queryresult;
    }
    //正則表達式
    var regex = /<td id='system_sn'>(.*?)<\/td>/g;
    var systemSns = [];
    var match;
    while ((match = regex.exec(data_csv)) !== null) {
        systemSns.push(match[1]);
    }
    var systemSnval = systemSns.join(',');
    var xhr = new XMLHttpRequest();
    document.cookie = "systemSnval=" + systemSnval + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    xhr.open('POST', '?url=Monitors/csv_downland', true);
    xhr.responseType = 'blob'; 
    xhr.onload = function() {
        if (xhr.status === 200) {
            // 創建下載連結
            var blob = new Blob([xhr.response],{ type:'text/csv'});
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = 'data.csv';
            link.click();
        }
    };
    xhr.send();
}

//搜尋
function search_info(){

    var barcodesn    = document.getElementById('barcodesn').value;
    var fromdate     = document.getElementById('FromDate').value;
    var todate       = document.getElementById('ToDate').value;
    var sname        = document.getElementById('search_name').value; //search bar

    var fromdate     = fromdate.replace("T", " ");
    var todate       = todate.replace("T", " ");
    var selectElement = document.getElementById("status");
    var status_val    = selectElement.value;


    //job 
    var checked_jobid = document.querySelectorAll('input[type="checkbox"][name="jobid"]:checked');
    var checkedjobidarr = [];
    checked_jobid.forEach(function(checkbox) {
        checkedjobidarr.push(checkbox.value);
    });
      
    //seq 
    var checked_seqid = document.querySelectorAll('input[type="checkbox"][name="seqid"]:checked');
    var checkedseqidarr = [];
    checked_seqid.forEach(function(checkbox) {
        checkedseqidarr.push(checkbox.value);
    });

    //task 
    var checked_taskid = document.querySelectorAll('input[type="checkbox"][name="taskid"]:checked');
    var checkedtaskidarr = [];
    checked_taskid.forEach(function(checkbox) {
        checkedtaskidarr.push(checkbox.value);
    });

    $.ajax({
        type: "POST",
        data: {barcodesn: barcodesn,
              fromdate: fromdate,
              todate: todate,
              status_val: status_val,
              sname: sname,
              job_id: checkedjobidarr,
              sequence_id: checkedseqidarr,
              cc_task_id:checkedtaskidarr
              },
        url: '?url=Monitors/search_info_list',
        success: function(response) {
            if (response.trim() === '') {
               alert('查無資料');
               window.location.href = '?url=Monitors';

            } else {
                queryresult = response;
                document.getElementById("tbody1").innerHTML = response;
            }
        },
        error: function(error) {
        }
    }).fail(function () {
    });

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
            url: '?url=Monitors/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Monitors';

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
            url: '?url=Monitors/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Monitors';

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


//曲線圖模式選擇
function chat_mode(selectOS) {
 
    var selectElement = document.getElementById('Chart-seting');
    var selectedOptions = [];
    // 獲取所有被選中的選項
    for (var i = 0; i < selectElement.options.length; i++) {
        var option = selectElement.options[i];
        if (option.selected) {
            selectedOptions.push(option.value);
        }
    }

    document.cookie = "chat_mode=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    history.go(0);

}

//單位選擇 
function  unit_change(selectOS){

    var selectElement = document.getElementById('Torque-Unit');
    var selectedOptions = [];
    // 獲取所有被選中的選項
    for (var i = 0; i < selectElement.options.length; i++) {
        var option = selectElement.options[i];
        if (option.selected) {
            selectedOptions.push(option.value);
        }
    }
    document.cookie = "unit_mode=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    history.go(0);
}


//角度切換
function  angle_change(selectOS){
    var selectElement = document.getElementById('Angle');
    var selectedOptions = [];
    // 獲取所有被選中的選項
    for (var i = 0; i < selectElement.options.length; i++) {
        var option = selectElement.options[i];
        if (option.selected) {
            selectedOptions.push(option.value);
        }
    }
    document.cookie = "angle_mode=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    history.go(0);
}

//擷取曲線圖 
function takeScreenshot(param) {
    var img_name = 'screenshot.'+ param;
  
    //設定要擷取的範圍
    var content = document.getElementById('myChart');
    domtoimage.toPng(content, { bgcolor: '#ffffff' }) //背景設成白色
        .then(function(dataUrl) {
            var link = document.createElement('a');
            link.href = dataUrl;
            link.download = img_name;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        })

        .catch(function(error) {
            console.error('Error while taking screenshot:', error);
        });
}


//讀取cookie 
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

var lineCookieValue = getCookie('line_style');
var low_val  = getCookie('lowval');
var high_val = getCookie('highval');

var clickCount = 0;
//選擇是否要分頁
function nopage(){

    clickCount++;
    if (clickCount % 2 === 1) {
        var nopage  = 1;
        document.cookie = "nopage=" + nopage + "; max-age=" + 60 * 60 * 24 * 7;
    } else {
       //清除cookie 
        document.cookie = "nopage=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    }
    history.go(0);

}

//有勾選上下線 
//alert(lineCookieValue);
//console.log(lineCookieValue);
if(lineCookieValue == "1"){
    var data_other = {
        label: 'High Torque',
        borderColor: 'orange'
    };
    var data_other_1 = {
        label: 'Low Torque',
        borderColor: 'orange'
    };

}else{
    var data_other = '';
}


