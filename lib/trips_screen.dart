import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  // यह फंक्शन हर ट्रिप पर क्लिक करने पर पॉप-अप मैसेज दिखाएगा (Google Play Console के लिए सेफ)
  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trip details coming soon in the next update!'),
        backgroundColor: Color(0xFFDAA520), // तुम्हारी थीम का गोल्डन कलर
        behavior: SnackBarBehavior.floating, // मैसेज थोड़ा ऊपर तैरता हुआ आएगा, जो अच्छा लगता है
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // क्लीन वाइट बैकग्राउंड
      appBar: AppBar(
        title: const Text('My Trips', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), 
        backgroundColor: Colors.white,
        elevation: 1, // हल्का सा शैडो
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          // पहली ट्रिप (Completed)
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // गोल किनारे (Round edges)
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), 
                  blurRadius: 10, 
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.directions_car, color: Color(0xFFDAA520)), // गोल्डन आइकॉन
              ),
              title: const Text('Kashipur to Delhi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              subtitle: const Text('Completed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () => _showComingSoon(context), // क्लिक करने पर मैसेज
            ),
          ),

          // दूसरी ट्रिप (Upcoming)
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), 
                  blurRadius: 10, 
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.directions_car, color: Color(0xFFDAA520)),
              ),
              title: const Text('Delhi to Dehradun', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              subtitle: const Text('Upcoming', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () => _showComingSoon(context), // क्लिक करने पर मैसेज
            ),
          ),
        ],
      ),
    );
  }
}