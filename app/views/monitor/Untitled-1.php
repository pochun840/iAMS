//處理曲線圖
var ctx = document.getElementById('myChart').getContext('2d');

var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: [<?php echo $data['x_nodal_point'];?>],
        datasets: [{
            label: '<?php echo $data['chat']['yaxis_title'];?>',
            data: [<?php echo $data['total_range'];?>],
            borderColor: 'rgba(0, 0, 255, 1)',
            borderWidth: 3
        }]
    },
    options: {
        scales: {
            y: {
                suggestedMin: <?php echo $data['y_minvalue'];?>, 
                suggestedMax: <?php echo $data['y_maxvalue'];?>, 
                title: {
                    display: true,
                    text: '<?php echo $data['chat']['yaxis_title'];?>',
                }
            },
            x:{
                title: {
                    display: true,
                    text: '<?php echo $data['chat']['xaxis_title'];?>',
                    align: 'end'
                    
                } 
            }
        },

        interaction: {
            mode: 'index',
            intersect: false
        },

        plugins: {
            zoom: {
                zoom: {
                    wheel: {
                        enabled: true,
                    },
                    pinch: {
                        enabled: true
                    },
                    mode: 'xy'
                }
            }
        }


    }
});