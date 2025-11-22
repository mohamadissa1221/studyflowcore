import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../localization/strings.dart';

import '../providers/materials_provider.dart';

import 'add_material_page.dart';
import 'all_materials_page.dart';
import 'ai_tutor_page.dart';
import 'quiz_page.dart';
import 'settings_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 1080,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _headerUI(),

                  const SizedBox(height: 40),

                  _menuGrid(isDark),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment:
                      isRtl ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        Strings.get("recent_material"),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  _recentMaterial(isRtl),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  HEADER
  Widget _headerUI() {
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
          const Positioned(
            bottom: 0,
            child: AppLogo(),
          ),
        ],
      ),
    );
  }

  // GRID MENU
  Widget _menuGrid(bool isDark) {
    final cardColor = isDark ? Colors.grey.shade900 : const Color(0xFFEAF9F5);
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        childAspectRatio: 0.80,
        children: [
          _buildItem(
            icon: Icons.menu_book_outlined,
            label: Strings.get("add_material"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddMaterialPage()),
              );
              setState(() {});
            },
            showPlus: true,
          ),

          _buildItem(
            label: Strings.get("qa_with_ai"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            showAI: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AiTutorPage()),
              );
            },
          ),

          _buildItem(
            icon: Icons.quiz_outlined,
            label: Strings.get("quiz_with_ai"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizPage()),
              );
            },
          ),

          _buildItem(
            icon: Icons.library_books_outlined,
            label: Strings.get("all_materials"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllMaterialsPage()),
              );
              if (result == true) setState(() {});
            },
          ),

          _buildItem(
            icon: Icons.settings_outlined,
            label: Strings.get("settings"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),

          _buildItem(
            icon: Icons.info_outline,
            label: Strings.get("about_app"),
            isDark: isDark,
            cardColor: cardColor,
            iconColor: iconColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  //  GRID ITEM
  Widget _buildItem({
    IconData? icon,
    required String label,
    required bool isDark,
    required Color cardColor,
    required Color iconColor,
    required Function() onTap,
    bool showAI = false,
    bool showPlus = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: showAI
                  ? Text(
                "AI",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              )
                  : Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, size: 34, color: iconColor),
                  if (showPlus)
                    const Positioned(
                      right: -4,
                      bottom: -4,
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.add,
                            size: 14, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  //  RECENT MATERIAL
  Widget _recentMaterial(bool isRtl) {
    final store = Provider.of<MaterialsProvider>(context);

    if (store.items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            Strings.get("no_materials_yet"),
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      );
    }

    final last = store.items.last;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          "- ${last.title}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
