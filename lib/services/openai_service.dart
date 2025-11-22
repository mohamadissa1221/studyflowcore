import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  static const String _apiKey = "";
  static const String _baseUrl = "https://api.groq.com/openai/v1/chat/completions";

  static const String _model = "llama3-8b-8192";


  //  Ask Tutor
  static Future<String> askTutor({
    required String material,
    required String question,
  }) async {

    final prompt = """
You are an AI study tutor.
Material:
$material

Student Question:
$question

Give a simple, clear explanation.
""";

    return _sendChat(prompt);
  }

  //  Generate Quiz
  static Future<String> generateQuiz({
    required String material,
  }) async {
    final prompt = """
Generate a quiz based on the following material:

$material

Quiz rules:
- 5 questions
- mixed MCQ + short answer
- numbered list
- no explanation
""";

    return _sendChat(prompt);
  }

  //  Internal Request
  static Future<String> _sendChat(String prompt) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": _model,
        "messages": [
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.7,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return body["choices"][0]["message"]["content"];
    } else {
      throw Exception(
          "Groq error ${response.statusCode}: ${response.body}");
    }
  }
}
