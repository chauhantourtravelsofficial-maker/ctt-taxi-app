import 'package:flutter/material.dart';
import 'seat_selection.dart';

class RideDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> rideData;
  final String pickup;
  final String dest;

  const RideDetailsScreen({super.key, required this.rideData, required this.pickup, required this.dest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.local_taxi, color: Color(0xFFFFB100)),
            SizedBox(width: 10),
            Text('CTT TAXI', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Verified Banner
            _buildCard(
              Row(
                children: [
                  const Icon(Icons.security, color: Colors.green, size: 30),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Verified Ride • Safe & Reliable', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('All drivers are verified by CTT', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  )
                ],
              ),
              bgColor: const Color(0xFFFFF8E1),
            ),
            
            // Location Card
            _buildCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('From', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('🟢 $pickup', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Padding(padding: EdgeInsets.only(left: 8), child: Text('|', style: TextStyle(color: Colors.grey))),
                  const Text('To', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('🔴 $dest', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),

            // Grid Details
            _buildCard(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoCol('📅', 'Date', rideData['date']),
                  _infoCol('⏰', 'Time', rideData['time']),
                  _infoCol('👤', 'Seats', rideData['seats']),
                  _infoCol('🚗', 'Vehicle', rideData['vehicle']),
                ],
              ),
            ),

            // Driver Details
            _buildCard(
              Row(
                children: [
                  const Icon(Icons.account_circle, size: 50, color: Colors.grey),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rideData['driver'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('Hidden until booked', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const Text('⭐ 4.8 (12 Reviews) • ✔️ Verified', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Amenities
            _buildCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ride Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('❄️ AC'), Text('🎵 Music'), Text('🔋 Charging'), Text('💼 Luggage'),
                    ],
                  )
                ],
              ),
            ),

            // Policy
            _buildCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ride Policy', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('✔️ Free cancellation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('Up to 2 hrs before', style: TextStyle(fontSize: 10, color: Colors.grey))]),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('✔️ No extra charges', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('Transparent pricing', style: TextStyle(fontSize: 10, color: Colors.grey))]),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Bar (Price & Book Button)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₹${rideData['price']}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('per seat', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB100), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: () {
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => SeatSelectionScreen(rideData: rideData, pickup: pickup, dest: dest))
  );
},
              child: const Text('Book This Ride', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Widget child, {Color bgColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
      child: child,
    );
  }

  Widget _infoCol(String emoji, String title, String val) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}