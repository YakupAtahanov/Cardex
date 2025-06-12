import 'package:flutter/material.dart';
import 'package:cardex/themes/text_styles.dart';

class CollectionTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap, onMore;

  const CollectionTile({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  name,
                  style:
                      isSelected
                          ? AppTextStyles.inter16WhiteBold
                          : AppTextStyles.inter16White,
                ),
              ),

              SizedBox(
                height: 33,
                width: 33,
                child: IconButton(
                  icon: const Icon(Icons.more_vert, size: 22),
                  color: Colors.white70,
                  splashRadius: 48,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onMore,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
