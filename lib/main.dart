import 'package:flutter/material.dart';
import 'package:flutter_game_of_life/views/game_of_life_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameOfLife(
      width: MediaQuery.of(context).size.width.round(),
      height: MediaQuery.of(context).size.height.round(),
    );
  }
}
