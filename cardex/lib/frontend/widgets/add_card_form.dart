import 'package:flutter/material.dart';
import 'package:cardex/frontend/themes/text_styles.dart';

class AddCardForm extends StatelessWidget {
  final void Function(String title, String descrption) onSave;

  const AddCardForm({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          const Text("Add New Card", style: AppTextStyles.sora24White),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Card Title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSave(titleController.text, descriptionController.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
