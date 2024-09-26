const SerialPort = require('serialport');
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

        await portInstance.open();
        response.success = true;
        response.message = "成功連接";

        // 向 COM 端口写入数据
        const dataToWrite = Buffer.from('hello');
        await portInstance.write(dataToWrite);

        // 从 COM 端口读取数据
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

                // 调用 API 并获取响应
                // const apiResponse = await callApi("http://192.168.0.161/imasdev/public/index.php?url=Calibrations/tidy_data");

                // 如果需要处理 API 响应，请取消注释
                // if (apiResponse.success) {
                //     response.api_response = apiResponse;
                // } else {
                //     response.success = false;
                //     response.message = "数据已接收，但 API 调用失败";
                // }

                dataReceived = true;
            } else {
                attempts++;
            }

            // 检查执行时间（以毫秒为单位）
            if (Date.now() - startTime >= 100000) {
                response.success = false;
                response.message = "执行超过 100 秒，终止操作";
                break;
            }
        }

        if (!dataReceived) {
            response.success = false;
            response.message = "未能从 COM 端口接收到数据";
        }

        await portInstance.close();

        if (forceClose) {
            response.message += ` COM 端口 ${port} 已被强制关闭。`;
        }

    } catch (error) {
        response.success = false;
        response.message = `无法打开 COM 端口 ${port}: ${error.message}`;
    }

    return response;
}

async function readFromPort(portInstance) {
    return new Promise((resolve) => {
        const parser = portInstance.pipe(new SerialPort.parsers.Readline({ delimiter: '\n' }));
        parser.once('data', (data) => {
            resolve(data);
        });

        // 设置读取数据的超时
        setTimeout(() => {
            resolve(null);
        }, 2000); // 等待 2 秒读取数据
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
            message: 'API 调用失败',
        };
    }
}

// 使用示例
const url = "http://192.168.0.161/imasdev/public/index.php?url=Calibrations/tidy_data";
connectComPort('COM4', 19200, 8, 2, 'none', true).then(console.log);
