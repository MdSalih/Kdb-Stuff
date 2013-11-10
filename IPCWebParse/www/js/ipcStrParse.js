function ipcstr2arraybuffer(str){
  var buffer = new ArrayBuffer(str.length/2);
  var bufferView = new Uint8Array(buffer);
  for(var i = 0; i < buffer.byteLength; i++){
    bufferView[i] = parseInt("0x"+str.substr(2*i,2));
  };
  return buffer;
};
