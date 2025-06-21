import 'card.dart';

enum CollectionPermission { readonly, editable, systemDefault }

class Collection {
  final String id;
  final String name;
  final List<Card> cards;
  final CollectionPermission permission;

  Collection({
    required this.id,
    required this.name,
    required this.permission,
    List<Card>? cards,
  }) : cards = cards ?? [];

  bool addCard(Card card) {
    if (containsCard(card)) return false;
    cards.add(card);
    return true;
  }

  bool removeCard(Card card) {
    if (!containsCard(card)) return false;
    cards.remove(card);
    return true;
  }

  bool containsCard(Card card) {
    return cards.any((c) => c.id == card.id);
  }
}
