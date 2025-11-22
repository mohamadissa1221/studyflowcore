import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),

              const SizedBox(height: 40),

              _input(),

              const SizedBox(height: 30),

              _continueButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
          ),
          const Positioned(bottom: 0, child: AppLogo()),
        ],
      ),
    );
  }

  Widget _input() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Username Or Email"),
          TextField(
            decoration: InputDecoration(
              hintText: "PRAJESH SHAKYA",
              border: const UnderlineInputBorder(),
              suffixIcon: const Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerifyCodePage()),
            );
          },
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
