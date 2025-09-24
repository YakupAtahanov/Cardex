import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/Card.dart';
import '../../models/Collection.dart';

class CardRepository {
  static const _storage = FlutterSecureStorage();
  static const String _collectionsKey = 'collections';
  static const String _selectedCollectionKey = 'selected_collection';

  // Collections CRUD operations
  Future<List<Collection>> getAllCollections() async {
    try {
      final collectionsJson = await _storage.read(key: _collectionsKey);
      if (collectionsJson == null) {
        return [];
      }
      
      final List<dynamic> collectionsList = json.decode(collectionsJson);
      return collectionsList
          .map((json) => Collection.fromJson(json))
          .toList();
    } catch (e) {
      print('Error loading collections: $e');
      return [];
    }
  }

  Future<void> saveCollections(List<Collection> collections) async {
    try {
      final collectionsJson = json.encode(
        collections.map((collection) => collection.toJson()).toList(),
      );
      await _storage.write(key: _collectionsKey, value: collectionsJson);
    } catch (e) {
      print('Error saving collections: $e');
      throw Exception('Failed to save collections');
    }
  }

  Future<void> addCollection(Collection collection) async {
    final collections = await getAllCollections();
    collections.add(collection);
    await saveCollections(collections);
  }

  Future<void> updateCollection(Collection updatedCollection) async {
    final collections = await getAllCollections();
    final index = collections.indexWhere((c) => c.id == updatedCollection.id);
    if (index != -1) {
      collections[index] = updatedCollection;
      await saveCollections(collections);
    }
  }

  Future<void> deleteCollection(String collectionId) async {
    final collections = await getAllCollections();
    collections.removeWhere((c) => c.id == collectionId);
    await saveCollections(collections);
  }

  // Cards CRUD operations
  Future<void> addCardToCollection(String collectionId, Card card) async {
    final collections = await getAllCollections();
    final collectionIndex = collections.indexWhere((c) => c.id == collectionId);
    
    if (collectionIndex != -1) {
      final updatedCollection = collections[collectionIndex].copyWith(
        cards: [...collections[collectionIndex].cards, card],
      );
      collections[collectionIndex] = updatedCollection;
      await saveCollections(collections);
    }
  }

  Future<void> removeCardFromCollection(String collectionId, String cardId) async {
    final collections = await getAllCollections();
    final collectionIndex = collections.indexWhere((c) => c.id == collectionId);
    
    if (collectionIndex != -1) {
      final updatedCards = collections[collectionIndex].cards
          .where((card) => card.id != cardId)
          .toList();
      final updatedCollection = collections[collectionIndex].copyWith(
        cards: updatedCards,
      );
      collections[collectionIndex] = updatedCollection;
      await saveCollections(collections);
    }
  }

  Future<void> updateCard(String collectionId, Card updatedCard) async {
    final collections = await getAllCollections();
    final collectionIndex = collections.indexWhere((c) => c.id == collectionId);
    
    if (collectionIndex != -1) {
      final cardIndex = collections[collectionIndex].cards
          .indexWhere((card) => card.id == updatedCard.id);
      
      if (cardIndex != -1) {
        final updatedCards = List<Card>.from(collections[collectionIndex].cards);
        updatedCards[cardIndex] = updatedCard;
        
        final updatedCollection = collections[collectionIndex].copyWith(
          cards: updatedCards,
        );
        collections[collectionIndex] = updatedCollection;
        await saveCollections(collections);
      }
    }
  }

  // Selected collection management
  Future<String?> getSelectedCollectionId() async {
    return await _storage.read(key: _selectedCollectionKey);
  }

  Future<void> setSelectedCollectionId(String collectionId) async {
    await _storage.write(key: _selectedCollectionKey, value: collectionId);
  }

  // Clear all data (for testing/logout)
  Future<void> clearAllData() async {
    await _storage.delete(key: _collectionsKey);
    await _storage.delete(key: _selectedCollectionKey);
  }
}
