import 'package:flutter/material.dart';

class PublishRideScreen extends StatefulWidget {
  const PublishRideScreen({super.key});

  @override
  State<PublishRideScreen> createState() => _PublishRideScreenState();
}

class _PublishRideScreenState extends State<PublishRideScreen> {
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController destCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  
  String selectedDate = "Select Date";
  String selectedTime = "10:00 AM";
  String vType = "SUV";
  String seats = "4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Publish Ride', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fill in the details to publish your ride', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
            const SizedBox(height: 20),
            
            // 1. Trip Details
            const Text('📍 1. Trip Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildCard(
              Column(
                children: [
                  _buildInput(pickupCtrl, '🟢 Enter pickup location'),
                  const SizedBox(height: 10),
                  _buildInput(destCtrl, '🔴 Enter destination'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildPickerBtn(selectedDate, Icons.calendar_month, () {})),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPickerBtn(selectedTime, Icons.access_time, () {})),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Vehicle Details
            const SizedBox(height: 20),
            const Text('🚗 2. Vehicle Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildCard(
              Row(
                children: [
                  Expanded(child: _buildDropdown(vType, ["Sedan", "SUV", "Mini"], (val) => setState(() => vType = val!))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDropdown(seats, ["1", "2", "3", "4", "5", "6"], (val) => setState(() => seats = val!))),
                ],
              ),
            ),

            // 3. Pricing
            const SizedBox(height: 20),
            const Text('₹ 3. Pricing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildCard(_buildInput(priceCtrl, 'Price per Seat', isNumber: true)),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB100),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ride Published Successfully!'), backgroundColor: Colors.green));
                },
                child: const Text('⬆️ Publish Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // आपके Flet डिज़ाइन के Helpers
  Widget _buildCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
      child: child,
    );
  }

  Widget _buildInput(TextEditingController ctrl, String hint, {bool isNumber = false}) {
    return TextField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(hintText: hint, filled: true, fillColor: const Color(0xFFF8F8F8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );
  }

  Widget _buildPickerBtn(String text, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF8F8F8), foregroundColor: Colors.black, elevation: 0),
      onPressed: onTap, icon: Icon(icon, size: 18), label: Text(text),
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(value: value, isExpanded: true, items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: onChanged),
      ),
    );
  }
}