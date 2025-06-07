import 'package:flutter/material.dart';
import 'package:cardex/themes/text_styles.dart';
import 'package:cardex/widgets/side_menu.dart';

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
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Inter', color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  // HomeScreen({Key key}, ...) : super(key: key);
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
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      drawer: const SideMenu(),
      body: const Center(child: Text("Main content goes here")),
    );
  }
}
