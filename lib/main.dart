import 'package:flutter/material.dart';


import 'screens/vocabulary_page.dart';
import 'screens/search_page.dart';
import '../widgets/app_bar_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // handle optional parameter plss
  const MyApp({super.key, app});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final appBar = AppBar(
    backgroundColor: const Color(0xFFFFFFFF),
    actions: const [
      AppBarButton(Color(0xFF01579B), Vocabulary(), Icons.add),
      AppBarButton(Color(0xFF01579B), Search(), Icons.search),
      AppBarButton(Color(0xFF01579B), MyApp(), Icons.home)
    ],
    title: const Align(
        alignment: Alignment.center,
        child: Text(
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF01579B)),
            " Deutsch ")),
  );

  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: widget.appBar,
        body: Container());
  }
}
