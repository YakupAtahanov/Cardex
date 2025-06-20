import 'package:flutter/material.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/models/Collection.dart';
import 'package:cardex/models/Card.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Collection> collections;
  final Collection selectedCollection;
  final ValueChanged<String?> onCollectionChanged;
  final VoidCallback onAdd;

  const CustomAppBar({
    Key? key,
    required this.collections,
    required this.selectedCollection,
    required this.onCollectionChanged,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF1E1E1E),
          style: AppTextStyles.inter16WhiteBold,
          value: selectedCollection.name,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          onChanged: onCollectionChanged,
          items:
              collections.map((collection) {
                return DropdownMenuItem<String>(
                  value: collection.name,
                  child: Text(collection.name),
                );
              }).toList(),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [IconButton(icon: const Icon(Icons.add), onPressed: onAdd)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
