import '../../main.dart';

class Strings {
  static Map<String, Map<String, String>> localized = {
    "en": {
      "login": "Login",
      "signup": "Sign Up",
      "email": "Email",
      "password": "Password",
      "forgot": "Forgot Password?",
      "enter_email": "Enter your email",
      "enter_password": "Enter your password",
      "weak_password": "Password must contain letters & numbers",
      "invalid_email": "Invalid email format",

      "home": "Home",
      "materials": "Materials",
      "add_material": "Add Material",
      "all_materials": "All Materials",
      "material": "Material",
      "title": "Title",
      "description": "Description",

      "qa_with_ai": "Q&A with AI",
      "quiz_with_ai": "Quiz with AI",
      "about_app": "About App",

      "askAi": "Ask AI Tutor",
      "your_question": "Your Question",
      "ai_response": "AI Response",
      "enter_question": "Write your question",

      "quiz": "Quiz",
      "generate_quiz": "Generate Quiz",
      "select_material_first": "Please select a material first",
      "creating_quiz": "Generating quiz...",

      "settings": "Settings",
      "language": "Language",
      "theme": "Theme",
      "textSize": "Text Size",
      "save": "Save",
      "signout": "Sign Out",

      "recent_material": "Recent material:",
      "no_materials_yet": "No materials added yet.",
    },

    "ar": {
      "login": "تسجيل الدخول",
      "signup": "إنشاء حساب",
      "email": "البريد الإلكتروني",
      "password": "كلمة المرور",
      "forgot": "نسيت كلمة المرور؟",
      "enter_email": "أدخل بريدك الإلكتروني",
      "enter_password": "أدخل كلمة المرور",
      "weak_password": "كلمة المرور يجب أن تحتوي على حروف وأرقام",
      "invalid_email": "صيغة البريد الإلكتروني غير صحيحة",

      "home": "الرئيسية",
      "materials": "المواد",
      "add_material": "إضافة مادة",
      "all_materials": "كل المواد",
      "material": "المادة",
      "title": "العنوان",
      "description": "الوصف",

      "qa_with_ai": "سؤال وجواب مع الذكاء الاصطناعي",
      "quiz_with_ai": "اختبار مع الذكاء الاصطناعي",
      "about_app": "حول التطبيق",

      "askAi": "اسأل المعلم الذكي",
      "your_question": "سؤالك",
      "ai_response": "رد الذكاء الاصطناعي",
      "enter_question": "اكتب سؤالك",

      "quiz": "الاختبار",
      "generate_quiz": "إنشاء اختبار",
      "select_material_first": "يرجى اختيار مادة أولاً",
      "creating_quiz": "جاري إنشاء الاختبار...",

      "settings": "الإعدادات",
      "language": "اللغة",
      "theme": "السمة",
      "textSize": "حجم الخط",
      "save": "حفظ",
      "signout": "تسجيل الخروج",

      "recent_material": "أحدث مادة:",
      "no_materials_yet": "لا توجد مواد مضافة بعد.",
    }
  };

  static String get(String key) {
    String lang = localeNotifier.value.languageCode;
    return localized[lang]?[key] ?? key;
  }
}
