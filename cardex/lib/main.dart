import 'package:flutter/material.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/frontend/widgets/side_menu.dart';
import 'package:cardex/frontend/widgets/cards_scroll_widget.dart';
import 'package:cardex/frontend/widgets/app_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> collections = [
      "Available cards",
      "Bus cards",
      "Coupons",
    ];

    return MaterialApp(
      title: "CardEX",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(bodyMedium: AppTextStyles.inter16White),
      ),
      home: HomeScreen(
        collections: collections,
        selectedCollection: collections.first,
      ), // Will need a CollectionManager
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<String> collections;
  final String selectedCollection;
  const HomeScreen({
    super.key,
    required this.collections,
    required this.selectedCollection,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedCollection;

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
            setState(() => selectedCollection = value);
          }
        },
        onAdd: () {
          // TODO: show add card modal
        },
      ),
      drawer: SideMenu(collections: widget.collections),
      body: CardsScrollWidget(),
    );
  }
}
