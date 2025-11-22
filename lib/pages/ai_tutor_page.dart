import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../localization/strings.dart';
import '../services/groq_service.dart';
import '../providers/materials_provider.dart';
import '../../main.dart';

class AiTutorPage extends StatefulWidget {
  const AiTutorPage({super.key});

  @override
  State<AiTutorPage> createState() => _AiTutorPageState();
}

class _AiTutorPageState extends State<AiTutorPage> {
  String? selectedMaterial;
  final questionController = TextEditingController();
  final aiResponse = ValueNotifier<String>("");

  @override
  void dispose() {
    questionController.dispose();
    aiResponse.dispose();
    super.dispose();
  }

  Future<void> askAi() async {
    final q = questionController.text.trim();

    if (q.isEmpty || selectedMaterial == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Strings.get("enter_question"))),
      );
      return;
    }

    final lang = localeNotifier.value.languageCode;
    aiResponse.value =
    (lang == 'ar') ? "جاري الحصول على إجابة من المعلم الذكي..." : "Getting answer from AI tutor...";

    final result = await GroqService.askAI(q, selectedMaterial!);

    aiResponse.value = result;
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MaterialsProvider>(context); // <-- Provider
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 3000,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),

                    // Label
                    Text(
                      Strings.get("material"),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),

                    // Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedMaterial,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: store.items
                          .map(
                            (m) => DropdownMenuItem<String>(
                          value: m.title,
                          child: Text(m.title),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        setState(() => selectedMaterial = val);
                      },
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        hintText: Strings.get("your_question"),
                        filled: true,
                        fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: askAi,
                        icon: const Icon(Icons.send, color: Colors.white),
                        label: Text(
                          Strings.get("askAi"),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      Strings.get("ai_response"),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),

                    ValueListenableBuilder<String>(
                      valueListenable: aiResponse,
                      builder: (context, value, _) {
                        return Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 180),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            value.isEmpty ? "..." : value,
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120),
                bottomRight: Radius.circular(120),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            bottom: 0,
            child: AppLogo(),
          ),
        ],
      ),
    );
  }
}
