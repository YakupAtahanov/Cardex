<<<<<<< HEAD

import 'Card.dart';

class Collection {
  String id;
  String name;
  List<CardModel> cards;
=======
import 'Card.dart';

enum CollectionPermission { readonly, editable, systemDefault }

class Collection {
  final String id;
  final String name;
  final List<Card> cards;
  final CollectionPermission permission;
>>>>>>> backend-trial-1

  Collection({
    required this.id,
    required this.name,
<<<<<<< HEAD
    required this.cards,
  });
=======
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
>>>>>>> backend-trial-1
}
