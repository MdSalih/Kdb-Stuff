/**
* Function takes an IPC message in string format and returns 
* a binary ArrayBuffer representation of the IPC string.
* Can generate an input string with the following code in a
* kdb process: raze string -8!<code>. eg. raze string -8!1+1
* @param {string} IPC message as a string.
* @returns {ArrayBuffer} binary reprensetation of IPC string
*/
function ipcstr2arraybuffer(str){
  var buffer = new ArrayBuffer(str.length/2);
  var bufferView = new Uint8Array(buffer);
  for(var i = 0; i < buffer.byteLength; i++){
    bufferView[i] = parseInt("0x"+str.substr(2*i,2));
  };
  return buffer;
};
