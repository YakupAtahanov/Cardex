import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardex/frontend/themes/text_styles.dart';
import 'package:cardex/frontend/widgets/side_menu.dart';
import 'package:cardex/frontend/widgets/cards_scroll_widget.dart';
import 'package:cardex/frontend/widgets/app_bar.dart';
import 'package:cardex/frontend/widgets/add_card_form.dart';
import 'package:cardex/presentation/providers/card_provider.dart';
import 'package:cardex/models/Card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider()..initialize(),
      child: MaterialApp(
        title: "CardEX",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF121212),
          textTheme: const TextTheme(bodyMedium: AppTextStyles.inter16White),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CardProvider>(
      builder: (context, cardProvider, child) {
        if (cardProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (cardProvider.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${cardProvider.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => cardProvider.initialize(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (cardProvider.collections.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                'No collections found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final selectedCollection = cardProvider.selectedCollection;
        if (selectedCollection == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'No collection selected',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: CustomAppBar(
            collections: cardProvider.collections,
            selectedCollection: selectedCollection,
            onCollectionChanged: (value) {
              if (value != null) {
                final collection = cardProvider.collections.firstWhere(
                  (c) => c.name == value,
                  orElse: () => selectedCollection,
                );
                cardProvider.selectCollection(collection.id);
              }
            },
            onAdd: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: const Color(0xFF1E1E1E),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => AddCardForm(
                  onSave: (title, description) {
                    // Create a new card
                    final newCard = Card(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: title,
                      description: description,
                      createdAt: DateTime.now(),
                    );
                    cardProvider.addCard(newCard);
                  },
                ),
              );
            },
          ),
          drawer: SideMenu(collections: cardProvider.collections),
          body: CardsScrollWidget(collection: selectedCollection),
        );
      },
    );
  }
}
