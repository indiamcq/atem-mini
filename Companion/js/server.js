var OscReceiver = require('osc-receiver')
  , receiver = new OscReceiver();
const { exec } = require("child_process");
 var autoit = "C:/Users/Public/Companion/runautoit3.cmd"
receiver.bind(9337);
 
 receiver.on('/test', function() {
	//var address = arguments[0];
	console.log( "Received: /test") 
});

receiver.on('message', function() {
  // handle all messages
	  var address = arguments[0];
	  var args = Array.prototype.slice.call(arguments, 1);
	if ( address == '/test' ) {
		if (args[0]  != null){
			console.log( args[0] )   
		}
	}
	if ( address != '/script' )  {
		if ( address != '/test' ) {
			console.log( address + " " + args[0] )   
		}	  
	} else {
		console.log( address + " " + args[0] )   
	}
	  if ( address == '/script' )  {
		  var a = "C:/Users/Public/Companion/runscript.cmd " + args[0];
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
	  }
});