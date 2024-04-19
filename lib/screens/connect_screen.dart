import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tellocc/screens/controller_screen.dart';

class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  late final IO.Socket socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    socket = IO.io(
        'http://127.0.0.1:8889',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
  }

  void setupSocketConnection() {
    socket.onConnect((_) {
      debugPrint('接続されました');
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ControllerScreen(socket)));
    });

    socket.onConnectError((data) {
      debugPrint('接続エラー: $data');
    });

    socket.onDisconnect((_) {
      debugPrint('接続が切断されました');
    });

    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tello接続")),
      body: Center(
        child: ElevatedButton(
          child: const Text("接続"),
          onPressed: () {
            if (!socket.connected) {
              setupSocketConnection();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
