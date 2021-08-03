import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelText extends StatefulWidget {
  String label = '';
  double labelScale = 1.3;
  int labelSize = 4;
  String value = '';
  double valueScale = 1.3;
  Color color = Colors.indigoAccent;
  LabelText(
      {Key? key,
      this.label = '',
      this.labelScale = 1.3,
      this.labelSize = 4,
      this.value = '',
      this.valueScale = 1.3,
      this.color = Colors.indigoAccent})
      : super(key: key);

  @override
  _LabelTextState createState() => _LabelTextState();
}

class _LabelTextState extends State<LabelText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: widget.labelSize,
            child: Text(
              widget.label,
              textScaleFactor: widget.labelScale,
              textAlign: TextAlign.right,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: widget.color),
            ),
          ),
          Expanded(
            flex: 10 - widget.labelSize,
            child: Text(widget.value,
                textAlign: TextAlign.center,
                textScaleFactor: widget.valueScale),
          )
        ],
      ),
    );
  }
}
