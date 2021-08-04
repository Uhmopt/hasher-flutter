import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/screens/hareLineView/hareLineRunCard.dart';

// ignore: must_be_immutable
class HareLineRunList extends StatefulWidget {
  HareLineRunList({Key? key, this.runList, this.hashname = ''})
      : super(key: key);
  List<Run>? runList = [];
  String hashname = "";

  @override
  _HareLineRunListState createState() => _HareLineRunListState();
}

class _HareLineRunListState extends State<HareLineRunList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...(((widget.runList == null || widget.runList!.isEmpty)
              ? [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Card(
                          elevation: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            width: double.infinity,
                            child: Text(
                              "There is not existed Run of this club yet.",
                              textScaleFactor: 1.3,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )))
                ]
              : widget.runList!.map<Widget>((run) => HareLineRunCard(
                  run: run, editable: (widget.hashname == run.hashname)))))
        ],
      ),
    );
  }
}
