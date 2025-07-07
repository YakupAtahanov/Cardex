
import 'dart:typed_data';

class CardModel {
  final String id;
  final String name;
  final String? description;
  final String? barcode;
  final Uint8List? frontImage;
  final Uint8List? backImage;
  final DateTime createdAt;

  CardModel({
    required this.id,
    required this.name,
    this.description,
    this.barcode,
    this.frontImage,
    this.backImage,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
