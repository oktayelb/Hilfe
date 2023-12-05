import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordCard extends StatefulWidget {
  final Function onDelete;
  final String couple;

  const WordCard(this.couple, this.onDelete, {super.key});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  void flipper() {
    if (_status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(end: 0.0, begin: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  Future<void> delete() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(widget.couple.split(':')[0].trim().toLowerCase());
    widget.onDelete(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pair = widget.couple.split(":");
    final frontWord = pair[1].trim().toLowerCase();
    final backWord = pair[0].trim().toLowerCase();

    var name = Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF3066be),
          width: 7.0,
        ),
      ),
      height: size.height / 4,
      width: size.width / 1.2,
      child: Center(
        child: Text(
          frontWord,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );

    var meaning = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1415),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlueAccent.shade100,
            border: Border.all(
              color: const Color(0xFF3066be),
              width: 4.0,
            ),
          ),
          height: size.height / 4,
          width: size.width / 1.2,
          child: Center(
            child: Text(
              backWord,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ));

    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(2, 1, 0.0015)
        ..rotateY(3.14 * _animation.value),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue.shade100),
          onLongPress: delete,
          onPressed: flipper,
          child: _animation.value > 0.5 ? meaning : name),
    );
  }
}
