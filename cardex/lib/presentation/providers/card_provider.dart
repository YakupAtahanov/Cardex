import 'package:flutter/material.dart';
import '../../models/Card.dart';
import '../../models/Collection.dart';
import '../../models/collection_permission.dart';
import '../../data/repositories/card_repository.dart';

class CardProvider with ChangeNotifier {
  final CardRepository _repository = CardRepository();
  
  List<Collection> _collections = [];
  String? _selectedCollectionId;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Collection> get collections => List.unmodifiable(_collections);
  Collection? get selectedCollection {
    if (_selectedCollectionId == null) return null;
    try {
      return _collections.firstWhere((c) => c.id == _selectedCollectionId);
    } catch (_) {
      return null;
    }
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      _collections = await _repository.getAllCollections();
      _selectedCollectionId = await _repository.getSelectedCollectionId();
      
      // If no collections exist, create default ones
      if (_collections.isEmpty) {
        await _createDefaultCollections();
      }
      
      // If no collection is selected, select the first one
      if (_selectedCollectionId == null && _collections.isNotEmpty) {
        _selectedCollectionId = _collections.first.id;
        await _repository.setSelectedCollectionId(_selectedCollectionId!);
      }
      
      _clearError();
    } catch (e) {
      _setError('Failed to initialize: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Collection management
  Future<void> addCollection(Collection collection) async {
    _setLoading(true);
    try {
      await _repository.addCollection(collection);
      _collections.add(collection);
      notifyListeners();
      _clearError();
    } catch (e) {
      _setError('Failed to add collection: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateCollection(Collection collection) async {
    _setLoading(true);
    try {
      await _repository.updateCollection(collection);
      final index = _collections.indexWhere((c) => c.id == collection.id);
      if (index != -1) {
        _collections[index] = collection;
        notifyListeners();
      }
      _clearError();
    } catch (e) {
      _setError('Failed to update collection: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteCollection(String collectionId) async {
    _setLoading(true);
    try {
      await _repository.deleteCollection(collectionId);
      _collections.removeWhere((c) => c.id == collectionId);
      
      // If the deleted collection was selected, select the first available
      if (_selectedCollectionId == collectionId) {
        if (_collections.isNotEmpty) {
          _selectedCollectionId = _collections.first.id;
          await _repository.setSelectedCollectionId(_selectedCollectionId!);
        } else {
          _selectedCollectionId = null;
        }
      }
      
      notifyListeners();
      _clearError();
    } catch (e) {
      _setError('Failed to delete collection: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> selectCollection(String collectionId) async {
    if (_collections.any((c) => c.id == collectionId)) {
      _selectedCollectionId = collectionId;
      await _repository.setSelectedCollectionId(collectionId);
      notifyListeners();
    }
  }

  // Card management
  Future<void> addCard(Card card) async {
    if (_selectedCollectionId == null) {
      _setError('No collection selected');
      return;
    }

    _setLoading(true);
    try {
      await _repository.addCardToCollection(_selectedCollectionId!, card);
      
      // Update local state
      final index = _collections.indexWhere((c) => c.id == _selectedCollectionId);
      if (index != -1) {
        final updatedCollection = _collections[index].copyWith(
          cards: [..._collections[index].cards, card],
        );
        _collections[index] = updatedCollection;
        notifyListeners();
      }
      
      _clearError();
    } catch (e) {
      _setError('Failed to add card: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeCard(String cardId) async {
    if (_selectedCollectionId == null) {
      _setError('No collection selected');
      return;
    }

    _setLoading(true);
    try {
      await _repository.removeCardFromCollection(_selectedCollectionId!, cardId);
      
      // Update local state
      final index = _collections.indexWhere((c) => c.id == _selectedCollectionId);
      if (index != -1) {
        final updatedCards = _collections[index].cards
            .where((card) => card.id != cardId)
            .toList();
        final updatedCollection = _collections[index].copyWith(cards: updatedCards);
        _collections[index] = updatedCollection;
        notifyListeners();
      }
      
      _clearError();
    } catch (e) {
      _setError('Failed to remove card: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateCard(Card card) async {
    if (_selectedCollectionId == null) {
      _setError('No collection selected');
      return;
    }

    _setLoading(true);
    try {
      await _repository.updateCard(_selectedCollectionId!, card);
      
      // Update local state
      final index = _collections.indexWhere((c) => c.id == _selectedCollectionId);
      if (index != -1) {
        final cardIndex = _collections[index].cards
            .indexWhere((c) => c.id == card.id);
        if (cardIndex != -1) {
          final updatedCards = List<Card>.from(_collections[index].cards);
          updatedCards[cardIndex] = card;
          final updatedCollection = _collections[index].copyWith(cards: updatedCards);
          _collections[index] = updatedCollection;
          notifyListeners();
        }
      }
      
      _clearError();
    } catch (e) {
      _setError('Failed to update card: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  Future<void> _createDefaultCollections() async {
    // Create default collections if none exist
    final defaultCollections = [
      Collection(
        id: 'default',
        name: 'My Cards',
        permission: CollectionPermission.readWrite,
      ),
    ];
    
    for (final collection in defaultCollections) {
      await _repository.addCollection(collection);
    }
    
    _collections = await _repository.getAllCollections();
  }

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    _setLoading(true);
    try {
      await _repository.clearAllData();
      _collections.clear();
      _selectedCollectionId = null;
      notifyListeners();
      _clearError();
    } catch (e) {
      _setError('Failed to clear data: $e');
    } finally {
      _setLoading(false);
    }
  }
}
