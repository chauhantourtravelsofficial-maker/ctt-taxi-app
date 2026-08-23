import 'package:flutter/material.dart';
import 'database.dart';
import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    // जिन-जिन से बात हुई है, उनका नंबर निकालें
    Set<String> contacts = {};
    for (var m in VirtualDB.messages) {
      if (m['sender'] == VirtualDB.currentUserPhone) contacts.add(m['receiver']);
      if (m['receiver'] == VirtualDB.currentUserPhone) contacts.add(m['sender']);
    }
    List<String> contactList = contacts.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Inbox', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 1),
      backgroundColor: Colors.white,
      body: contactList.isEmpty 
          ? const Center(child: Text("No messages yet.", style: TextStyle(color: Colors.grey, fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: contactList.length,
              itemBuilder: (ctx, i) {
                String phone = contactList[i];
                // डेटाबेस से नाम ढूंढें, ना मिले तो नंबर दिखाएं
                String name = VirtualDB.users.firstWhere((u) => u['phone'] == phone, orElse: () => {'name': 'User $phone'})['name'];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Tap to view chat', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    trailing: const Icon(Icons.chat_bubble, color: Color(0xFFFFB100)),
                    onTap: () {
                      // चैट स्क्रीन खोलें और वापस आने पर लिस्ट रिफ्रेश करें
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(chatUserPhone: phone, chatUserName: name))).then((_) => setState((){}));
                    },
                  ),
                );
              }
          ),
    );
  }
}