import 'card_model.dart';
import 'collection_permission.dart';

class Collection {
  final String id;
  final String name;
  final List<CardModel> cards;
  final CollectionPermission permission;

  Collection({
    required this.id,
    required this.name,
    required this.permission,
    List<CardModel>? cards,
  }) : cards = cards ?? [];

  bool addCard(CardModel card) {
    if (containsCard(card)) return false;
    cards.add(card);
    return true;
  }

  bool removeCard(CardModel card) {
    if (!containsCard(card)) return false;
    cards.remove(card);
    return true;
  }

  bool containsCard(CardModel card) {
    return cards.any((c) => c.id == card.id);
  }
}
