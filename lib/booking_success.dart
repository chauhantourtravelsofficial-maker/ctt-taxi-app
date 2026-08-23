import 'package:flutter/material.dart';
import 'dashboard.dart'; // वापस होम पर जाने के लिए

class BookingSuccessScreen extends StatelessWidget {
  final String pickup;
  final String dest;
  final int seats;

  const BookingSuccessScreen({super.key, required this.pickup, required this.dest, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text('Booking Successful!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 10),
              Text(
                'You have successfully booked $seats seat(s)\nfor your trip from $pickup to $dest.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250, height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB100), foregroundColor: Colors.black),
                  onPressed: () {
                    // वापस Dashboard पर भेज दें
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => const MainDashboard()), 
                      (route) => false
                    );
                  },
                  child: const Text('Go to Home', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}