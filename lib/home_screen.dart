import 'package:flutter/material.dart';
import 'database.dart'; // यूज़र का नाम यहाँ से आएगा
import 'search_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController destCtrl = TextEditingController();
  
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String passengers = "1 Passenger";

  // 1. डेट पिकर (कैलेंडर)
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFFB100), // गोल्डन/येलो थीम
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // 2. टाइम पिकर (घड़ी)
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFFB100), // गोल्डन/येलो थीम
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  // 3. सर्च बटन का असली लॉजिक
  void doSearch() {
    if (pickupCtrl.text.isEmpty || destCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter pickup and destination!'), backgroundColor: Colors.red)
      );
      return;
    }
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Date and Time!'), backgroundColor: Colors.red)
      );
      return;
    }
    
    // Search बटन दबाते ही अगली स्क्रीन पर जाएंगे
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(pickup: pickupCtrl.text, dest: destCtrl.text)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // वाइट थीम
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // गोल कोनों वाला नया लोगो (असली कलर्स में)
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // एजेस गोल किये हैं
              child: Image.asset(
                'assets/new_logo1.png', 
                height: 40, 
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${VirtualDB.currentUserName}! 👋', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
                ),
                const Text(
                  'Ready for your journey?', 
                  style: TextStyle(fontSize: 12, color: Colors.grey)
                ),
              ],
            ),
          ],
        ),
        actions: [
          // नोटिफिकेशन बटन (नई स्क्रीन ओपन करेगा)
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black, size: 28), 
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const NotificationScreen())
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Card
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
                  
                  // डेट और टाइम की लाइन (Row)
                  Row(
                    children: [
                      // Date Picker Box
                      Expanded(
                        child: _buildPickerBox(
                          label: selectedDate == null 
                              ? "Date" 
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          icon: Icons.calendar_month,
                          onTap: _pickDate,
                        ),
                      ),
                      const SizedBox(width: 10),
                      
                      // Time Picker Box
                      Expanded(
                        child: _buildPickerBox(
                          label: selectedTime == null 
                              ? "Time" 
                              : selectedTime!.format(context),
                          icon: Icons.access_time,
                          onTap: _pickTime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Passengers Dropdown
                  _buildDropdown(
                    value: passengers,
                    icon: Icons.person,
                    items: ["1 Passenger", "2 Passengers", "3 Passengers", "4 Passengers"],
                    onChanged: (val) => setState(() => passengers = val!),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Search Button
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

  // इनपुट फील्ड का डिज़ाइन
  Widget _buildInput(TextEditingController controller, String hint, IconData icon, Color iconColor) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: iconColor),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  // डेट और टाइम के लिए नया क्लिक होने वाला बॉक्स
  Widget _buildPickerBox({required String label, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label, 
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // यात्रियों (Passengers) का पुराना ड्रॉपडाउन
  Widget _buildDropdown({required String value, required IconData icon, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // रीसेंट रूट्स
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

// --- नोटिफिकेशन स्क्रीन (यहाँ से नई स्क्रीन खुलेगी) ---
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Notifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_active_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text('No new notifications', style: TextStyle(fontSize: 18, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}