import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../widgets/app_logo.dart';
import '../providers/materials_provider.dart';
import '../localization/strings.dart';


class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({super.key});

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void saveMaterial() {
    if (!_formKey.currentState!.validate()) return;

    final store = Provider.of<MaterialsProvider>(context, listen: false);

    store.addMaterial(
      titleController.text.trim(),
      descController.text.trim(),
    );

    Navigator.pop(context, true);
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height:1080 ,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              labelText: Strings.get("title"),
                              filled: true,
                              fillColor:
                              isDark ? Colors.grey.shade900 : Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                            ),
                            validator: (v) =>
                            v!.trim().isEmpty ? "Enter a title" : null,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: descController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: Strings.get("description"),
                              filled: true,
                              fillColor:
                              isDark ? Colors.grey.shade900 : Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                            ),
                            validator: (v) =>
                            v!.trim().isEmpty ? "Enter material content" : null,
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blue),
                              onPressed: saveMaterial,
                              child: Text(
                                Strings.get("save"),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
}
