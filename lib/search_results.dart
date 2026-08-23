import 'package:flutter/material.dart';
import 'ride_details.dart'; // अगली फाइल जो हम बनाएंगे

class SearchResultsScreen extends StatelessWidget {
  final String pickup;
  final String dest;
  
  const SearchResultsScreen({super.key, required this.pickup, required this.dest});

  @override
  Widget build(BuildContext context) {
    // अभी UI चेक करने के लिए डमी डेटा (बाद में ये SQLite से आएगा)
    final List<Map<String, dynamic>> dummyRides = [
      {'driver': 'Ravi Kumar', 'date': '25/08/2026', 'time': '10:00 AM', 'vehicle': 'SUV', 'price': '500', 'seats': '3'},
      {'driver': 'Amit Singh', 'date': '25/08/2026', 'time': '02:30 PM', 'vehicle': 'Sedan', 'price': '450', 'seats': '1'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Available Rides', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filter options coming soon!')));
          }),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: dummyRides.length,
        itemBuilder: (context, index) {
          final ride = dummyRides[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
            child: InkWell(
              onTap: () {
                // राइड पर क्लिक करते ही डिटेल्स स्क्रीन पर जाएंगे
                Navigator.push(context, MaterialPageRoute(builder: (context) => RideDetailsScreen(rideData: ride, pickup: pickup, dest: dest)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📍 $pickup ➔ $dest', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text('🚗 Driver: ${ride['driver']}', style: const TextStyle(color: Color(0xFF001F3F), fontWeight: FontWeight.bold)),
                  Text('📅 ${ride['date']} | ⏰ ${ride['time']} | 🚗 ${ride['vehicle']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹${ride['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF2E7D32))),
                      Text('${ride['seats']} Seats Left', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}