import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/hareLineView/editHareRunDetailContent.dart';
import 'package:hasher/screens/hareLineView/index.dart';

// ignore: must_be_immutable
class EditHareRunDetail extends StatefulWidget {
  EditHareRunDetail(
      {Key? key, required this.run, this.clubname = '', this.committee})
      : super(key: key);
  Run run = new Run();
  String clubname = "";
  List<String>? committee = [];

  @override
  _EditHareRunDetailState createState() => _EditHareRunDetailState();
}

class _EditHareRunDetailState extends State<EditHareRunDetail> {
  @override
  Widget build(BuildContext context) {
    return HashLayout(
      title: 'Add Run Detail',
      body: EditHareRunDetailContent(
        run: widget.run,
        clubname: widget.clubname,
        committee: widget.committee,
      ),
    );
  }
}
