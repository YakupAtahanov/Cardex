import 'package:flutter/material.dart';
import 'package:cardex/themes/text_styles.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        children: [
          const Text("CardEX", style: AppTextStyles.sectionHeading),
          const Divider(),
          ...collections.map((name) {
            final isSelected = name == selected;
            return ListTile(
              title: Text(name),
              selected: isSelected,
              onTap: () {
                setState(() {
                  selected = name;
                  Navigator.of(context).pop();
                });
              },
            );
          }),
        ],
      ),
    );
  }
}
