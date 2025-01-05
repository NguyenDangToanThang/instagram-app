import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta/app/repositories/web_socket_handler.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String senderId;
  const ChatScreen({super.key, required this.receiverId, required this.senderId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketHandler webSocket;
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> messages = []; // Lưu trữ tin nhắn

  @override
  void initState() {
    super.initState();
    // Khởi tạo WebSocketHandler
    fetchToken();
  }

  Future<void> fetchToken() async {
    String? token = await storage.read(key: "accessToken");
    webSocket =
        WebSocketHandler("ws://192.168.100.10:8080/api/v1/chat");
    // Lắng nghe tin nhắn từ server
    webSocket.messages.listen((data) {
      final decodedData = jsonDecode(data);
      setState(() {
        messages.add(decodedData); // Thêm tin nhắn vào danh sách
      });
    });
  }

  @override
  void dispose() {
    webSocket.closeConnection(); // Đóng kết nối khi thoát ứng dụng
    super.dispose();
  }

  void sendMessage(String message) {
    webSocket.sendMessage(
      widget.receiverId, 
      message,
    );
    setState(() {
      messages.add({
        "senderId": widget.senderId,
        "message": message,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  title: Text(msg['message']),
                  subtitle: Text("From: ${msg['senderId']}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (text) {
                      sendMessage(text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Type your message here...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Logic gửi tin nhắn
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
