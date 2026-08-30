import 'package:flutter/material.dart';
import 'database.dart';
import 'terms_conditions.dart'; 
import 'login_screen.dart'; // लॉगआउट के लिए लॉगिन स्क्रीन को इम्पोर्ट किया है

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // यह फंक्शन हर खाली बटन पर "Coming Soon" का मैसेज दिखाएगा
  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon in the next update!'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2), // मैसेज 2 सेकंड तक दिखेगा
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black), 
            onPressed: () => _showComingSoon(context), // नोटिफिकेशन आइकन पर भी मैसेज
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar & Name Card
            _buildCard(
              Row(
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 50, color: Colors.white)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(VirtualDB.currentUserName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(VirtualDB.currentUserPhone, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const Text('⭐ 4.8 Rating (20 Reviews)', style: TextStyle(color: Color(0xFFFFB100), fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Go Premium Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Icon(Icons.workspace_premium, color: Colors.amber),
                  const SizedBox(width: 10),
                  const Text('Go Premium', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                    onPressed: () => _showComingSoon(context), // अपग्रेड बटन पर भी मैसेज
                    child: const Text('Upgrade Now >', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Account Section
            const Text('Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 10),
            _buildCard(
              Column(
                children: [
                  _buildTile(Icons.person, 'Personal Information', () => _showComingSoon(context)),
                  _buildTile(Icons.language, 'Change Language', () => _showComingSoon(context)),
                  _buildTile(Icons.credit_card, 'Payment Methods', () => _showComingSoon(context)),
                  _buildTile(Icons.history, 'Ride History', () => _showComingSoon(context)),
                  _buildTile(Icons.favorite, 'Favourite Rides', () => _showComingSoon(context)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Support & Others Section
            const Text('Support & Others', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 10),
            _buildCard(
              Column(
                children: [
                  _buildTile(Icons.headset_mic, 'Help & Support', () => _showComingSoon(context)),
                  _buildTile(Icons.security, 'Safety Center', () => _showComingSoon(context)),
                  
                  // Terms & Conditions (यह असली स्क्रीन पर ले जाएगा क्योंकि यह बना हुआ है)
                  _buildTile(Icons.article, 'Terms & Conditions', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsConditionsScreen()));
                  }),
                  
                  _buildTile(Icons.info, 'About Us', () => _showComingSoon(context)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Log Out Button (यह अब काम करेगा और सीधा लॉगिन स्क्रीन पर ले जाएगा)
            SizedBox(
              width: double.infinity, height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                onPressed: () {
                  // लॉगआउट करने पर लॉगिन स्क्रीन खुल जाएगी
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }, 
                child: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
      child: child,
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(leading: Icon(icon, color: Colors.black), title: Text(title, style: const TextStyle(fontSize: 14)), trailing: const Icon(Icons.chevron_right, color: Colors.grey), onTap: onTap),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}