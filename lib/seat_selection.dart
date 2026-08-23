import 'package:flutter/material.dart';
import 'database.dart';
import 'booking_success.dart'; // इसे हम अगले स्टेप में बनाएंगे

class SeatSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> rideData;
  final String pickup;
  final String dest;

  const SeatSelectionScreen({super.key, required this.rideData, required this.pickup, required this.dest});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int selectedSeats = 1;
  late int basePrice;
  late int totalPrice;

  @override
  void initState() {
    super.initState();
    // प्राइस को नंबर में बदलना (ताकि गुणा कर सकें)
    basePrice = int.tryParse(widget.rideData['price'].toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    totalPrice = basePrice;
  }

  void confirmBooking() {
    // वर्चुअल डेटाबेस में बुकिंग सेव कर रहे हैं
    VirtualDB.bookings.add({
      'ride': widget.rideData,
      'pass_name': VirtualDB.currentUserName,
      'pass_phone': VirtualDB.currentUserPhone,
      'seats': selectedSeats
    });

    // सक्सेस स्क्रीन पर भेजें
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => BookingSuccessScreen(pickup: widget.pickup, dest: widget.dest, seats: selectedSeats))
    );
  }

  @override
  Widget build(BuildContext context) {
    int maxSeats = int.tryParse(widget.rideData['seats'].toString()) ?? 4;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Select Seats', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, elevation: 1, iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Route Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📍 ${widget.pickup} ➔ ${widget.dest}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text('📅 ${widget.rideData['date']} | ⏰ ${widget.rideData['time']}', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            
            // Seat Selection Box
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const Text('How many seats do you need?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedSeats,
                        isExpanded: true,
                        items: List.generate(maxSeats, (index) => DropdownMenuItem(value: index + 1, child: Text('${index + 1} Seat${index == 0 ? '' : 's'}'))),
                        onChanged: (val) {
                          setState(() {
                            selectedSeats = val!;
                            totalPrice = basePrice * selectedSeats;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text('Total Fare: ₹$totalPrice', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                ],
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB100), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: confirmBooking,
                child: const Text('Confirm Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}