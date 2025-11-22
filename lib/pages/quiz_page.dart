import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/groq_service.dart';
import '../localization/strings.dart';
import '../providers/materials_provider.dart';
import '../../main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? selectedMaterial;
  String quizText = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MaterialsProvider>(context); //  Provider
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _headerUI(),
            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== DROPDOWN =====
                    DropdownButtonFormField<String>(
                      value: selectedMaterial,
                      decoration: InputDecoration(
                        labelText: Strings.get("material"),
                        filled: true,
                        fillColor: isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: store.items
                          .map(
                            (m) => DropdownMenuItem(
                          value: m.title,
                          child: Text(m.title),
                        ),
                      )
                          .toList(),
                      onChanged: (v) => setState(() => selectedMaterial = v),
                    ),

                    const SizedBox(height: 15),

                    //  GENERATE QUIZ BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.lightbulb, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF18B5A4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: generateQuiz,
                        label: loading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : Text(
                          Strings.get("generate_quiz"),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      Strings.get("quiz"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //  RESULT BOX
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 80),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.white10
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Text(
                        quizText.isEmpty ? "..." : quizText,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //  HEADER UI
  Widget _headerUI() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF18B5A4),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
          ),
        ),

        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Image.asset(
              "assets/images/studyflowcore1.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  // ===== GENERATE QUIZ FUNCTION =====
  Future<void> generateQuiz() async {
    if (selectedMaterial == null) {
      final msg = localeNotifier.value.languageCode == "ar"
          ? "اختر مادة أولاً"
          : "Please select a material first";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
      return;
    }

    setState(() {
      loading = true;
      quizText = localeNotifier.value.languageCode == "ar"
          ? "جاري إنشاء الاختبار..."
          : "Generating quiz...";
    });

    final result = await GroqService.generateQuiz(selectedMaterial!);

    setState(() {
      quizText = result;
      loading = false;
    });
  }
}
