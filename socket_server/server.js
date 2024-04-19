const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const port = 8889;

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

io.on('connection', (socket) => {
    console.log('A user connected');

    socket.on('disconnect', () => {
        console.log('User disconnected');
    });

    // SDKモード開始
    socket.on('command', () => {
        console.log('Received Command');
    })

    // ビデオストリームを有効化
    socket.on('streamon', () => {
        console.log('Received streamon');
    })

    // ビデオストリームを無効化
    socket.on('streamoff', () => {
        console.log('Received streamoff');
    })

    // 離陸
    socket.on('takeoff', () => {
        console.log('Received Takeoff');
    })

    // 着陸
    socket.on('land', () => {
        console.log('Received land');
    })

    // バッテリー残量
    socket.on('battery?', () => {
        console.log('Received battery?');
    })

    // 現在のスピード
    socket.on('speed?', () => {
        console.log('Received speed');
    })
})

server.listen(port, () => {
    console.log(`Listening on *:8889`)
});