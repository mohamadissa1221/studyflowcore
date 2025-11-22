import 'package:flutter/foundation.dart';
import '../data/material_data.dart';

class MaterialsProvider with ChangeNotifier {
  final List<MaterialData> _items = [];

  List<MaterialData> get items => _items;

  // Add
  void addMaterial(String title, String description) {
    final newMaterial = MaterialData(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
    );
    _items.add(newMaterial);
    notifyListeners();
  }

  // Delete
  void deleteMaterial(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Update
  void updateMaterial(int id, String newTitle, String newDescription) {
    final index = _items.indexWhere((m) => m.id == id);

    if (index != -1) {
      _items[index] = MaterialData(
        id: id,
        title: newTitle,
        description: newDescription,
      );
      notifyListeners();
    }
  }
}
