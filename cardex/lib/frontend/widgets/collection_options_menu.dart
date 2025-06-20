import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardex/backend/available_cards_collection.dart';

class CollectionOptionsMenu extends StatelessWidget {
  final String collectionName;

  const CollectionOptionsMenu({
    super.key,
    required this.collectionName,
  });

  void _showRenameDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Collection"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "New name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                Provider.of<AvailableCardsCollection>(context, listen: false)
                    .renameCollection(collectionName, newName);
              }
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
            },
            child: const Text("Rename"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white70),
              title: const Text('Rename', style: TextStyle(color: Colors.white)),
              onTap: () => _showRenameDialog(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
              title: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Provider.of<AvailableCardsCollection>(context, listen: false)
                    .deleteCollection(collectionName);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white70),
              title: const Text('Share Collection', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud_upload_outlined, color: Colors.white70),
              title: const Text('Backup to Cloud', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement backup
              },
            ),
          ],
        ),
      ),
    );
  }
}
