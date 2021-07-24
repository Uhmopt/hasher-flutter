import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxLabel extends StatefulWidget {
  bool value = false;
  void Function(bool?)? onChanged = (value) {};
  String label = '';
  double textScaleFactor = 1.2;
  Color? checkColor = Colors.pinkAccent;
  Color? labelColor = Colors.black;
  CheckBoxLabel(
      {Key? key,
      this.value = false,
      required this.onChanged,
      this.label = '',
      this.textScaleFactor = 1.2,
      this.checkColor = Colors.pinkAccent,
      this.labelColor = Colors.black})
      : super(key: key);

  @override
  _CheckBoxLabelState createState() => _CheckBoxLabelState();
}

class _CheckBoxLabelState extends State<CheckBoxLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            onChanged: widget.onChanged,
            value: widget.value,
            activeColor: widget.checkColor,
          ),
          GestureDetector(
            onTap: () {
              Function t = widget.onChanged ?? () {};
              t(!widget.value);
            },
            child: Text(
              widget.label,
              textScaleFactor: widget.textScaleFactor,
              style: TextStyle(
                  color: widget.labelColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
