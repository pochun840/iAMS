
if(job_singal == 1 && seq_sinal == 0 && ct_seq_id < total_seq ){
    if(data.fasten_status == 4 ){
        document.getElementById('tightening_status').innerHTML = 'OK';
        document.getElementById('step'+(task_id-1)).style.backgroundColor = 'green';
        document.getElementById('step'+(task_id-1)).style.borderColor = 'green';
        document.getElementById('tightening_status').style.backgroundColor = 'green';
        document.getElementById('tightening_status_div').style.backgroundColor = 'reen';
        current_circle.classList.add('finished');

        /*document.getElementById('VirtualMessage').style.display = 'block';
        setTimeout(function() {
            document.getElementById('VirtualMessage').style.display = 'none';
        }, 5000);*/
    }

}


 if(data.fasten_status == 4 ){
                                            document.getElementById('tightening_status').innerHTML = 'OK';
                                            document.getElementById('step'+(task_id-1)).style.backgroundColor = 'green';
                                            document.getElementById('step'+(task_id-1)).style.borderColor = 'green';
                                            document.getElementById('tightening_status').style.backgroundColor = 'green';
                                            document.getElementById('tightening_status_div').style.backgroundColor = 'reen';
                                            current_circle.classList.add('finished');

                                            /*document.getElementById('VirtualMessage').style.display = 'block';
                                            setTimeout(function() {
                                                document.getElementById('VirtualMessage').style.display = 'none';
                                            }, 5000);*/
                                        }

                                        if(data.fasten_status == 5 ){
                                            document.getElementById('tightening_status').innerHTML = 'OK-SEQ';
                                            document.getElementById('step'+(task_id-1)).style.backgroundColor = '#FFCC00';
                                            document.getElementById('step'+(task_id-1)).style.borderColor = '#FFCC00';
                                            document.getElementById('tightening_status').style.backgroundColor = '#FFCC00';
                                            document.getElementById('tightening_status_div').style.backgroundColor = '#FFCC00';
                                            current_circle.classList.add('finished_seq');
                                            //initializeMessageAutoClose();

                                            /*document.getElementById('VirtualMessage').style.display = 'block';
                                            setTimeout(function() {
                                                document.getElementById('VirtualMessage').style.display = 'none';
                                            }, 5000);*/
                                        }

                                        if(data.fasten_status == 6 ){
                                            document.getElementById('tightening_status').innerHTML = 'OK-JOB';
                                            document.getElementById('step'+(task_id-1)).style.backgroundColor = '#FFCC00';
                                            document.getElementById('step'+(task_id-1)).style.borderColor = '#FFCC00';
                                            document.getElementById('tightening_status').style.backgroundColor = '#FFCC00';
                                            document.getElementById('tightening_status_div').style.backgroundColor = '#FFCC00';
                                            current_circle.classList.add('finished_job');
                                            //initializeMessageAutoClose();

                                            /*document.getElementById('VirtualMessage').style.display = 'block';
                                            setTimeout(function() {
                                                document.getElementById('VirtualMessage').style.display = 'none';
                                            }, 5000);*/
                                        }
                                        