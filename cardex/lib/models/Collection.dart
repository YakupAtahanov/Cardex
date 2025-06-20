import 'card.dart';

class Collection {
  final String id;
  final String name;
  final List<Card> cards;

  Collection({required this.id, required this.name, List<Card>? cards})
    : cards = cards ?? [];

  void addCard(Card card) {
    cards.add(card);
  }

  void removeCard(Card card) {
    cards.remove(card);
  }
}
