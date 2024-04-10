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

            } else {
                queryresult = response;
                document.getElementById("tbody1").innerHTML = response;
            }
        },
        error: function(error) {
            // console.error('Error:', error); 
        }
    }).fail(function () {
        // history.go(0);
    }); 
}


//刪除(可支援複選)
function delete_historyinfo() {
    var checkboxes = document.querySelectorAll('input[type="checkbox"][name="test1"]:checked');
    var checkedValues = [];

    checkboxes.forEach(function(checkbox) {
        checkedValues.push(checkbox.value);
    });

    var yes = confirm('你確定嗎？');
    if (yes) {
         $.ajax({
                type: "POST",
                data: {values: checkedValues},
                url: '?url=Monitors/del_info',
                success: function(response) {
                    history.go(0);
                },
                error: function(error) {
                    // console.error('Error:', error); 
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


    // Show Combine data
    //document.getElementById('CombineDataDisplay').style.display = 'block';

    // Hide FasteningDisplay
    //document.getElementById('FasteningDisplay').style.display = 'none';
}


// 下載CSV
function download_csv(){

    if(queryresult === null) {
        alert("請先執行查詢結果");
        return;
    }

    // 將查詢結果傳遞給downland_csv
    var csvData = queryresult;

    var url ="?url=Monitors/downland_csv";
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.responseType = 'blob';

    xhr.onload = function() {

    if (this.status === 200) {
        var url = window.URL.createObjectURL(this.response);
        var a = document.createElement('a');
        a.href = url;
        a.download = 'results.csv';
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
    }
    };

    xhr.send('csvData=' + encodeURIComponent(csvData));
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
            // console.error('Error:', error); 
        }
    }).fail(function () {
        // history.go(0);
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
                    //alert(response);
                    var taskListElement = document.getElementById('Task-list');
                    taskListElement.style.display = 'block';
                    document.getElementById("Task-list").innerHTML = response;
                }
            },
            error: function(error) {
                // console.error('Error:', error); 
            }
        }).fail(function () {
            // history.go(0);
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
                // console.error('Error:', error); 
            }
        }).fail(function () {
            // history.go(0);
        });

    }

}

//選擇是否要分頁
function nopage(){
    
    var nopage = 'False';
    document.cookie = "nopage=" + nopage + "; max-age=" + 60 * 60 * 24 * 7;

}

