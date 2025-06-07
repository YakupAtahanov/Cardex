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
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        children: [
          const Text("CardEX", style: AppTextStyles.sora12White),
          const Divider(),
          const Text("Collections", style: AppTextStyles.sora24White),
          ...collections.map((name) {
            final isSelected = name == selected;
            return ListTile(
              leading: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(name, style: AppTextStyles.inter16White),
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
