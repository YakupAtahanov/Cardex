import 'package:flutter/material.dart';
import 'package:cardex/models/Collection.dart';
import 'package:cardex/models/Card.dart';

class AvailableCardsCollection with ChangeNotifier {
  final List<Collection> _collections = [];

  List<Collection> get collections => List.unmodifiable(_collections);
  List<String> get collectionNames => _collections.map((c) => c.name).toList();

  void addCollection(Collection collection) {
    _collections.add(collection);
    notifyListeners();
  }

  void addCollectionByName(String name) {
    _collections.add(Collection(
      id: UniqueKey().toString(),
      name: name,
      cards: [],
    ));
    notifyListeners();
  }

  void removeCollection(String id) {
    _collections.removeWhere((collection) => collection.id == id);
    notifyListeners();
  }

  void deleteCollection(String name) {
    _collections.removeWhere((c) => c.name == name);
    notifyListeners();
  }

  Collection? getCollectionById(String id) {
    try {
      return _collections.firstWhere((collection) => collection.id == id);
    } catch (_) {
      return null;
    }
  }

  void renameCollection(String oldName, String newName) {
    final collection = _collections.firstWhere((c) => c.name == oldName, orElse: () => null);
    if (collection != null) {
      collection.name = newName;
      notifyListeners();
    }
  }

  void addCardToCollection(String collectionId, CardModel card) {
    final collection = getCollectionById(collectionId);
    if (collection != null) {
      collection.cards.add(card);
      notifyListeners();
    }
  }

  void removeCardFromCollection(String collectionId, String cardId) {
    final collection = getCollectionById(collectionId);
    if (collection != null) {
      collection.cards.removeWhere((card) => card.id == cardId);
      notifyListeners();
    }
  }
}
