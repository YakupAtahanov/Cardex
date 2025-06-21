import 'package:flutter/material.dart';
import 'package:cardex/frontend/widgets/card_widget.dart';
import 'package:cardex/models/Collection.dart';

class CardsScrollWidget extends StatelessWidget {
  final Collection collection;
  const CardsScrollWidget({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 160,
        diameterRatio: 1.5, // barrel curvature
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.003,
        childDelegate: ListWheelChildLoopingListDelegate(
          children:
              collection.cards.map((card) {
                return CardWidget(title: card.name as String);
              }).toList(),
        ),
      ),
    );
  }
}
