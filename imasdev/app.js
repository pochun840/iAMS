const { SerialPort } = require('serialport');
const { ReadlineParser } = require('@serialport/parser-readline');
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

    portInstance.setMaxListeners(20); // 增加最大監聽器數量

    try {
        await portInstance.open();
        response.success = true;
        response.message = "成功連接";

        const dataToWrite = Buffer.from('hello');
        await portInstance.write(dataToWrite);

        let dataReceived = false;
        let attempts = 0;
        const maxAttempts = 21;

        const startTime = Date.now();

        // 設置讀取數據的解析器
        const parser = portInstance.pipe(new ReadlineParser({ delimiter: '\n' }));
        
        parser.on('data', (data) => {
            console.log("接收到的數據:", data); // 顯示數據
            if (data) {
                const filePath = '../api/final_val.txt';
                fs.writeFileSync(filePath, JSON.stringify({ data }), { flag: 'w' });
                dataReceived = true;
            }
        });

        while (!dataReceived && attempts < maxAttempts) {
            await new Promise(resolve => setTimeout(resolve, 1000));
            attempts++;

            if (Date.now() - startTime >= 100000) {
                response.success = false;
                response.message = "執行超過 100 秒，終止操作";
                break;
            }
        }

        if (!dataReceived) {
            response.success = false;
            response.message = "未能從 COM 端口接收到數據";
        }

        await portInstance.close();

        if (forceClose) {
            response.message += ` COM 端口 ${port} 已被強制關閉。`;
        }

    } catch (error) {
        response.success = false;
        response.message = `無法打開 COM 端口 ${port}: ${error.message}`;
        console.error(error);
    }

    return response;
}

// 使用示例
connectComPort('COM4', 19200, 8, 2, 'none', false).then(console.log);
