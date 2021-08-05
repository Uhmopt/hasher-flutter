import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/config.dart';
import 'package:multiselect/multiselect.dart';

// ignore: must_be_immutable
class TextDropDownMulti extends StatefulWidget {
  TextDropDownMulti({
    Key? key,
    required this.onSelect,
    required this.options,
    required this.selected,
    this.hint = '',
    this.label = '',
  }) : super(key: key);
  Function(List<String>) onSelect;
  List<String> options = [];
  List<String> selected = [];
  String hint = "";
  String label = "";

  @override
  _TextDropDownMultiState createState() => _TextDropDownMultiState();
}

class _TextDropDownMultiState extends State<TextDropDownMulti> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropDownMultiSelect(
        onChanged: widget.onSelect,
        options: widget.options,
        selectedValues: widget.selected,
        // whenEmpty: widget.hint,
        whenEmpty: '',
        decoration: InputDecoration(
          labelText: widget.label,
          // prefixIcon: Icon(Icons.menu),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
          ),
          contentPadding: const EdgeInsets.only(left: 20, right: 15),
        ),
      ),
    );
  }
}
