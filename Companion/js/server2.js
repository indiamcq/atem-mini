// Setup the osc-receiver server
var OscReceiver = require('osc-receiver')
  , receiver = new OscReceiver();
const { exec } = require("child_process");

receiver.bind(9337);

receiver.on('message', function() {
  // handle all messages
  // get the address
var address = arguments[0];
  // assign the OSC variables to an array
var args = Array.prototype.slice.call(arguments, 1);
  // From the array create space separated command line arguments, acceptable to all Windows programs.
var part = replaceAll(args.toString(),","," ")
  // Write all the arguments out for reference. Could be commented out if all is working well.
console.log(arguments);
  // Handle address variations or output Unknown
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
	// Run the command line for each address type
	console.log("Command: " + a )
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
	// do a replaceall instead of only replace the first occurance
  return str.replace(new RegExp(find, 'g'), replace);
}