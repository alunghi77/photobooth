// Generated by CoffeeScript 1.3.3
(function() {
  var WebSocket, endpoint, exec, st, sys;

  WebSocket = require('ws');

  sys = require("util");

  exec = require('child_process').exec;

  endpoint = 'ws://192.168.1.116:1337';

  st = process.openStdin();

  st.setEncoding('utf8');

  st.addListener("data", function(d) {
    var ws;
    sys.print("Sending...\n");
    WebSocket = require('ws');
    ws = new WebSocket(endpoint);
    ws.on('open', function() {
      return ws.send(d);
    });
    ws.on('message', function(data, flags) {
      if (data.data.text === "take_photo") {
        return exec(raspivid(-o(video.h264(-t(10000)))));
      }
    });
    return sys.print("Scan Barcode : ");
  });

  sys.print("Scan Barcode : ");

}).call(this);
