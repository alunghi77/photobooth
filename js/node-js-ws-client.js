// Generated by CoffeeScript 1.3.3
(function() {
  var WebSocket, endpoint, st, sys;

  WebSocket = require('ws');

  sys = require("util");

  endpoint = 'ws://192.168.1.116:1337';

  st = process.openStdin();

  st.addListener("data", function(d) {
    var ws;
    sys.print("Sending...\n");
    WebSocket = require('ws');
    ws = new WebSocket(endpoint);
    ws.on('open', function() {
      return ws.send(d);
    });
    ws.on('message', function(data, flags) {
      return console.log(data);
    });
    return sys.print("Scan Barcode : ");
  });

  sys.print("Scan Barcode : ");

}).call(this);
