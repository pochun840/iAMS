<?php

if (!empty($_SERVER["HTTP_CLIENT_IP"])){
    $ip = $_SERVER["HTTP_CLIENT_IP"];
}elseif(!empty($_SERVER["HTTP_X_FORWARDED_FOR"])){
    $ip = $_SERVER["HTTP_X_FORWARDED_FOR"];
}else{
    $ip = $_SERVER["REMOTE_ADDR"];
}

// if($ip != '::1'){ //只限本機呼叫
//     return 0;
// }

//--------------------------------------

$json = file_get_contents('php://input');

if($json){
    // file_put_contents("./test.txt", $json, FILE_APPEND);
    //var_dump($josn);die();
    $data = json_decode($json,true);
}

$light_signal = $data['light_signal'];

$IO = $data['IO'];
$TowerLightSetting = $data['TowerLightSetting'];

if( isset($_POST['t']) && $_POST['t'] == 1){
    $light_signal = 'stop';
    // file_put_contents("./test.txt", '123', FILE_APPEND);
}

if( isset($_GET['t']) && $_GET['t'] == 1){
    $light_signal = 'stop';
    // file_put_contents("./test.txt", '123', FILE_APPEND);
}

require_once '../modules/phpmodbus-master/Phpmodbus/ModbusMaster.php';
$modbus = new ModbusMaster('192.168.1.75', "TCP");

try {
    $modbus->port = 502;
    $modbus->timeout_sec = 10;

    $pins = array();
    $pins[0] = false;
    $pins[1] = false;
    $pins[2] = false;
    $pins[3] = false;
    $pins[4] = false;
    $pins[5] = false;
    $pins[6] = false;
    $pins[7] = false;
    $pins[8] = false;
    $pins[9] = false;
    $pins[10] = false;
    $pins[11] = false;

    if ($light_signal == 'ng') { // buzzer 3短音

        foreach($IO as $key => $value) {
            if (in_array('red_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[0]['red_light']);
            }
            if (in_array('green_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[0]['green_light']);
            }
            if (in_array('yellow_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[0]['yellow_light']);
            }
            if (in_array('buzzer', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[0]['buzzer']);
            }
        }

        $delay_time = intval($TowerLightSetting[0]['pulse_time']) * 1000;

        $data_true = array($pins[0], $pins[1], $pins[2], $pins[3], $pins[4], $pins[5], $pins[6], $pins[7], $pins[8], $pins[9], $pins[10], $pins[11]);
        $data_true2 = array(false, $pins[1], $pins[2], $pins[3], $pins[4], $pins[5], $pins[6], $pins[7], $pins[8], $pins[9], $pins[10], $pins[11]);
        $data_false = array(false, false, false, false, false, false, false, false, false, false, false, false);

        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true);
        usleep(80000); // 0.05s
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true2);
        usleep(80000); // 0.05s
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true);
        usleep(80000); // 0.05s
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true2);
        usleep(80000); // 0.05s
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true);
        usleep(80000); // 0.05s
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_true2);
        usleep(80000); // 0.05s

        if (($delay_time - 80000 * 6) > 0) {
            usleep($delay_time - 80000 * 6);
        } else {

        }

        $recDate = $modbus->writeMultipleCoils(0, 0, $data_false);
    }

    if ($light_signal == 'ok') { // buzzer 1秒

        foreach($IO as $key => $value) {
            if (in_array('red_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[1]['red_light']);
            }
            if (in_array('green_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[1]['green_light']);
            }
            if (in_array('yellow_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[1]['yellow_light']);
            }
            if (in_array('buzzer', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[1]['buzzer']);
            }
        }

        $delay_time = intval($TowerLightSetting[1]['pulse_time']) * 1000;

        $data_true = array($pins[1], $pins[2], $pins[3], $pins[4], $pins[5], $pins[6], $pins[7], $pins[8], $pins[9], $pins[10], $pins[11]);
        $data_false = array(false, false, false, false, false, false, false, false, false, false, false);
        $buzzer_true = array($pins[0]);
        $buzzer_false = array(false);

        if ($delay_time > 1000000) {
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_true); //buzzer start
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_true); // light start
            usleep(1000000); // 1 sec
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_false); //buzzer stop
            usleep($delay_time - 1000000);
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_false); // light stop
        } else {
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_true); //buzzer start
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_true); // light start
            usleep($delay_time);
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_false); // light stop
            usleep(1000000 - $delay_time); // 1 sec
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_false); //buzzer stop
        }
    }

    if ($light_signal == 'okall') { // buzzer 3秒

        foreach($IO as $key => $value) {
            if (in_array('red_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[2]['red_light']);
            }
            if (in_array('green_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[2]['green_light']);
            }
            if (in_array('yellow_light', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[2]['yellow_light']);
            }
            if (in_array('buzzer', $value)) {
                $pins[$value['pin_number']] = boolval($TowerLightSetting[2]['buzzer']);
            }
        }

        $delay_time = intval($TowerLightSetting[2]['pulse_time']) * 1000;

        $data_true = array($pins[0], $pins[1], $pins[2], $pins[3], $pins[4], $pins[5], $pins[6], $pins[7], $pins[8], $pins[9], $pins[10], $pins[11]);
        $data_false = array(false, false, false, false, false, false, false, false, false, false, false, false);
        $buzzer_true = array($pins[0]);
        $buzzer_false = array(false);

        if ($delay_time > 3000000) {
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_true); //buzzer start
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_true); // light start
            usleep(3000000); // 1 sec
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_false); //buzzer stop
            usleep($delay_time - 3000000);
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_false); // light stop
        } else {
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_true); //buzzer start
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_true); // light start
            usleep($delay_time);
            $recDate = $modbus->writeMultipleCoils(0, 1, $data_false); // light stop
            usleep(3000000 - $delay_time); // 1 sec
            $recDate = $modbus->writeMultipleCoils(0, 0, $buzzer_false); //buzzer stop
        }
    }

    if ($light_signal == 'stop') {
        $data_true = array(false, true, true, true, true, true, true, true, true, true, true, true);
        $data_false = array(false, false, false, false, false, false, false, false, false, false, false, false);
        $recDate = $modbus->writeMultipleCoils(0, 0, $data_false); //buzzer start
        usleep(3000);
        // $recDate = $modbus->writeMultipleCoils(0, 0, $data_true); //buzzer start
    }
} catch (Exception $e) {
    echo $modbus->status;
    exit();
}
