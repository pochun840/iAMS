<?php

function connectcomport($port, $baudRate, $dataBits, $stopBits, $parity) {
    $response = array();

    $cmd = "mode " . $port . ": baud=" . $baudRate . " data=" . $dataBits . " stop=" . $stopBits . " parity=" . $parity;
    exec($cmd);
    $fd = dio_open("$port:", O_RDWR);
    
    #先判斷有無連線成功
    if($fd === false){
        $response['success'] = false;
        $response['message'] = "Failed to open COM port".$port;
    }else{
        $response['success'] = true;
        $response['message'] = "Connected successfully";
    }

    if($response['success'] == true){

        $bytesWritten = dio_write($fd, 'hello');
        if ($bytesWritten === false) {
            $response['success'] = false;
            $response['message'] = "Failed to write data to COM port".$port;
        }

        $dataReceived = false; 
        while(!$dataReceived) { 
            #開始要取得KTM扭力機的資料
            $data = dio_read($fd, 21);
            if($data !== false){
                $dataArray = array('data' => $data);
                $fileContent = var_export($dataArray, true);
                $file_path = "../api/final_val.txt";
                file_put_contents($file_path, $fileContent, LOCK_EX); 


                $response['success'] = true;
                $response['message'] = "get data";

                /*if (!empty($data)) {
                    $api_url = 'http://'.$_SERVER['HTTP_HOST'].'/imas/public/index.php?url=Calibrations/tidy_data';
                    $api_data = array('data' => $data);
                    $ch = curl_init($api_url);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_POST, true);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($api_data));
                    $api_response = curl_exec($ch);
                    curl_close($ch);
                    
                    return $api_response;
                }*/
            }
        }
    }
    
    dio_close($fd);

    return json_encode($response);
}

echo connectcomport('COM4', 19200, 8, 2, 'n');

?>
