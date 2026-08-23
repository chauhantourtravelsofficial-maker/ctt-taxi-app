// database.dart
// यहाँ हम कोई UI नहीं बनाएंगे, सिर्फ डेटा रखेंगे।

class VirtualDB {
  static List<Map<String, dynamic>> users = [
    {'name': 'Mayank Chauhan', 'phone': '9876543210', 'password': 'admin'}
  ];
  static List<Map<String, dynamic>> rides = [];
  static List<Map<String, dynamic>> bookings = [];
  static List<Map<String, dynamic>> messages = [];
  
  static String currentUserPhone = '';
  static String currentUserName = '';
}