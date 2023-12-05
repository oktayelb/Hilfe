import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/word_card.dart';
import '../main.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final textField = TextEditingController();
  bool sent = true;

  Future<String> getCrspnd(String text) async {
    var prefs = await SharedPreferences.getInstance();
    var correspond = '';
    if (prefs.getKeys().contains(text)) {
      correspond = "$text : ${(prefs.getString(text) as String)}";
    } else {
      for (var element in prefs.getKeys()) {
        if (prefs.getString(element) == text) {
          correspond = "$element : $text";
        }
      }
    }
    return correspond;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: HomePage().appBar,
        body: sent? Center(
        child: Card(
          child: Column(
            children: [
              TextField(
                controller: textField,
              ),
              ElevatedButton(onPressed: () {

                sent = false;
                getCrspnd(textField.text);
                setState(() {
                  
                });
              }, 
              child: const Icon(Icons.add)),
            ],
          ),
        ),
      ) :FutureBuilder(
                future: getCrspnd(textField.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(child: WordCard(snapshot.data as String, (){}));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              )
      
      
      ,
    );
  }
}


