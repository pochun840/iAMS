const SerialPort = require('serialport');
const Readline = require('@serialport/parser-readline');
const fs = require('fs');
const axios = require('axios');

async function connectComPort(port, baudRate, dataBits, stopBits, parity, forceClose = false) {
    const response = {};

    try {
        const portInstance = new SerialPort({
            path: port,
            baudRate: baudRate,
            dataBits: dataBits,
            stopBits: stopBits,
            parity: parity,
            autoOpen: false,
        });

        // 檢查端口是否已被佔用
        await portInstance.open();
        response.success = true;
        response.message = "成功連接";

        // 向 COM 端口寫入數據
        const dataToWrite = Buffer.from('hello');
        await portInstance.write(dataToWrite);

        // 從 COM 端口讀取數據
        let dataReceived = false;
        let attempts = 0;
        const maxAttempts = 21;

        const startTime = Date.now();

        while (!dataReceived && attempts < maxAttempts) {
            await new Promise(resolve => setTimeout(resolve, 1000)); // 等待 1 秒

            const data = await readFromPort(portInstance);
            if (data) {
                const filePath = '../api/final_val.txt';
                fs.writeFileSync(filePath, JSON.stringify({ data }), { flag: 'w' });

                dataReceived = true;
            } else {
                attempts++;
            }

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
    }

    return response;
}

async function readFromPort(portInstance) {
            resolve(data);
        });

        setTimeout(() => {
            resolve(null);
        }, 2000);
    });
}

async function callApi(url) {
    try {
        const response = await axios.get(url);
        return {
            success: true,
            data: response.data,
        };
    } catch (error) {
        return {
            success: false,
            message: 'API 調用失敗',
        };
    }
}

// 使用示例
const url = "http://192.168.0.161/imasdev/public/index.php?url=Calibrations/tidy_data";
connectComPort('COM4', 1200, 8, 2, 'none', true).then(console.log);
