const { SerialPort } = require('serialport');
const fs = require('fs');

async function connectComPort(port, baudRate, dataBits, stopBits, parity, forceClose = false) {
    const response = {};
    const portInstance = new SerialPort({
        path: port,
        baudRate: baudRate,
        dataBits: dataBits,
        stopBits: stopBits,
        parity: parity,
        autoOpen: false,
    });

    try {
        await portInstance.open();
        response.success = true;
        response.message = "成功連接";

        let dataBuffer = Buffer.alloc(0); // 初始化一個空的 Buffer

        portInstance.on('data', (data) => {
            // 將新數據附加到 dataBuffer
            dataBuffer = Buffer.concat([dataBuffer, data]);

            // 如果 dataBuffer 的長度大於等於 21，則進行處理
            while (dataBuffer.length >= 21) {
                const slicedData = dataBuffer.slice(0, 21); // 取前 21 字節
                const hexData = slicedData.toString('hex'); // 轉換為十六進制
                console.log("數據的十六進制表示:", hexData);
            }
        });

    } catch (error) {
        response.success = false;
        response.message = `無法打開 COM 端口 ${port}: ${error.message}`;
        console.error(error);
    }

    return response;
}

// 使用示例
connectComPort('COM4', 19200, 8, 2, 'none', false).then(console.log);
