import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutoComplete extends StatefulWidget {
  AutoComplete({Key? key, this.label, this.icon, this.options, this.onSelected})
      : super(key: key);

  String? label = '';
  IconData? icon = Icons.text_fields;
  List<String>? options = [];
  Function(String)? onSelected = (str) {};

  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (str) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: Icon(widget.icon),
            isDense: true,
          ),
        );
      },
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return [];
        }

        return widget.options!.where((country) =>
            country.toLowerCase().contains(value.text.toLowerCase()));
      },
      onSelected: widget.onSelected,
    );
  }
}
