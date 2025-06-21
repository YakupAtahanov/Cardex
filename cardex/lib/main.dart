import 'package:cardex/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/frontend/widgets/side_menu.dart';
import 'package:cardex/frontend/widgets/cards_scroll_widget.dart';
import 'package:cardex/frontend/widgets/app_bar.dart';
import 'package:cardex/testing/mock_data.dart';
import 'package:cardex/services/collection_manager.dart';
0
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CardEX",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(bodyMedium: AppTextStyles.inter16White),
      ),
      home: HomeScreen(
        collections: mockCollections.toList(),
        selectedCollection: mockCollections.first,
      ), // Will need a CollectionManager
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final _manager = CollectionManager();
  final List<Collection> collections;
  final Collection selectedCollection;
  HomeScreen({
    super.key,
    required this.collections,
    required this.selectedCollection,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Collection selectedCollection;

  @override
  void initState() {
    super.initState();
    selectedCollection = widget.selectedCollection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        collections: widget.collections,
        selectedCollection: selectedCollection,
        onCollectionChanged: (value) {
          if (value != null) {
            setState(
              () =>
                  selectedCollection = widget.collections.firstWhere(
                    (c) => c.name == value,
                    orElse: () => widget.selectedCollection,
                  ),
            );
          }
        },
        onAdd: () {
          // TODO: show add card modal
        },
      ),
      drawer: SideMenu(collections: widget.collections),
      body: CardsScrollWidget(collection: selectedCollection),
    );
  }
}
