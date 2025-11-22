import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const aboutText =
        "StudyFlow Core is your dedicated digital partner, built to help you navigate "
        "the chaos of student life and achieve academic success. We know that juggling "
        "classes, assignments, notes, and looming deadlines can be stressful. That’s why "
        "we created one simple, centralized place to organize your entire semester. "
        "By providing intuitive tools for tracking tasks, managing your schedule, and "
        "reviewing your study materials, StudyFlow Core helps you maximize efficiency "
        "without burning out. With StudyFlow Core, your mission is simple: study smarter, "
        "not just harder, so you can feel confident, stay on track, and achieve your "
        "best possible grades.";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About App',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const SingleChildScrollView(
                    child: Text(
                      aboutText,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
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
          Positioned(
            left: 20,
            top: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, size: 28),
            ),
          ),
          const Positioned(bottom: 0, child: AppLogo()),
        ],
      ),
    );
  }
}
