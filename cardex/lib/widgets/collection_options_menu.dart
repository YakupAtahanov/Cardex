import 'package:flutter/material.dart';

class CollectionOptionsMenu extends StatelessWidget {
  // final CardCollection collection;

  const CollectionOptionsMenu({Key? key}) //, required this.collection
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white70),
              title: const Text(
                'Rename',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // trigger rename logic here
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(context);
                // trigger delete logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white70),
              title: const Text(
                'Share Collection',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // trigger share logic
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.cloud_upload_outlined,
                color: Colors.white70,
              ),
              title: const Text(
                'Backup to Cloud',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // trigger cloud backup
              },
            ),
          ],
        ),
      ),
    );
  }
}
