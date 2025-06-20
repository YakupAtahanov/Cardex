import 'package:flutter/material.dart';
import 'package:cardex/models/card.dart';
import 'package:cardex/frontend/themes/text_styles.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final double height;

  const CardWidget({Key? key, required this.title, required this.height})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // consistent width
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTextStyles.inter16White,
        textAlign: TextAlign.center,
      ),
    );
  }
}
