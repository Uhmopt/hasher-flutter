import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/hasherIcon.dart';

// ignore: must_be_immutable
class IconText extends StatefulWidget {
  IconText({Key? key, this.icon = Icons.menu, this.text = ''})
      : super(key: key);
  IconData icon = Icons.menu;
  String text = '';

  @override
  _IconTextState createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: HasherIcon(icon: widget.icon, color: Colors.pinkAccent),
        ),
        Container(
          child: Text(
            widget.text,
            textScaleFactor: 1.3,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
