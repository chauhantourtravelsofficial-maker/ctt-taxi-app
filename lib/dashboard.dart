import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'home_screen.dart';
import 'publish_ride.dart'; // इसे Import करें
import 'trips_screen.dart';   // इसे Import करें
import 'profile_screen.dart';
import 'inbox_screen.dart';
// import 'publish_ride.dart'; // इसे हम अगले स्टेप में बनाएंगे
// import 'trips_screen.dart'; // इसे हम अगले स्टेप में बनाएंगे
// import 'inbox_screen.dart'; // इसे हम अगले स्टेप में बनाएंगे
// import 'profile_screen.dart'; // इसे हम अगले स्टेप में बनाएंगे

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  // अभी के लिए जो फाइलें नहीं बनी हैं, उनकी जगह खाली Text लगा दिया है
 final List<Widget> _screens = [
  const HomeScreen(),
  const PublishRideScreen(),
  const TripsScreen(),
  const InboxScreen(),
  const ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFFB100),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), activeIcon: Icon(Icons.add_circle), label: 'Publish'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car_outlined), activeIcon: Icon(Icons.directions_car), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}