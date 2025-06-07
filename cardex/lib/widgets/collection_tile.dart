import 'package:flutter/material.dart';
import 'package:cardex/themes/text_styles.dart';

class CollectionTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const CollectionTile({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      ),
      title: Text(
        name,
        style:
            isSelected
                ? AppTextStyles.inter16WhiteBold
                : AppTextStyles.inter16White,
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
