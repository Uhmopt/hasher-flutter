import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/hareLineView/editHareLineContent.dart';
import 'package:hasher/screens/hareLineView/index.dart';

// ignore: must_be_immutable
class EditHareLine extends StatefulWidget {
  EditHareLine(
      {Key? key, required this.run, this.clubname = '', this.committee})
      : super(key: key);
  Run run = new Run();
  String clubname = "";
  List<String>? committee = [];

  @override
  _EditHareLineState createState() => _EditHareLineState();
}

class _EditHareLineState extends State<EditHareLine> {
  @override
  Widget build(BuildContext context) {
    return (WillPopScope(
        child: (HashLayout(
            title: 'Edit Hare Line',
            body: EditHareLineContent(
              run: widget.run,
              clubname: widget.clubname,
              committee: widget.committee,
            ))),
        onWillPop: () async {
          // redirect
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HareLineView(),
              ));
          return false;
        }));
  }
}
