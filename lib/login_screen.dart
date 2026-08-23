import 'package:flutter/material.dart';
import 'database.dart';
import 'dashboard.dart';
import 'signup_screen.dart'; // Signup स्क्रीन को यहाँ जोड़ लिया है

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  void handleLogin() {
    String ph = phoneCtrl.text.trim();
    String pwd = passCtrl.text.trim();

    if (ph.isEmpty || pwd.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone and Password are required!'), backgroundColor: Colors.red),
      );
      return;
    }

    // डेटाबेस में चेक कर रहे हैं कि यूज़र है या नहीं
    bool found = false;
    for (var user in VirtualDB.users) {
      if (user['phone'] == ph && user['password'] == pwd) {
        VirtualDB.currentUserPhone = ph;
        VirtualDB.currentUserName = user['name'];
        found = true;
        break;
      }
    }

    if (found) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful! 🎉'), backgroundColor: Colors.green),
      );
      // लॉगिन होने के बाद सीधा Dashboard पर भेज देंगे
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MainDashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Phone or Password!'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_person, size: 80, color: Color(0xFFFFB100)),
              const SizedBox(height: 20),
              const Text('Welcome to CTT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              
              // Phone Input
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 15),
              
              // Password Input
              TextField(
                controller: passCtrl,
                obscureText: true, // पासवर्ड छुपाने के लिए
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 30),
              
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB100),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: handleLogin,
                  child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 15),
              
              // Sign Up Button
              TextButton(
                onPressed: () {
                  // Signup स्क्रीन पर जाने का कोड
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                }, 
                child: const Text("New here? Sign up", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}