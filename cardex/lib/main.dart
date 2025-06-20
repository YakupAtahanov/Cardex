
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cardex/backend/available_cards_collection.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/frontend/widgets/side_menu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AvailableCardsCollection(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CardEX",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: const TextTheme(bodyMedium: AppTextStyles.inter16White),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Cards"),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: BACKEND: ADD NEW CARD BUTTON
            },
          ),
        ],
      ),
      drawer: const SideMenu(collections: [],),
      body: const Center(child: Text("Main content goes here")),
    );
  }
}
