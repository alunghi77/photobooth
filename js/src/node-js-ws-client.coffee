# https://github.com/flatiron/prompt and https://github.com/qrpike/NodeJS-CLI-Listener

WebSocket 	= require('ws')
sys 		= require("util")
exec 		= require('child_process').exec

endpoint = 'ws://192.168.1.116:1337'

st = process.openStdin()
st.setEncoding( 'utf8' );



st.addListener "data", (d) ->

	sys.print("Sending...\n")

	WebSocket = require('ws');

	ws = new WebSocket(endpoint);
	
	ws.on 'open', () ->

		ws.send(d)

	ws.on 'message', (data, flags) ->

		if data.data.text is "take_photo"

			# run camera
			exec "raspivid -o video.h264 -t 10000", (error, stdout, stderr) ->

				sys.print(stdout)

		# flags.binary will be set if a binary data is received
		# flags.masked will be set if the data was masked
		
	sys.print("Scan Barcode : ")
		
sys.print("Scan Barcode : ")
