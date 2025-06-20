
import 'Card.dart';

class Collection {
  String id;
  String name;
  List<CardModel> cards;

  Collection({
    required this.id,
    required this.name,
    required this.cards,
  });
}
