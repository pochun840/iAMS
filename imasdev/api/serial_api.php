<?php 
function connectcomport($port, $baudRate, $dataBits, $stopBits, $parity, $forceClose = false) {
    $response = array();
    set_time_limit(0); // 取消時間限制以便測試

    // 設置 COM 端口的命令
    $cmd = "mode " . $port . ": baud=" . $baudRate . " data=" . $dataBits . " stop=" . $stopBits . " parity=" . $parity;
    exec($cmd);
    
    // 嘗試打開 COM 端口
    $fd = @dio_open("$port:", O_RDWR);
    
    if ($fd === false) {
        $error = error_get_last();
        $response['success'] = false;
        $response['message'] = "無法打開 COM 端口 " . $port . ": " . $error['message'];
        return json_encode($response);
    } 

    $response['success'] = true;
    $response['message'] = "成功連接";

    // 僅當 $fd 是有效資源時設置超時
    if (is_resource($fd)) {
        stream_set_timeout($fd, 200);

        $bytesWritten = dio_write($fd, 'hello');
        if ($bytesWritten === false) {
            $response['success'] = false;
            $response['message'] = "無法寫入數據到 COM 端口 " . $port;
        } else {
            $dataReceived = false; 
            $attempts = 0;
            $maxAttempts = 21; // 設置最大嘗試次數

            $startTime = microtime(true); // 記錄開始時間

            while (!$dataReceived && $attempts < $maxAttempts) { 
                $data = dio_read($fd, 21);
                if ($data !== false && strlen($data) > 0) {
                    $dataArray = array('data' => $data);
                    $file_path = "../api/final_val.txt";
                    
                    // 用最新數據覆蓋文件內容
                    file_put_contents($file_path, var_export($dataArray, true), LOCK_EX); 

                    // 呼叫 API 並獲取回應
                    // $apiResponse = callApi("http://192.168.0.161/imasdev/public/index.php?url=Calibrations/tidy_data");
                    // $response['api_response'] = $apiResponse;

                    // if ($apiResponse['success']) {
                    //     $response['success'] = true;
                    //     $response['message'] = "數據已接收並附加到文件，API 呼叫成功";
                    // } else {
                    //     $response['success'] = false;
                    //     $response['message'] = "數據已接收，但 API 呼叫失敗";
                    // }
                    $dataReceived = true;
                } else {
                    $attempts++;
                    sleep(1); // 暫停 1 秒再重試
                }

                // 檢查執行時間（以秒為單位）
                if ((microtime(true) - $startTime) >= 100) {
                    $response['success'] = false;
                    $response['message'] = "執行超過 100 秒，終止操作";
                    break;
                }
            }

            if (!$dataReceived) {
                $response['success'] = false;
                $response['message'] = "未能從 COM 端口接收到數據";
            }
        }
    }

    // 最後關閉 COM 端口
    if (is_resource($fd)) {
        dio_close($fd);
    }

    // 處理強制關閉
    if ($forceClose) {
        $response['message'] .= " COM 端口 " . $port . " 已被強制關閉。";
    }

    return json_encode($response);
}

function callApi($url) {
    $response = file_get_contents($url);
    if ($response === false) {
        return [
            'success' => false,
            'message' => 'API 呼叫失敗',
        ];
    } else {
        $decodedResponse = json_decode($response, true);
        return [
            'success' => true,
            'data' => $decodedResponse,
        ];
    }
}

// 根據需要調用函數並傳遞強制關閉參數

$url = "http://192.168.0.161/imasdev/public/index.php?url=Calibrations/tidy_data";

echo connectcomport('COM4', 19200, 8, 2, 'n', true); // 傳遞 true 以強制關閉
//echo  callApi($url);
?>
