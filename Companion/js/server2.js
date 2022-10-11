var OscReceiver = require('osc-receiver')
  , receiver = new OscReceiver();
const { exec } = require("child_process");

receiver.bind(9337);

receiver.on('message', function() {
  // handle all messages
var address = arguments[0];
var args = Array.prototype.slice.call(arguments, 1);
var part = replaceAll(args.toString(),","," ")
console.log(arguments);
switch (address) {
	case '/script':
		var a = "C:/Users/Public/Companion/runscript.cmd " + part;
		myCmd(a)  
		return;
	case '/send':
		var a = "C:/Users/Public/Companion/send.cmd " + part ;
		myCmd(a)
		return;
	case '/ahk':
		var a = '"C:\\Program Files\\AutoHotkey\\AutoHotkey.exe"' + " " + part ;
		myCmd(a)
		return;
	case '/au3':
		var a = '"C:\\Program Files (x86)\\AutoIt3\\AutoIt3.exe"' + " " + part;
		myCmd(a)
		return;
	default:
		console.log( 'Unknown: ' + address + " " + part  + '\n') 
	}



});

function myCmd(a) {
	console.log("Command: " + a  + '\n')
	exec( a , (error, stdout, stderr) => {
		if (error) {
		console.log(`error: ${error.message}`);
		return;
		}
		if (stderr) {
		console.log(`stderr: ${stderr}`);
		return;
		}
		console.log(`${stdout}`);
	});   
	return;
}
function replaceAll(str, find, replace) {
  return str.replace(new RegExp(find, 'g'), replace);
}