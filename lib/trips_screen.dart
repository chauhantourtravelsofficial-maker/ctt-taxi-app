import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Trips', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.directions_car), title: Text('Kashipur to Delhi'), subtitle: Text('Completed')),
          ListTile(leading: Icon(Icons.directions_car), title: Text('Delhi to Dehradun'), subtitle: Text('Upcoming')),
        ],
      ),
    );
  }
}