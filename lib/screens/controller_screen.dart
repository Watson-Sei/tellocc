import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ControllerScreen extends StatelessWidget {
  final IO.Socket socket;

  ControllerScreen(this.socket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("コントローラー"), actions: [
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () {
            socket.emit('command', 'emergency');
            Navigator.pop(context);
          },
        )
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('上昇'),
              onPressed: () {
                socket.emit('command', 'up 20');
              },
            ),
            ElevatedButton(
              child: Text('降下'),
              onPressed: () {
                socket.emit('command', 'down 20');
              },
            ),
            ElevatedButton(
              child: Text("左回転"),
              onPressed: () {
                socket.emit('command', 'ccw 30');
              },
            ),
            ElevatedButton(
              child: Text("右回転"),
              onPressed: () {
                socket.emit('command', 'cw 30');
              },
            )
          ],
        ),
      ),
    );
  }
}
