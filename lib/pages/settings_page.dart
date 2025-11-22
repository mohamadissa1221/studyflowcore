import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../localization/strings.dart';
import '../main.dart';
import '../pages/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLang = localeNotifier.value.languageCode;
  String selectedTheme = themeNotifier.value == ThemeMode.dark ? "Dark" : "Light";
  double textSize = textSizeNotifier.value;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 1080,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),

                  const SizedBox(height: 20),

                  _title(Strings.get("settings")),

                  const SizedBox(height: 20),

                  _item(
                    Strings.get("language"),
                    DropdownButton<String>(
                      value: selectedLang,
                      items: const [
                        DropdownMenuItem(value: "en", child: Text("English")),
                        DropdownMenuItem(value: "ar", child: Text("العربية")),
                      ],
                      onChanged: (v) => setState(() => selectedLang = v!),
                    ),
                  ),

                  _item(
                    Strings.get("theme"),
                    DropdownButton<String>(
                      value: selectedTheme,
                      items: const [
                        DropdownMenuItem(value: "Light", child: Text("Light")),
                        DropdownMenuItem(value: "Dark", child: Text("Dark")),
                      ],
                      onChanged: (v) => setState(() => selectedTheme = v!),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(Strings.get("textSize")),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Slider(
                      value: textSize,
                      min: 0.8,
                      max: 1.4,
                      divisions: 6,
                      label: textSize.toStringAsFixed(1),
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => textSize = v),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _saveButton(),

                  const SizedBox(height: 15),

                  _signOut(),

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
            top: 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(bottom: 0, child: AppLogo()),
        ],
      ),
    );
  }

  Widget _title(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          txt,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
    );
  }

  Widget _item(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), child],
      ),
    );
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
          onPressed: () {
            localeNotifier.value = Locale(selectedLang);
            themeNotifier.value =
            selectedTheme == "Dark" ? ThemeMode.dark : ThemeMode.light;
            textSizeNotifier.value = textSize;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Settings Saved")),
            );
          },
          icon: const Icon(Icons.save),
          label: Text(
            Strings.get("save"),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _signOut() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
            );
          },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: Text(
            Strings.get("signout"),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
