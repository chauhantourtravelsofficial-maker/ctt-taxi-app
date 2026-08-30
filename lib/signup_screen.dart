import 'package:flutter/material.dart';
import 'database.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  void _handleSignup() {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();
    String pass = _passController.text.trim();
    String confirmPass = _confirmPassController.text.trim();

    if (name.isEmpty || phone.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!'), backgroundColor: Colors.red)
      );
      return;
    }

    if (pass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!'), backgroundColor: Colors.red)
      );
      return;
    }

    VirtualDB.users.add({
      'name': name,
      'phone': phone,
      'password': pass,
      'email': _emailController.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account Created Successfully!'), backgroundColor: Colors.green)
    );
    
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const LoginScreen())
    );
  }

  // वाइट थीम के हिसाब से इनपुट फील्ड का डिज़ाइन
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleVisibility,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscureText! : false,
        keyboardType: type,
        style: const TextStyle(color: Colors.black), // टाइप होने वाला टेक्स्ट ब्लैक
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFFDAA520)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText! ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade50, // वाइट बैकग्राउंड पर हल्का सा ग्रे शेड
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // क्लीन वाइट बैकग्राउंड
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              
              // कोनों से गोल किया हुआ लोगो (ClipRRect)
              ClipRRect(
                borderRadius: BorderRadius.circular(25), // यहाँ से कोने गोल हुए हैं
                child: Image.asset(
                  'assets/new_logo1.png', 
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover, // यह चौकोर इमेज को बिना स्ट्रेच किए सही सेट करेगा
                ),
              ),
              const SizedBox(height: 15),
              
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
              
              const SizedBox(height: 40),

              // Create Account Text
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Create ',
                        style: TextStyle(color: Color(0xFFDAA520), fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Account',
                        style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold), 
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign up to get started with CTT Taxi',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField(controller: _nameController, hint: 'Full Name', icon: Icons.person_outline),
              _buildTextField(controller: _phoneController, hint: 'Mobile Number', icon: Icons.phone_android, type: TextInputType.phone),
              _buildTextField(controller: _emailController, hint: 'Email Address', icon: Icons.email_outlined, type: TextInputType.emailAddress),
              
              _buildTextField(
                controller: _passController, 
                hint: 'Create Password', 
                icon: Icons.lock_outline, 
                isPassword: true,
                obscureText: _obscurePass,
                onToggleVisibility: () => setState(() => _obscurePass = !_obscurePass),
              ),
              
              _buildTextField(
                controller: _confirmPassController, 
                hint: 'Confirm Password', 
                icon: Icons.lock_outline, 
                isPassword: true,
                obscureText: _obscureConfirm,
                onToggleVisibility: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),

              const SizedBox(height: 15),

              // Sign Up Button
              InkWell(
                onTap: _handleSignup,
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
                        'Sign Up',
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

              // Google Button
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
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.black, size: 30),
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

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => const LoginScreen())
                      );
                    },
                    child: const Text(
                      "Login",
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