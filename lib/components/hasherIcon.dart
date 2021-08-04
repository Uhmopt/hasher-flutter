import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HasherIcon extends StatefulWidget {
  HasherIcon({Key? key, this.icon = Icons.menu, this.color = Colors.white})
      : super(key: key);
  IconData icon = Icons.menu;
  Color color = Colors.white;

  @override
  HasherIconState createState() => HasherIconState();
}

class HasherIconState extends State<HasherIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        widget.icon,
        size: 40,
        color: widget.color,
      ),
    );
  }
}
