import 'package:flutter/material.dart';
import 'login_page.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFF1CC9AC),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF0058F0),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: const Center(child: AppLogo()),
                ),

                const SizedBox(height: 40),

                const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
