import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Input extends StatefulWidget {
  final Function setState;
  const Input(this.setState, {super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final textFieldFirst = TextEditingController(),
      textFieldSecond = TextEditingController();

  final focusNodeFirst = FocusNode(), focusNodeSecond = FocusNode();

  String hintTextFirst = "Almanca", hintTextSecond = "Turkce";

  @override
  void initState() {
    super.initState();

    focusNodeFirst.addListener(() {
      widget.setState(() {
        hintTextFirst = focusNodeFirst.hasFocus ? '' : "Almanca";
      });
    });
    focusNodeSecond.addListener(() {
      widget.setState(() {
        hintTextSecond = focusNodeSecond.hasFocus ? '' : 'Turkce';
      });
    });
  }

  void addNewWord() {
    if (textFieldSecond.text.isNotEmpty && textFieldFirst.text.isNotEmpty) {
      //ayni girdiler ile ugras
      widget.setState(() {
        addTo(textFieldSecond.text.toLowerCase(),
            textFieldFirst.text.toLowerCase());
        textFieldFirst.clear();
        textFieldSecond.clear();
      });
    }
  }

  Future<void> addTo(String front, String back) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(front, back);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.5,
      // height: size.height / 6,
      color: Colors.lightBlue.shade300,
      child: Card(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintTextFirst,
                  ),
                  focusNode: focusNodeFirst,
                  controller: textFieldFirst),
              TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintTextSecond,
                  ),
                  focusNode: focusNodeSecond,
                  controller: textFieldSecond),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue.shade900)),
                  onPressed: () {},
                  child: const Icon(Icons.add))
            ],
          )),
    );
  }
}




// ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               shape: OutlinedBO,
//                 backgroundColor: const Color(0xFF3066be)),
//             onPressed: addNewWord,
//             child:
//                 SizedBox(height: size.height / 28, child: const Icon(Icons.add)),
//           );

// CupertinoButton( color : Colors.blue.shade600, child: Icon(Icons.add), onPressed: (){})




