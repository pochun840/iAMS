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
        let firstOutput = true; // 標誌變數

        portInstance.on('data', (data) => {
            // 將新數據附加到 dataBuffer
            dataBuffer = Buffer.concat([dataBuffer, data]);

            // 如果 dataBuffer 的長度大於等於 21，則進行處理
            while (dataBuffer.length >= 21) {
                const slicedData = dataBuffer.slice(0, 21); // 取前 21 字節
                const hexData = slicedData.toString('hex'); // 轉換為十六進制

                const Ans = hexData.slice(14, 14 + 10);
                
                // 只在第一次輸出
                if (firstOutput) {
                    console.log("數據的十六進制表示:", hexData);
                    console.log("字元數:", hexData.length); // 顯示字元數
                    console.log("Ans:", Ans);

                    const asciiData = Buffer.from(Ans, 'hex').toString('ascii');
                    console.log("轉換為 ASCII:", asciiData);

                    // 如果 asciiData 有值，寫入文件
                    if (asciiData) {
                        writeToFile(asciiData);
                    }

                    firstOutput = false; // 設置標誌為 false
                }

                dataBuffer = dataBuffer.slice(21); // 更新 dataBuffer，保留剩餘數據
            }
        });

    } catch (error) {
        response.success = false;
        response.message = `無法打開 COM 端口 ${port}: ${error.message}`;
        console.error(error);
    }

    return response;
}

function writeToFile(asciiData) {
    const filePath = path.join(__dirname, '../api/final_val.txt'); // 构建文件路径
    fs.appendFile(filePath, asciiData + '\n', (err) => {
        if (err) {
            console.error("写入文件失败:", err);
        } else {
            console.log("成功写入文件:", asciiData);
        }
    });
}

// 使用示例
connectComPort('COM4', 19200, 8, 2, 'none', false).then(console.log);