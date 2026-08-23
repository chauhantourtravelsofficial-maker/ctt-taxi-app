import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> termsData = [
      {"title": "1. Acceptance of Terms", "desc": "By creating an account or using CTT Taxi services, you agree to follow all rules, policies, and conditions mentioned in this document."},
      {"title": "2. User Eligibility", "desc": "• Users must provide correct information during registration.\n• Users must have a valid mobile number for OTP verification.\n• Drivers must provide valid driving license, [Aadhaar Redacted], vehicle documents, and other required verification documents."},
      {"title": "3. Account Responsibility", "desc": "• Users are responsible for maintaining the privacy of their account.\n• Sharing OTP or password with others is not allowed."},
      // यहाँ आप अपनी बाकी T&C भी जोड़ सकते हैं
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Terms & Conditions', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, elevation: 1, iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: termsData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(termsData[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 5),
                      Text(termsData[index]['desc']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB100), foregroundColor: Colors.black),
                onPressed: () => Navigator.pop(context),
                child: const Text('I Agree', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}