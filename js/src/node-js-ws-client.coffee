# https://github.com/flatiron/prompt and https://github.com/qrpike/NodeJS-CLI-Listener

WebSocket 	= require('ws')
sys 		= require("util")
exec 		= require('child_process').exec
Hashids 	= require('hashids')

endpoint = 'ws://192.168.1.116:1337'

st = process.openStdin()
st.setEncoding( 'utf8' );

#http://rezoner.net/how-to-send-and-receive-binary-data-over-websockets,4
# wsSendBinary = (socket, data) ->
  
# 	# Encode packet with BiSON to safe up to 50% against JSON.stringify
# 	bisonPacket = BISON.encode(data);

# 	# A tricky part is that you will get nothing sending data as-is.
# 	# Our bison string is build of chars with indexes from 0 to 255.
# 	# utf-8 uses extra byte to encode char beyond index 127 so u will end up
# 	# sending value which can be represented by one byte in two bytes.
# 	# To take advantage of binary transport we will have to convert our data
# 	# to javascript typed array. Unsigned Int 8 will do best.

# 	uint8Packet = new Uint8Array(packet.length);

# 	for i in = 0, len = bisonPacket.length; i < len; i++) {
# 		uint8Packet[i] = packet.charCodeAt(i);
# 	}

# 	# This is how sending binary data looks like with ws library
#   	socket.send(uint8Packet, {binary: true, mask: true});
# }


WebSocket = require('ws');

ws = new WebSocket(endpoint);

# ws.on 'open', () ->

# 	ws.send(d)

ws.on 'message', (data, flags) ->

	dataObj = JSON.parse data

	if dataObj.data.text is "take_photo"

		hashids = new Hashids('yweqwueqwi qwoeoqweuq uoq', 8)

		hash = hashids.encrypt(1)

		# run camera
		exec "sudo raspistill -o ./photos/image_#{hash}.jpg", (error, stdout, stderr) ->

			sys.print(stdout)

			reader = new FileReader()

			# There is also readAsBinaryString method if you are not using typed arrays
			reader.readAsArrayBuffer event.data

			# As the stream finish to load we can use the results
			reader.onloadend = () ->

				view = new Uint8Array(this.result)

				console.log view

				# str = ""

				# for (i = 0; i < view.length; i++) {
				# 	str += String.fromCharCode(view[i])
				# }

				# message = BISON.decode(str)                   

				# console.log message

				# return message

	if dataObj.data.text is "start_video"

		# run camera
		exec "sduo raspivid -o ./videos/video.h264 -t 10000", (error, stdout, stderr) ->

			sys.print(stdout)

	# flags.binary will be set if a binary data is received
	# flags.masked will be set if the data was masked
		



# st.addListener "data", (d) ->

# 	sys.print("Sending...\n")

# 	WebSocket = require('ws');

# 	ws = new WebSocket(endpoint);
	
# 	ws.on 'open', () ->

# 		ws.send(d)

# 	ws.on 'message', (data, flags) ->

# 		dataObj = JSON.parse data

# 		if dataObj.data.text is "take_photo"

# 			hashids = new Hashids('yweqwueqwi qwoeoqweuq uoq', 8)

# 			hash = hashids.encrypt(1)

# 			# run camera
# 			exec "sudo raspistill -o ./photos/image_#{hash}.jpg", (error, stdout, stderr) ->

# 				sys.print(stdout)

# 				reader = new FileReader()

# 				# There is also readAsBinaryString method if you are not using typed arrays
#   				reader.readAsArrayBuffer(event.data)

# 				# As the stream finish to load we can use the results
# 				reader.onloadend = () ->

# 					# Another tricky part. Before you can read the results you have to create
# 					# a view for our typed array
# 					view = new Uint8Array(this.result)

# 					# Now let's decode array containing char indexes to normal ol' utf8 string
# 					str = "";
					
# 					for(var i = 0; i < view.length; i++) {
# 						str += String.fromCharCode(view[i]);
# 					}

# 					# Our string is still BISON encoded, so last conversion needs to be done.
# 					message = BISON.decode(str);                   
					
# 					# Voilà, here comes object that we sent
#     				console.log(message)

#     				return message

#     			}


# 		if dataObj.data.text is "start_video"

# 			# run camera
# 			exec "sduo raspivid -o ./videos/video.h264 -t 10000", (error, stdout, stderr) ->

# 				sys.print(stdout)

# 		# flags.binary will be set if a binary data is received
# 		# flags.masked will be set if the data was masked
		
# 	sys.print("Scan Barcode : ")
		
# sys.print("Scan Barcode : ")
