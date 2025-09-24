import 'Card.dart';
import 'collection_permission.dart';

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

  bool removeCardById(String cardId) {
    final initialLength = cards.length;
    cards.removeWhere((card) => card.id == cardId);
    return cards.length < initialLength;
  }

  bool containsCard(Card card) {
    return cards.any((c) => c.id == card.id);
  }

  bool containsCardById(String cardId) {
    return cards.any((c) => c.id == cardId);
  }

  Card? getCardById(String cardId) {
    try {
      return cards.firstWhere((card) => card.id == cardId);
    } catch (_) {
      return null;
    }
  }

  Collection copyWith({
    String? id,
    String? name,
    List<Card>? cards,
    CollectionPermission? permission,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      cards: cards ?? List.from(this.cards),
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cards': cards.map((card) => card.toJson()).toList(),
      'permission': permission.name,
    };
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      cards: (json['cards'] as List<dynamic>?)
          ?.map((cardJson) => Card.fromJson(cardJson))
          .toList() ?? [],
      permission: CollectionPermission.values.firstWhere(
        (e) => e.name == json['permission'],
        orElse: () => CollectionPermission.systemDefault,
      ),
    );
  }
}
