import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';

// ignore: must_be_immutable
class TextDropDown extends StatefulWidget {
  TextDropDown(
      {Key? key,
      required this.options,
      this.hint = '',
      this.value = '',
      this.label = '',
      this.onChange})
      : super(key: key);
  List<String> options = [];
  String hint = '';
  String label = '';
  String value = '';
  Function(String?)? onChange;

  @override
  _TextDropDownState createState() => _TextDropDownState();
}

class _TextDropDownState extends State<TextDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.options.isEmpty
          ? Container(
              child: Text(MSG_CONNECTING),
            )
          : Container(
              child: InputDecorator(
                  decoration: InputDecoration(
                      labelText: widget.label,
                      prefixIcon: Icon(Icons.menu),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(BORDER_RADIUS))),
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton<String>(
                        // icon: Icon(Icons.list),

                        hint: Text(widget.hint),
                        items: (widget.options.isEmpty ? [] : widget.options)
                            .where((option) => option.toString().isNotEmpty)
                            .map((option) => DropdownMenuItem<String>(
                                value: (option).toString(),
                                child: Text(option)))
                            .toList(),
                        value: widget.value.isEmpty ? null : widget.value,
                        onChanged: widget.onChange,
                      ),
                      // decoration: ShapeDecoration(
                      //   shape: RoundedRectangleBorder(
                      //     side: BorderSide(
                      //         width: 1.0,
                      //         style: BorderStyle.solid,
                      //         color: Colors.black45),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(BORDER_RADIUS)),
                      //   ),
                      // ),
                    ),
                  )),
            ),
    );
  }
}
