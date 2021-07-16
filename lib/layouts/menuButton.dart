import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuButton extends StatefulWidget {
  String title = '';
  IconData? icon = Icons.ac_unit;
  void Function() onPressed = () {};
  MenuButton(
      {Key? key, required this.title, this.icon, required this.onPressed})
      : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  widget.icon,
                  size: 30,
                )),
            Text(
              widget.title,
              textScaleFactor: 1.2,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
