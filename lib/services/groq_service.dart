import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  static const String apiKey = "";
  static const String model = "groq/compound";

  static Future<String> askAI(String question, String material) async {
    final url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

    final prompt = """
You are an AI tutor. Answer very clearly and simply.

Material: $material
Question: $question
""";

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {"role": "user", "content": prompt}
          ],
          "temperature": 0.5,
        }),
      );

      if (response.statusCode != 200) {
        return "API Error:\n${response.body}";
      }

      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Connection Error: $e";
    }
  }

  //  Generate Quiz (Quiz Page)
  static Future<String> generateQuiz(String material) async {
    final url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

    final prompt = """
Create a short quiz about: $material
Include:
- 3 questions
- Each followed by its answer
Make it clean and simple.
""";

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {"role": "user", "content": prompt}
          ],
          "temperature": 0.5,
        }),
      );

      if (response.statusCode != 200) {
        return "API Error:\n${response.body}";
      }

      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Connection Error: $e";
    }
  }
}
