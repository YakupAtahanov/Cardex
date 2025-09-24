enum CardType {
  credit,
  debit,
  student,
  library,
  bus,
  reward,
  other,
}

class Card {
  final String id;
  final String name;
  final String? description;
  final String? barcode;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;
  final CardType type;
  final String? issuer;
  final DateTime createdAt;
  final DateTime? lastUsed;

  const Card({
    required this.id,
    required this.name,
    this.description,
    this.barcode,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.type = CardType.other,
    this.issuer,
    required this.createdAt,
    this.lastUsed,
  });

  // For backward compatibility
  String get title => name;

  Card copyWith({
    String? id,
    String? name,
    String? description,
    String? barcode,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    CardType? type,
    String? issuer,
    DateTime? createdAt,
    DateTime? lastUsed,
  }) {
    return Card(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      type: type ?? this.type,
      issuer: issuer ?? this.issuer,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'barcode': barcode,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'type': type.name,
      'issuer': issuer,
      'createdAt': createdAt.toIso8601String(),
      'lastUsed': lastUsed?.toIso8601String(),
    };
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      barcode: json['barcode'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
      type: CardType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CardType.other,
      ),
      issuer: json['issuer'],
      createdAt: DateTime.parse(json['createdAt']),
      lastUsed: json['lastUsed'] != null 
          ? DateTime.parse(json['lastUsed']) 
          : null,
    );
  }
}
