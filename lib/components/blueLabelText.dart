import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlueLabelText extends StatefulWidget {
  String label = '';
  String value = '';
  BlueLabelText({Key? key, this.label = '', this.value = ''}) : super(key: key);

  @override
  _BlueLabelTextState createState() => _BlueLabelTextState();
}

class _BlueLabelTextState extends State<BlueLabelText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              widget.label,
              textScaleFactor: 1.3,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.indigoAccent),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(widget.value,
                textAlign: TextAlign.center, textScaleFactor: 1.3),
          )
        ],
      ),
    );
  }
}
