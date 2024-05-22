<?php
function ktmWithcomport($port, $baudRate, $dataBits, $stopBits, $parity) {
    $cmd = "mode " . $port . ": baud=" . $baudRate . " data=" . $dataBits . " stop=" . $stopBits . " parity=" . $parity;

    exec($cmd);
    
    $fd = dio_open("$port:", O_RDWR);
    if ($fd === false) {
        die("Failed to open COM port".$port);
    }
    $bytesWritten = dio_write($fd, 'hello');
    

    if ($bytesWritten === false) {
        die("Failed to write data to COM port".$port);
    }

    while (true) {
        $data = dio_read($fd, 21);
        if ($data !== false) {
            echo "Received data: ".$data."\n";
        } else {
            echo "No data received\n";
        }
        
        sleep(5);
    }
    
    dio_close($fd);
}
ktmWithcomport('COM4', 19200, 8, 2, 'n');
?>