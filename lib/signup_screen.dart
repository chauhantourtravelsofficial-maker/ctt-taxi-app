import 'package:flutter/material.dart';
import 'database.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  void handleSignup() {
    if (nameCtrl.text.isEmpty || phoneCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are required!'), backgroundColor: Colors.red));
      return;
    }

    // डेटाबेस में सेव करें
    VirtualDB.users.add({
      'name': nameCtrl.text,
      'phone': phoneCtrl.text,
      'password': passCtrl.text
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Created Successfully!'), backgroundColor: Colors.green));
    
    // वापस लॉगिन पर भेजें
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person))),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone))),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)), obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: handleSignup, child: const Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}