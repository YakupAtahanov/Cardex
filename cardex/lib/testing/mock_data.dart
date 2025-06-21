import 'package:cardex/models/Card.dart';
import 'package:cardex/models/Collection.dart';

final List<Card> mockCards = [
  Card(
    id: "1",
    name: "Student ID",
    description: "Cascadia College",
    barcode: "123456789",
    // ... any other properties
  ),
  Card(
    id: "2",
    name: "Library Card",
    description: "Everett Library",
    barcode: "987654321",
  ),
];

final List<Collection> mockCollections = [
  Collection(
    id: "available",
    name: "Available Cards",
    cards: mockCards,
    permission: CollectionPermission.systemDefault,
  ),
  Collection(
    id: "student",
    name: "Student Cards",
    cards: [mockCards[0]],
    permission: CollectionPermission.editable,
  ),
];
