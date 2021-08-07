import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioGroup extends StatefulWidget {
  RadioGroup({
    Key? key,
    this.direction = 'Row',
    required this.options,
    this.value = '',
    required this.onChanged,
  }) : super(key: key);
  String direction = 'Row';
  List<String> options = [];
  String value = '';
  Function(String?) onChanged;
  Color labelColor = Colors.indigoAccent;
  Color color = Colors.pinkAccent;

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction:
            (widget.direction == 'Row') ? Axis.horizontal : Axis.vertical,
        children: List<Widget>.from(
          widget.options.map((option) => Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: widget.value,
                    onChanged: widget.onChanged,
                    fillColor: MaterialStateProperty.all(widget.color),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onChanged(option);
                    },
                    child: Text(
                      option,
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.labelColor,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
