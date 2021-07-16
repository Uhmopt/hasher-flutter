import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxLabel extends StatefulWidget {
  bool value = false;
  void Function(bool?)? onChanged = (value) {};
  String label = '';
  CheckBoxLabel(
      {Key? key, this.value = false, required this.onChanged, this.label = ''})
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
            activeColor: Colors.pinkAccent,
          ),
          Text(widget.label)
        ],
      ),
    );
  }
}
