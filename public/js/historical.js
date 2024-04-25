
//清除 資料  回到最原始的紀錄
function clear_button(){

    //預設status: ALL
    var status_val= '0';
    var queryresult = '';
    $.ajax({
        type: "POST",
        data: {
              status_val: status_val
              },
        url: '?url=Historicals/search_info_list',
        success: function(response) {
            if (response.trim() === '') {
               alert('查無資料');
               window.location.href = '?url=Historicals';
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
                url: '?url=Historicals/del_info',
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
        window.location.href = '?url=Historicals/combinedata';    
    }
}


// 下載CSV

function csv_download(){
    

    //判斷有無點擊過SEARCH 

    var data_csv = queryresult;


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
    xhr.open('POST', '?url=Historicals/csv_downland', true);
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
        url: '?url=Historicals/search_info_list',
        success: function(response) {
            if (response.trim() === '') {
               alert('查無資料');
               window.location.href = '?url=Historicals';

            } else {
                queryresult = response;

                var search_do='yes';
                document.cookie = "search_do=" + search_do + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
                //history.go(0);


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
            url: '?url=Historicals/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Historicals';

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
            url: '?url=Historicals/get_correspond_val',
            success: function(response) {
                if (response.trim() === '') {
                    alert('查無資料');
                    window.location.href = '?url=Historicals';

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

    document.cookie = "chat_modeno=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
    history.go(0);

}


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

    
    
    document.cookie = "chat_modeno=" + selectedOptions + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
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
    var content = document.getElementById('DetailInfoDisplay');

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


function nopage(){
    //0 =>不分頁 1=>分頁
    var currentValue = document.cookie.replace(/(?:(?:^|.*;\s*)nopage\s*\=\s*([^;]*).*$)|^.*$/, "$1");
    var newValue = (currentValue === "1") ? "0" : "1";
    document.cookie = "nopage=" + newValue; 

    if(newValue == "0"){
        const urlParams = new URLSearchParams(window.location.search);
        urlParams.delete('p');
        const newUrl = window.location.pathname + '?' + urlParams.toString();
        window.history.replaceState({}, '', newUrl);
        
    }
    history.go(0);
}

//回到上一頁
function goBack() {
    window.history.back();
}

//勾選上下限
function check_limit(checkbox){
     limit_val = checkbox.checked;
     if (limit_val) {
         var limit_val = '1';
     } else {
         var limit_val = '0';
     }
     document.cookie = "limit_val=" + limit_val + "; expires=" + new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString();
     history.go(0);

}


function captureScreenshot() {
    html2canvas(document.body).then(function(canvas) {
        
        var img = canvas.toDataURL('image/png');

        var win = window.open();
        win.document.write('<img src="' + img + '" width="100%">');
    });
}

var lineCookieValue = getCookie('line_style');
var low_val  = getCookie('lowval');
var high_val = getCookie('highval');
var chat_modeno = getCookie('chat_modeno');
var limit_val = getCookie('limit_val');
var chat_mode_change = getCookie('chat_mode_change');
var search_do = getCookie('search_do');


function nextinfo_png(){
    // 使用 DOM to Image 將 c3.js 圖表轉換為圖像
    domtoimage.toBlob(document.getElementById('DetailInfoDisplay'), { bgcolor: '#ffffff' })
    .then(function(blob) {
        // 創建下載連結
        var downloadLink = document.createElement("a");
        downloadLink.href = URL.createObjectURL(blob);
        downloadLink.download = "chart.png"; 

        // 模擬點擊下載連結
        downloadLink.click();
     });

}

