import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../localization/strings.dart';

import 'home_page.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscurePass = true;

  bool validateEmail(String email) {
    return email.contains("@") && email.contains(".");
  }

  bool validatePassword(String pass) {
    final hasLetter = pass.contains(RegExp(r'[A-Za-z]'));
    final hasNumber = pass.contains(RegExp(r'[0-9]'));
    return hasLetter && hasNumber && pass.length >= 6;
  }

  void tryLogin() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 1000,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.get("login"),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // EMAIL
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: Strings.get("email"),
                              prefixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor:
                              isDark ? Colors.grey.shade900 : Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return Strings.get("enter_email");
                              }
                              if (!validateEmail(value.trim())) {
                                return Strings.get("invalid_email");
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 14),

                          // PASSWORD
                          TextFormField(
                            controller: passController,
                            obscureText: obscurePass,
                            decoration: InputDecoration(
                              labelText: Strings.get("password"),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() => obscurePass = !obscurePass);
                                },
                              ),
                              filled: true,
                              fillColor:
                              isDark ? Colors.grey.shade900 : Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Strings.get("enter_password");
                              }
                              if (!validatePassword(value)) {
                                return Strings.get("weak_password");
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          Strings.get("forgot"),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  _loginButton(context),

                  const SizedBox(height: 20),

                  Text(
                    Strings.get("or"),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()),
                      );
                    },
                    child: Text(
                      Strings.get("signup"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: tryLogin,
          child: Text(
            Strings.get("login"),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
