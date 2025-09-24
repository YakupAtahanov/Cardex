import 'package:cardex/models/Card.dart';
import 'package:cardex/models/Collection.dart';
import 'package:cardex/models/collection_permission.dart';

final List<Card> mockCards = [
  Card(
    id: "1",
    name: "Student ID",
    description: "Cascadia College",
    barcode: "123456789",
    type: CardType.student,
    issuer: "Cascadia College",
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
  ),
  Card(
    id: "2",
    name: "Library Card",
    description: "Everett Library",
    barcode: "987654321",
    type: CardType.library,
    issuer: "Everett Library",
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
  ),
  Card(
    id: "3",
    name: "Visa Credit Card",
    description: "Personal Credit Card",
    cardNumber: "****1234",
    type: CardType.credit,
    issuer: "Bank of America",
    createdAt: DateTime.now().subtract(const Duration(days: 60)),
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
  Collection(
    id: "personal",
    name: "Personal Cards",
    cards: [mockCards[2]],
    permission: CollectionPermission.readWrite,
  ),
];
