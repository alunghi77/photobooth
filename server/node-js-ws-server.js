// Generated by CoffeeScript 1.3.3
(function() {
  var BinaryServer, WebSocketServer, acceptDomain, clients, fs, http, postRequest, querystring, server, serverBin, webSocketsServerPort, wsServer;

  webSocketsServerPort = 1337;

  acceptDomain = 'http://sandbox.dev:10088';

  clients = [];

  WebSocketServer = require('websocket').server;

  http = require('http');

  querystring = require('querystring');

  BinaryServer = require('binaryjs').BinaryServer;

  fs = require('fs');

  postRequest = function(request, response, callback) {
    var queryData;
    queryData = "";
    if (typeof callback !== 'function') {
      return null;
    }
    if (request.method === 'POST') {
      return console.log("This");
    }
  };

  server = http.createServer(function(request, response) {});

  server.listen(webSocketsServerPort, function() {
    return console.log(new Date() + "[Welcome to Photobooth] Server is listening on port " + webSocketsServerPort);
  });

  serverBin = BinaryServer({
    httpServer: server,
    port: 9000
  });

  serverBin.on('connection', function(client) {
    return client.on('stream', function(stream, meta) {
      var file;
      file = fs.createWriteStream(meta.file);
      return stream.pipe(file);
    });
  });

  wsServer = new WebSocketServer({
    httpServer: server
  });

  wsServer.on("request", function(request) {
    var connection, index, remoteAddress;
    console.log(new Date() + ' Connection from origin ' + request.origin + '.');
    remoteAddress = request.remoteAddress;
    connection = request.accept(null, request.origin);
    index = clients.push(connection) - 1;
    console.log(new Date() + ' Connection accepted.');
    connection.on("message", function(message) {
      var client, currentMsg, d, formatDate, messageSendObj, _i, _len, _results;
      if (message.type === "utf8") {
        formatDate = function(date) {
          var normalisedDate;
          normalisedDate = new Date(date - (date.getTimezoneOffset() * 60 * 1000));
          return normalisedDate.toISOString();
        };
        d = new Date();
        currentMsg = {};
        currentMsg["time_ago"] = formatDate(new Date());
        currentMsg["text"] = message.utf8Data;
        currentMsg["remoteAddress"] = remoteAddress;
        if (remoteAddress === "192.168.1.130") {
          currentMsg["camera1"] = true;
        }
        if (remoteAddress === "192.168.1.131") {
          currentMsg["camera2"] = true;
        }
        if (remoteAddress === "192.168.1.116") {
          currentMsg["phone"] = true;
        }
        console.log(currentMsg);
        messageSendObj = {};
        messageSendObj["type"] = "message";
        messageSendObj["data"] = currentMsg;
        _results = [];
        for (_i = 0, _len = clients.length; _i < _len; _i++) {
          client = clients[_i];
          _results.push(client.sendUTF(JSON.stringify(messageSendObj)));
        }
        return _results;
      }
    });
    return connection.on("close", function(connection) {});
  });

}).call(this);
