import 'package:flutter/material.dart';
import 'database.dart'; // यूज़र का नाम यहाँ से आएगा
import 'search_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController destCtrl = TextEditingController();
  String selectedDate = "Today";
  String passengers = "1 Passenger";

  void doSearch() {
    if (pickupCtrl.text.isEmpty || destCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter pickup and destination!'), backgroundColor: Colors.red));
      return;
    }
    // Search बटन दबाते ही अगली स्क्रीन पर जाएंगे
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SearchResultsScreen(pickup: pickupCtrl.text, dest: destCtrl.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.local_taxi, color: Color(0xFFFFB100), size: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, ${VirtualDB.currentUserName}! 👋', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                const Text('Ready for your journey?', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Card (आपके Flet डिज़ाइन के अनुसार)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildInput(pickupCtrl, 'Leaving from', Icons.my_location, Colors.green),
                  const SizedBox(height: 10),
                  _buildInput(destCtrl, 'Going to', Icons.location_on, Colors.red),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          value: selectedDate,
                          icon: Icons.calendar_month,
                          items: ["Today", "Tomorrow"],
                          onChanged: (val) => setState(() => selectedDate = val!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdown(
                          value: passengers,
                          icon: Icons.person,
                          items: ["1 Passenger", "2 Passengers", "3 Passengers", "4 Passengers"],
                          onChanged: (val) => setState(() => passengers = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFB100),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: doSearch,
                      child: const Text('Search Ride →', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recent Routes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 10),
            _buildRecentRoute('Dehradun', 'Delhi'),
            _buildRecentRoute('Kashipur', 'Nainital'),
            _buildRecentRoute('Haldwani', 'Bareilly'),
          ],
        ),
      ),
    );
  }

  // Flet के get_input() की तरह Flutter का कस्टम विजेट
  Widget _buildInput(TextEditingController controller, String hint, IconData icon, Color iconColor) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: iconColor),
        filled: true,
        fillColor: const Color(0xFFF8F8F8), // आपका Flet वाला बैकग्राउंड कलर
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown({required String value, required IconData icon, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRoute(String from, String to) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.black),
        title: Text('🕒 $from ➔ $to', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        onTap: () {
          setState(() {
            pickupCtrl.text = from;
            destCtrl.text = to;
          });
        },
      ),
    );
  }
}