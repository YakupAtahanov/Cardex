import 'package:flutter/material.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/frontend/widgets/collection_tile.dart';
import 'package:cardex/frontend/widgets/collection_options_menu.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // TODO: BACKEND: Variables must be dynamic. These are examples.
  final List<String> collections = [
    "Available Cards",
    "Student Cards",
    "Loyalty Cards",
  ];
  String selected = "Available Cards";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        children: [
          const Text("CardEX", style: AppTextStyles.sora12White),
          const Divider(),
          // TODO: The "example" variables are used here. Must build an architecture.
          const Text("Collections", style: AppTextStyles.sora24White),
          ...collections.map((name) {
            return CollectionTile(
              name: name,
              isSelected: name == selected,
              onTap: () {
                setState(() {
                  selected = name;
                  Navigator.of(context).pop();
                });
              },
              onMore: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => CollectionOptionsMenu(),
                );
              },
            );
            /* return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 23,
                vertical: -30,
              ),
              leading: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              dense: true,
              minVerticalPadding: 0,
              horizontalTitleGap: -3,

              // Below this line are the properties that use the variables provided (selected and isSelected variables).
              title: Text(
                name,
                style:
                    isSelected
                        ? AppTextStyles.inter16WhiteBold
                        : AppTextStyles.inter16White,
              ),
              selected: isSelected,
              onTap: () {
                setState(() {
                  selected = name;
                  Navigator.of(context).pop();
                });
              },
            );
            */
          }),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.add, color: Colors.white),
            title: const Text(
              'Add Collection',
              style: AppTextStyles.inter16White,
            ),
            onTap: () {
              Navigator.pop(context);
              // _showAddCollectionDialog(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings', style: AppTextStyles.inter16White),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.feedback_outlined, color: Colors.grey),
            title: const Text(
              'Leave a feedback',
              style: AppTextStyles.inter16Grey,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
