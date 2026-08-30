import 'package:flutter/material.dart';
import 'login_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _blackScreenFade;

  @override
  void initState() {
    super.initState();
    
    // टोटल एनीमेशन टाइम 2.5 सेकंड रखा है ताकि ज़ूम इफ़ेक्ट प्रीमियम और स्मूथ लगे
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), 
    );

    // 1. फेड-इन एनीमेशन (शुरुआत में लोगो दिखने के लिए)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3, curve: Curves.easeIn)),
    );

    // 2. स्केल (ज़ूम) एनीमेशन (TweenSequence से 3 स्टेप्स में काम करेगा)
    _scaleAnimation = TweenSequence<double>([
      // स्टेप 1: पॉप-अप और बाउंस (छोटा होकर नॉर्मल साइज़ में आना)
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack)), weight: 30),
      // स्टेप 2: बीच में थोड़ी देर होल्ड करना (ताकि यूज़र लोगो देख सके)
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 40),
      // स्टेप 3: बहुत तेज़ी से पूरी स्क्रीन पर ज़ूम-इन होना
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 40.0).chain(CurveTween(curve: Curves.easeInExpo)), weight: 30),
    ]).animate(_controller);

    // 3. ब्लैक स्क्रीन फेड (ज़ूम खत्म होते-होते स्क्रीन ब्लैक हो जाएगी)
    _blackScreenFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0, curve: Curves.easeIn)),
    );

    // 4. एनीमेशन ख़त्म होते ही अगली स्क्रीन पर जाना (स्मूथ फेड ट्रांज़िशन के साथ)
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context, 
          // PageRouteBuilder का यूज़ किया है ताकि स्क्रीन झटके से ना बदले, बल्कि ब्लैक से फेड हो
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800), // मर्ज होने का टाइम
          )
        );
      }
    });

    // एनीमेशन प्ले करें
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // शुरुआत में वाइट बैकग्राउंड
      body: Stack(
        children: [
          // लोगो और उसका ज़ूम इफ़ेक्ट
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _opacityAnimation,
                  child: Transform.scale(
                    scale: _scaleAnimation.value, // यहाँ से लोगो ज़ूम होगा
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25), // तुम्हारे लोगो के गोल किनारे (Round Edges)
                      child: Image.asset(
                        'assets/new_logo1.png',
                        width: 130, // लोगो का बेस साइज़
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // ब्लैक स्क्रीन इफ़ेक्ट (जो आख़िर में ज़ूम के साथ वाइट से ब्लैक में मर्ज होगा)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(_blackScreenFade.value),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}