import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import 'reset_password_page.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 40),
              _infoText(),
              const SizedBox(height: 20),
              _codeField(),
              const SizedBox(height: 30),
              _nextButton(context),
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

  Widget _infoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        "An email with a verification code was just sent",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _codeField() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Enter Code",
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
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
              MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
            );
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
