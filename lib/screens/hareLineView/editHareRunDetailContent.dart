import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/screens/hareLineView/editHareRunDetailForm.dart';

// ignore: must_be_immutable
class EditHareRunDetailContent extends StatefulWidget {
  EditHareRunDetailContent(
      {Key? key, required this.run, this.clubname = '', this.committee})
      : super(key: key);
  Run run = new Run();
  String clubname = "";
  List<String>? committee = [];

  @override
  _EditHareRunDetailContentState createState() =>
      _EditHareRunDetailContentState();
}

class _EditHareRunDetailContentState extends State<EditHareRunDetailContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Card(
            elevation: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.clubname,
                textAlign: TextAlign.center,
                textScaleFactor: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.pinkAccent),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: EditHareRunDetailForm(
            run: widget.run,
            clubname: widget.clubname,
          ),
        ),
      ],
    );
  }
}
