# https://github.com/flatiron/prompt and https://github.com/qrpike/NodeJS-CLI-Listener

WebSocket 	= require('ws')
sys 		= require("util")
exec 		= require('child_process').exec
Hashids 	= require('hashids')



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

		dataObj = JSON.parse data

		if dataObj.data.text is "take_photo"

			hashids = new Hashids('yweqwueqwi qwoeoqweuq uoq', 8)

			hash = hashids.encrypt(1)

			# run camera
			exec "sudo raspistill -o ./photos/image_#{hash}.jpg", (error, stdout, stderr) ->

				sys.print(stdout)

		if dataObj.data.text is "start_video"

			# run camera
			exec "sduo raspivid -o ./videos/video.h264 -t 10000", (error, stdout, stderr) ->

				sys.print(stdout)

		# flags.binary will be set if a binary data is received
		# flags.masked will be set if the data was masked
		
	sys.print("Scan Barcode : ")
		
sys.print("Scan Barcode : ")
