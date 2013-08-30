// Generated by CoffeeScript 1.3.3
(function() {
  var Hashids, WebSocket, endpoint, exec, st, sys, ws;

  WebSocket = require('ws');

  sys = require("util");

  exec = require('child_process').exec;

  Hashids = require('hashids');

  endpoint = 'ws://192.168.1.116:1337';

  st = process.openStdin();

  st.setEncoding('utf8');

  WebSocket = require('ws');

  ws = new WebSocket(endpoint);

  ws.on('open', function() {
    return ws.send(d);
  });

  ws.on('message', function(data, flags) {
    var dataObj, hash, hashids;
    dataObj = JSON.parse(data);
    if (dataObj.data.text === "take_photo") {
      hashids = new Hashids('yweqwueqwi qwoeoqweuq uoq', 8);
      hash = hashids.encrypt(1);
      exec("sudo raspistill -o ./photos/image_" + hash + ".jpg", function(error, stdout, stderr) {
        var reader;
        sys.print(stdout);
        reader = new FileReader();
        reader.readAsArrayBuffer(event.data);
        return reader.onloadend = function() {
          var view;
          view = new Uint8Array(this.result);
          return console.log(view);
        };
      });
    }
    if (dataObj.data.text === "start_video") {
      return exec("sduo raspivid -o ./videos/video.h264 -t 10000", function(error, stdout, stderr) {
        return sys.print(stdout);
      });
    }
  });

}).call(this);
