import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hilfe/main.dart';
import '../widgets/word_card.dart';
import '../widgets/input.dart';

class Vocabulary extends StatelessWidget {
 const  Vocabulary({super.key });                                       
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const WorterBuch(),
    );
  }
}

class WorterBuch extends StatefulWidget {
  const WorterBuch({super.key});
  @override
  State<WorterBuch> createState() => _WorterBuchState();
}

class _WorterBuchState extends State<WorterBuch> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  Future<List<Widget>> loadAsset() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .toList()
        .map((key) => WordCard("$key : ${prefs.getString(key)}", setState))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: HomePage().appBar,
      body: Column(
        children: [
          SizedBox(
              height: size.height / 4,
              child: FutureBuilder(
                future: loadAsset(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!,
                    );
                  } 
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),),
          Input(setState),
        ],
      ),
    );
  }
}
