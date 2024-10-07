const { SerialPort } = require('serialport');
const fs = require('fs'); // 引入文件系统模块
const path = require('path'); // 引入路径模块

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
            dataBuffer = Buffer.concat([dataBuffer, data]); // 将新数据附加到 dataBuffer

            while (dataBuffer.length >= 21) {
                const slicedData = dataBuffer.slice(0, 21); // 取前 21 字节
                const hexData = slicedData.toString('hex'); // 转换为十六进制
                const Ans = hexData.slice(14, 14 + 10);

                const asciiData = Buffer.from(Ans, 'hex').toString('ascii');
                console.log("數據的十六進制表示:", hexData);
                console.log("轉換為 ASCII:", asciiData);

                if (asciiData) {
                    writeToFile(asciiData); // 写入文件
                }

                dataBuffer = dataBuffer.slice(21); // 更新 dataBuffer，保留剩余数据
            }
        });

        portInstance.on('error', (err) => {
            console.error("串口錯誤:", err.message);
        });

    } catch (error) {
        response.success = false;
        response.message = `無法打開 COM 端口 ${port}: ${error.message}`;
        console.error(error);
    }

    return response;
}

function writeToFile(asciiData) {
    const dirPath = path.join(__dirname, '../api'); // 构建目录路径
    const filePath = path.join(dirPath, 'final_val.txt'); // 构建文件路径

    // 检查目录是否存在，如果不存在则创建
    fs.mkdir(dirPath, { recursive: true }, (err) => {
        if (err) {
            console.error("创建目录失败:", err);
            return;
        }

        // 追加写入文件
        fs.appendFile(filePath, asciiData + '\n', (err) => {
            if (err) {
                console.error("写入文件失败:", err);
            } else {
                console.log("成功写入文件:", asciiData);
            }
        });
    });
}

// 使用示例
connectComPort('COM4', 19200, 8, 2, 'none', false).then(console.log);
