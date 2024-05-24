<?php
function communicateWithCOMPort($port, $baudRate, $dataBits, $stopBits, $parity) {
    $cmd = "mode " . $port . ": baud=" . $baudRate . " data=" . $dataBits . " stop=" . $stopBits . " parity=" . $parity;

    exec($cmd);

    $fd = dio_open("$port:", O_RDWR);
    if ($fd === false) {
        die("Failed to open COM port".$port);
    } else {
        echo "連線成功";
    }

    $bytesWritten = dio_write($fd, 'hello');

    if ($bytesWritten === false) {
        die("Failed to write data to COM port".$port);
    }

    $dataReceived = false; 

    while (!$dataReceived) { 
        $data = dio_read($fd, 21);

        if ($data !== false) {
            echo "Received data: ".$data."\n";
            $dataReceived = true; 

            if ($data != "No data received") {
                $dataArray = array('data' => $data);
                $fileContent = var_export($dataArray, true);
                file_put_contents("final_val.txt", $fileContent, LOCK_EX); 
          
                /*if (!empty($data)) {
                    
                    $api_url = 'http://'.$_SERVER['HTTP_HOST'].'/imas/public/index.php?url=Calibrations/tidy_data';
                    $api_data = array('data' => $data);
                    $ch = curl_init($api_url);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_POST, true);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($api_data));
                    $api_response = curl_exec($ch);
                    curl_close($ch);
                    var_dump( $api_response);
                }*/
            }
        } else {
            echo "No data received\n";
        }

        sleep(5);
    }

    echo "已完成資料取得\n"; // Display completion message

    dio_close($fd);
}

$final_val = communicateWithCOMPort('COM4', 19200, 8, 2, 'n');
echo $final_val;
?>
