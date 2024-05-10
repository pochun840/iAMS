
var GridConfig = {
    generate: function(width, height, left, top) {
        return {
            width: width || '90%',  
            height: height || '70%', 
            left: left || '3%',  
            top: top || '20%' 
        };
    }
};
 
function generateTooltipContent(params) {
    var tooltipContent = '';
    for (var i = 0; i < params.length; i++) {
        var seriesName = params[i].seriesName;
        var dataValue = params[i].value;
        var color = params[i].color;
        tooltipContent += '<span style="color:' + color + ';">' + seriesName + ': ' + dataValue + '</span><br>';
    }
    return tooltipContent;
}


function generateDataZoom() {
    return [
        {
            type: 'inside',
            start: 0,
            end: 100
        },
        {
            show: false,
            type: 'slider',
            start: 0,
            end: 100,
            handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
            handleSize: '80%',
            handleStyle: {
                color: '#fff',
                shadowBlur: 3,
                shadowColor: 'rgba(0, 0, 0, 0)',
                shadowOffsetX: 0,
                shadowOffsetY: 0
            }
        }
    ];
}

function generateChartInfo(data, chartIndex) {
    var prefix = 'chart' + chartIndex + '_';
    return {
        x_data_val: data[prefix + 'xcoordinate'],
        y_data_val: data[prefix + 'ycoordinate'],
        y_data_val_angle: data[prefix + 'ycoordinate_angle'] || null,
        min_val: data[prefix + 'ycoordinate_min'],
        max_val: data[prefix + 'ycoordinate_max'],
        min_val_angle: data[prefix + 'ycoordinate_min_angle'] || null,
        max_val_angle: data[prefix + 'ycoordinate_max_angle'] || null,
        xtitle: data['chart_combine']['x_title'],
        ytitle: data['chart_combine']['y_title'],
        job: data['info_final'][chartIndex - 1]['job_name']
    };
}


//combine download html
document.getElementById('downlandpdf_combine').addEventListener('click', function(event) {

    var divToRemove = document.getElementById('empty1');
    var divToRemove2 = document.getElementById('chart-title');
    
    if(divToRemove) {
        divToRemove.parentNode.removeChild(divToRemove);
    }

    if(divToRemove2) {
        divToRemove2.parentNode.removeChild(divToRemove2);
    }

    document.getElementById('unit').disabled = true;
    var disabledSelects = document.querySelectorAll('select[disabled]');
    disabledSelects.forEach(function(select) {
        select.style.color = '#808080'; 
        select.style.backgroundColor = '#f0f0f0';
    });

    var chartDataURL = myChart_combine.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff' 
    });

    var divContent = document.getElementById('combinedata').outerHTML;
    divContent = divContent.replace('force-overflow-Combine', 'photo');
    var stylesheets = document.getElementsByTagName('link');
    var cssString = Array.from(stylesheets)
        .map(stylesheet => `<link rel="stylesheet" href="${stylesheet.href}">`)
        .join('\n');
    
    var fullHTML = `<head>${cssString}</head>\n<body>${divContent}<img src="${chartDataURL}" alt="ECharts Chart" style="max-width: 100%; height: auto;"></body>`;
    var blob = new Blob([fullHTML], { type: 'text/html' });

    var link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = 'job_combine.html';
    link.click();
    history.go(0);

    event.preventDefault();
}, { passive: true });







