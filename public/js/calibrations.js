function reset(){
    //搜尋區塊
    document.getElementById('datainfo').style.display = 'none';
    
    //曲線圖區塊
    document.getElementById('chart_block').style.display = 'none';
    
}

//下載CSV檔案 
function csv_download(){
    //檔名
    var fileName1= document.getElementById('fileName1').value;
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

    var header ='id,operator,torque,unit,max_torque,min_torque,avg_torque,high_percent,low_percent,customize,datatime';
    data.unshift(header.split(','));

    var csvContent = "data:text/csv;charset=utf-8," 
                     + data.map(row => row.join(",")).join("\n");

    var encodedUri = encodeURI(csvContent);
    var link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", fileName1 + ".csv");
    document.body.appendChild(link); 
    link.click(); 

  
} 





