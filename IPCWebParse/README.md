# Parse IPC String in Javascript

## Overview
Code demo of getting an IPC string from a Kdb+ process (through web interface) and converting it to JSON via javascript IPC deserialiser [c.js](http://kx.com/q/c/c.js) from code.kx.com

## Code Highlights

### Javascript
Main javascript code is found in `www/js/ipcStrParse.js`:
```javascript
function ipcstr2arraybuffer(str){
  var buffer = new ArrayBuffer(str.length/2);
  var bufferView = new Uint8Array(buffer);
  for(var i = 0; i < buffer.byteLength; i++){
    bufferView[i] = parseInt("0x"+str.substr(2*i,2));
  };
  return buffer;
};
```
### Q
Demo Kdb+ webserver is provided in `webserver.js` - it handles returning query results in IPC format when query is of the form: `http://host:port/ipc?<query>`

## Usage

Start Kdb+ Webserver:
```
$ q webserver.q
KDB+ 3.1 2013.09.05 Copyright (C) 1993-2013 Kx Systems
l32/ 4()core 3954MB salih neptune01 127.0.1.1 PLAY 2013.12.04

         Go to: http://neptune01:53054/index.html
q)
```

Browse to output URL to execute queries & see result printed in JSON:
![Web browser demo](/demo.png)
