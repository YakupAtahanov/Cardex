import 'package:cardex/models/collection.dart';

class CollectionManager {
  List<Collection> collections = [];
  Collection? selected;

  void selectionCollection(String name) {
    selected = collections.firstWhere(
      (c) => c.name == name,
      orElse: () => selected ?? collections.first,
    );
  }

  void addCollection(Collection newCollection) {
    if (!collections.any((c) => c.name == newCollection.name)) {
      collections.add(newCollection);
    }
  }
}
