<!DOCTYPE html>
<html>
<head>
  <title>Web Serial API Demo</title>
</head>
<body>

<button onclick="connectSerial()">Connect</button>
<button onclick="disconnectSerial()">Disconnect</button>
<br><br>
<textarea id="serialOutput" rows="10" cols="50"></textarea>

<script>
  let serialPort;

  async function connectSerial() {
    try {
      serialPort = await navigator.serial.requestPort();
      await serialPort.open({ baudRate: 19200 });
      console.log(serialPort);
      readLoop();
    } catch (err) {
      console.error('Serial connection error:', err);
    }
  }

  function disconnectSerial() {
    if (serialPort) {
      serialPort.close();
    }
  }

  async function readLoop() {
    const reader = serialPort.readable.getReader();

    while (true) {
      try {
        const { value, done } = await reader.read();
        if (done) {
          break;
        }
        const text = new TextDecoder().decode(value);
        console.log(text);
        document.getElementById('serialOutput').value += text + '\n';
        
        // Send the received data to PHP via WebSocket
        const websocket = new WebSocket('ws://localhost:8080');
        websocket.onopen = function() {
          websocket.send(text);
        };
      } catch (err) {
        console.error('Read error:', err);
        break;
      }
    }
    reader.releaseLock();
  }
</script>

</body>
</html>
