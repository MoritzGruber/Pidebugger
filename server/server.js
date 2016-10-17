var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.use('/', express.static(__dirname + '/public'));
app.use('/node_modules', express.static(__dirname + '/node_modules'));
http.listen(3000, function () {
    console.log('listening on *:3000');
});
console.log('Simple server to test the socket connection, listin on /'/'socket');

//get called if clint connects via socket.io to our ip
io.on('connection', function (socket) {
    socket.on('set', function (pinNumber, value) {
        console.log('pinNumber: '+pinNumber+' value: ' +value);
    });

    console.log('a client joined');
    socket.on('disconnect', function () {
        console.log('a client left')
    });
});

