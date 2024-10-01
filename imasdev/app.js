const { SerialPort } = require('serialport');
const fs = require('fs'); // 引入文件系統模塊
const path = require('path'); // 引入路徑模塊

async function writeToFile(asciiData) {
    const dirPath = path.join(__dirname, '../imasdev/api'); // 構建目錄路徑
    const filePath = path.join(dirPath, 'final_val.txt'); // 構建文件路徑

    console.log("目錄路徑:", dirPath);
    console.log("文件路徑:", filePath);

    // 檢查目錄是否存在，如果不存在則創建
    await fs.promises.mkdir(dirPath, { recursive: true });

    // 追加寫入文件
    try {
        await fs.promises.appendFile(filePath, asciiData + '\n');
        console.log("成功寫入文件:", asciiData);
    } catch (err) {
        console.error("寫入文件失敗:", err);
    }
}

async function sendToApi(asciiData) {
    const url = 'http://192.168.0.161/imasdev/public/index.php?url=Calibrations/get_val';

    const { default: fetch } = await import('node-fetch');

    try {
        const response = await fetch(url, {
            method: 'POST',
            body: asciiData,
            timeout: 5000 // 設置超時為 5 秒
        });

        if (asciiData) {
            console.log("發送的value:", asciiData);
        }

        const textResponse = await response.text(); // 獲取原始響應文本

        if (response.ok) {
            try {
                const jsonResponse = JSON.parse(textResponse); // 嘗試解析 JSON
                if (jsonResponse.success) {
                    console.log("API 執行成功:", jsonResponse.message);
                    return "API 執行成功"; 
                } else {
                    console.error("API 執行失敗:", jsonResponse.message);
                    return "API 執行失敗"; 
                }
            } catch (e) {
                console.error("響應不是有效的 JSON:", textResponse);
                return "響應錯誤"; 
            }
        } else {
            console.error(`連接失敗，狀態碼: ${response.status}`);
            return "連接失敗"; 
        }
    } catch (error) {
        console.error("發送到 API 失敗:", error);
        return "發送失敗"; 
    }
}

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

        portInstance.on('data', async (data) => {
            dataBuffer = Buffer.concat([dataBuffer, data]); // 將新數據附加到 dataBuffer
            console.log("目前的 dataBuffer 長度:", dataBuffer.length); // 輸出目前長度

            while (dataBuffer.length >= 21) {
                const slicedData = dataBuffer.slice(0, 21); // 取前 21 字節
                const hexData = slicedData.toString('hex'); // 轉換為十六進制
                const Ans = hexData.slice(14, 14 + 10);

                const asciiData = Buffer.from(Ans, 'hex').toString('ascii');
                console.log("數據的十六進制表示:", hexData);
                console.log("轉換為 ASCII:", asciiData);

                if (asciiData) {
                    console.log("準備寫入的 ASCII 數據:", asciiData);
                    await writeToFile(asciiData); // 寫入文件
                    // const apiResponse = await sendToApi(asciiData); // 發送到 API
                    // console.log("API 返回:", apiResponse);
                }

                dataBuffer = dataBuffer.slice(21); // 更新 dataBuffer，保留剩余數據
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

// 使用示例
connectComPort('COM4', 19200, 8, 2, 'none', false).then(console.log);
