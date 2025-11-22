import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),

              const SizedBox(height: 40),

              _input("Password", obscure: true),
              _input("Confirm Password", obscure: true),

              const SizedBox(height: 30),

              _doneButton(context),
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

  Widget _input(String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Enter Something...",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _doneButton(BuildContext context) {
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
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Text("Done"),
        ),
      ),
    );
  }
}
