import 'package:flutter/material.dart';
import 'database.dart';
import 'dashboard.dart';
import 'signup_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _handleLogin() {
    String ph = _mobileController.text.trim();
    String pwd = _passwordController.text.trim();

    if (ph.isEmpty || pwd.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone and Password are required!'), backgroundColor: Colors.red),
      );
      return;
    }

    // Google Play Console के लिए डमी लॉगिन 
    if (ph == '9999999999' && pwd == '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dummy Login Successful! 🎉'), backgroundColor: Colors.green),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainDashboard()),
      );
      return; 
    }

    // असली डेटाबेस चेक (VirtualDB)
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
      backgroundColor: Colors.white, // डार्क से वाइट थीम
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              
              // कोनों से गोल किया हुआ लोगो (ClipRRect)
              ClipRRect(
                borderRadius: BorderRadius.circular(25), // यहाँ से कोने गोल हुए हैं
                child: Image.asset(
                  'assets/new_logo1.png', 
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover, // यह चौकोर इमेज को बिना स्ट्रेच किए सही सेट करेगा
                ),
              ),
              const SizedBox(height: 15),
              
              // CTT TAXI टेक्स्ट
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'CTT ',
                      style: TextStyle(color: Color(0xFFDAA520), fontSize: 26, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: 'TAXI',
                      style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic), // वाइट पर ब्लैक टेक्स्ट
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Your Ride, Our Priority',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              
              const SizedBox(height: 50),

              // वेलकम टेक्स्ट
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold), // वाइट पर ब्लैक टेक्स्ट
                      ),
                      TextSpan(
                        text: 'Back',
                        style: TextStyle(color: Color(0xFFDAA520), fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login to continue your journey',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),

              // मोबाइल नंबर इनपुट
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black), // टाइप होने वाला टेक्स्ट ब्लैक
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.phone_android, color: Color(0xFFDAA520)),
                  filled: true,
                  fillColor: Colors.grey.shade50, // वाइट बैकग्राउंड पर हल्का ग्रे शेड
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300), // लाइट बॉर्डर
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFDAA520)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // पासवर्ड इनपुट
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                style: const TextStyle(color: Colors.black), // टाइप होने वाला टेक्स्ट ब्लैक
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFDAA520)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFDAA520)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xFFDAA520)),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // लॉगिन बटन
              InkWell(
                onTap: _handleLogin,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFB8860B)], 
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 25),

              // Continue with Google
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Color(0xFFDAA520)), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg',
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.black, size: 30), // वाइट पर ब्लैक आइकन
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.black, fontSize: 16), // वाइट पर ब्लैक टेक्स्ट
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // साइन अप बटन
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xFFDAA520), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}