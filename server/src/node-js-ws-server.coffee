# ws-scanner server

webSocketsServerPort = 1337
acceptDomain = 'http://sandbox.dev:10088'

# list of currently connected clients (users)
clients = [ ]

WebSocketServer = require('websocket').server
http 			= require('http')
querystring 	= require('querystring');

postRequest = (request, response, callback) ->
	
	queryData = ""
	
	if typeof callback isnt 'function'
	
		return null

	if request.method is 'POST'

		console.log "This"

server = http.createServer (request, response) ->

	#process HTTP request. Since we're writing just WebSockets server
	# we don't have to implement anything.

server.listen webSocketsServerPort, ()-> 

	console.log new Date() + "[Welcome to Photobooth] Server is listening on port " + webSocketsServerPort

# create the server
wsServer = new WebSocketServer({

	httpServer: server

})

# WebSocket server
wsServer.on "request", (request) ->

	console.log new Date() + ' Connection from origin ' + request.origin + '.'
	remoteAddress = request.remoteAddress

	# if request.origin isnt acceptDomain

	# 	console.log "Cannot connect from a different host"

	# 	return false

	connection = request.accept(null, request.origin)

	# add client to array
	index = clients.push( connection ) - 1

	console.log new Date() + ' Connection accepted.'

	# This is the most important callback for us, we'll handle
	# all messages from users here.

	connection.on "message", (message) ->

		# accept only text
		if message.type is "utf8"

			formatDate = (date) ->
				normalisedDate = new Date(date - (date.getTimezoneOffset() * 60 * 1000))
				normalisedDate.toISOString()

			d = new Date()

			# curr_secs		= d.getSeconds()
			# curr_mins		= d.getMinutes()
			# curr_hours 	= d.getHours()
			# curr_date 	= d.getDate()
			# curr_month 	= d.getMonth() + 1
			# curr_year 	= d.getFullYear()

			# process WebSocket message
			currentMsg = {}
			currentMsg["time_ago"] 		= formatDate new Date() #curr_secs + "-" + curr_mins + "-" + curr_date + "-" + curr_month + "-" + curr_year 
			currentMsg["text"] 			= message.utf8Data
			currentMsg["remoteAddress"] = remoteAddress

			if remoteAddress is "192.168.1.130"

				currentMsg["camera1"] = true

			if remoteAddress is "192.168.1.131"

				currentMsg["camera2"] = true

			if remoteAddress is "192.168.1.116"

				currentMsg["phone"] = true

			console.log currentMsg


			messageSendObj = {}
			messageSendObj["type"] = "message"
			messageSendObj["data"] = currentMsg

			# distribute current msg to current users

			for client in clients

				client.sendUTF JSON.stringify messageSendObj

	connection.on "close", (connection) ->

		# close user connection