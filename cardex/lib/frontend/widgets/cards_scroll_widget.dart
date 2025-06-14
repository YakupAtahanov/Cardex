import 'package:flutter/material.dart';
import 'package:cardex/frontend/widgets/card_widget.dart';

class CardsScrollWidget extends StatelessWidget {
  const CardsScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      {'title': 'Worker card', 'height': 90.0},
      {'title': 'Coupon', 'height': 110.0},
      {'title': 'Bank of America card', 'height': 140.0},
      {'title': 'Bus card', 'height': 110.0},
      {'title': 'School card', 'height': 90.0},
    ];

    return Center(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 160,
        diameterRatio: 1.5, // barrel curvature
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.003,
        childDelegate: ListWheelChildLoopingListDelegate(
          children:
              cards.map((card) {
                return CardWidget(
                  title: card['title'] as String,
                  height: card['height'] as double,
                );
              }).toList(),
        ),
      ),
    );
  }
}
