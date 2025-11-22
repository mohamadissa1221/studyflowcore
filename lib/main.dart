import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/colors.dart';
import 'pages/intro_page.dart';
import 'providers/materials_provider.dart';

//  GLOBAL NOTIFIERS
ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
ValueNotifier<double> textSizeNotifier = ValueNotifier(1.0);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MaterialsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return ValueListenableBuilder(
          valueListenable: themeNotifier,
          builder: (context, theme, _) {
            return ValueListenableBuilder(
              valueListenable: textSizeNotifier,
              builder: (context, scale, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,

                  // LOCALIZATION
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                  ],

                  // THEMES
                  themeMode: theme,
                  theme: ThemeData(
                    primaryColor: AppColors.primary,
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primary,
                      secondary: AppColors.primary,
                    ),
                    textTheme:
                    ThemeData.light().textTheme.apply(fontSizeFactor: scale),
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    scaffoldBackgroundColor: const Color(0xFF0D0D0D),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Color(0xFF111111),
                    ),
                    cardColor: const Color(0xFF1A1A1A),
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: AppColors.primary,
                      secondary: AppColors.primary,
                    ),
                    textTheme:
                    ThemeData.dark().textTheme.apply(fontSizeFactor: scale),
                  ),

                  home: const IntroPage(),
                );
              },
            );
          },
        );
      },
    );
  }
}
