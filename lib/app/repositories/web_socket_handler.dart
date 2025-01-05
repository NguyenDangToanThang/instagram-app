import 'dart:convert';
import 'dart:io';
import 'package:insta/config/api_endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketHandler {
  final String url;
  // late WebSocketChannel channel;
 late WebSocket _webSocket;

  WebSocketHandler(this.url) {
    // channel = WebSocketChannel.connect(Uri.parse(url, ));
  }

  Future<void> connect() async {
    _webSocket = await WebSocket.connect(
      url,
      headers: ApiEndpoints.headers,
    );
  }

  void sendMessage(String receiverId, String message) {
    final data = {
      "receiverId": receiverId,
      "message": message,
    };
    _webSocket.add(jsonEncode(data));
    // channel.sink.add(jsonEncode(data));
  }

  // Stream get messages => channel.stream;

   Stream<dynamic> get messages => _webSocket.asBroadcastStream();

  void closeConnection() {
    // channel.sink.close();
     _webSocket.close();
  }
}
