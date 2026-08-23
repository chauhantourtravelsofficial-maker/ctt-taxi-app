import 'package:flutter/material.dart';
import 'database.dart';

class ChatScreen extends StatefulWidget {
  final String chatUserPhone;
  final String chatUserName;

  const ChatScreen({super.key, required this.chatUserPhone, required this.chatUserName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgCtrl = TextEditingController();

  void sendMessage() {
    if (msgCtrl.text.trim().isEmpty) return;
    
    setState(() {
      VirtualDB.messages.add({
        'sender': VirtualDB.currentUserPhone,
        'receiver': widget.chatUserPhone,
        'msg': msgCtrl.text.trim(),
      });
      msgCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // सिर्फ इसी यूज़र के मैसेज फ़िल्टर करें
    List<Map<String, dynamic>> chatMsgs = VirtualDB.messages.where((m) => 
        (m['sender'] == VirtualDB.currentUserPhone && m['receiver'] == widget.chatUserPhone) ||
        (m['sender'] == widget.chatUserPhone && m['receiver'] == VirtualDB.currentUserPhone)
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat: ${widget.chatUserName}', style: const TextStyle(color: Colors.black)), 
        backgroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: chatMsgs.length,
              itemBuilder: (ctx, i) {
                bool isMe = chatMsgs[i]['sender'] == VirtualDB.currentUserPhone;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFDCF8C6) : Colors.white, // अपना मैसेज हरा, सामने वाले का सफ़ेद
                      borderRadius: BorderRadius.circular(15),
                      border: isMe ? null : Border.all(color: Colors.grey.shade300)
                    ),
                    child: Text(chatMsgs[i]['msg'], style: const TextStyle(fontSize: 16)),
                  ),
                );
              }
            ),
          ),
          
          // Type Message Box
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgCtrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15)
                    ),
                  )
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color(0xFFFFB100),
                  child: IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: sendMessage),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}