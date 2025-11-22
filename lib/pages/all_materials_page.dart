import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/materials_provider.dart';
import '../data/material_data.dart';



class AllMaterialsPage extends StatelessWidget {
  const AllMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MaterialsProvider>(context);
    final List<MaterialData> items = store.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Materials"),
        backgroundColor: Colors.teal,
      ),

      body: items.isEmpty
          ? const Center(
        child: Text(
          "No materials yet",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                item.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  store.deleteMaterial(item.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Material deleted"),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
