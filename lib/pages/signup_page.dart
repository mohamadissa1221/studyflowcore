import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../localization/strings.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  bool validateEmail(String email) {
    return email.contains("@") && email.contains(".");
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  void trySignUp() {
    if (!_formKey.currentState!.validate()) return;

    // السجّل الحساب هنا (Firebase / DB)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✔ Account Created Successfully!")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.get("signup"),
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
                          _input(
                            controller: firstName,
                            label: "First Name",
                            isDark: isDark,
                            validator: (v) =>
                            v!.trim().isEmpty ? "Enter first name" : null,
                          ),
                          _input(
                            controller: lastName,
                            label: "Last Name",
                            isDark: isDark,
                            validator: (v) =>
                            v!.trim().isEmpty ? "Enter last name" : null,
                          ),
                          _input(
                            controller: username,
                            label: "Username",
                            isDark: isDark,
                            validator: (v) =>
                            v!.trim().isEmpty ? "Enter username" : null,
                          ),
                          _input(
                            controller: email,
                            label: Strings.get("email"),
                            isDark: isDark,
                            validator: (v) {
                              if (v!.isEmpty) return Strings.get("enter_email");
                              if (!validateEmail(v)) {
                                return Strings.get("invalid_email");
                              }
                              return null;
                            },
                          ),

                          // PASSWORD
                          _input(
                            controller: password,
                            label: Strings.get("password"),
                            isDark: isDark,
                            obscure: obscure1,
                            suffix: IconButton(
                              icon: Icon(
                                  obscure1 ? Icons.visibility_off : Icons.visibility),
                              onPressed: () =>
                                  setState(() => obscure1 = !obscure1),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) return Strings.get("enter_password");
                              if (v.length < 6) return Strings.get("weak_password");
                              return null;
                            },
                          ),

                          // CONFIRM PASSWORD
                          _input(
                            controller: confirmPass,
                            label: Strings.get("password"),
                            isDark: isDark,
                            obscure: obscure2,
                            suffix: IconButton(
                              icon: Icon(
                                  obscure2 ? Icons.visibility_off : Icons.visibility),
                              onPressed: () =>
                                  setState(() => obscure2 = !obscure2),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) return "Confirm your password";
                              if (v != password.text) return "Passwords do not match";
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  _signUpButton(),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: Text(
                      Strings.get("login"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
              child: const Icon(Icons.arrow_back, size: 28, color: Colors.white),
            ),
          ),

          const Positioned(bottom: 0, child: AppLogo()),
        ],
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    required bool isDark,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isDark ? Colors.grey.shade900 : Colors.grey[200],
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
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
          onPressed: trySignUp,
          child: Text(
            Strings.get("signup"),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
