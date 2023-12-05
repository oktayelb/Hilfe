import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Color color;
  final Widget app;
  final IconData icon;
  const AppBarButton(this.color,this.app, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        color: color,

        onPressed: () => runApp(app),
       icon : Icon(icon),
      ),
    );
  }
}
