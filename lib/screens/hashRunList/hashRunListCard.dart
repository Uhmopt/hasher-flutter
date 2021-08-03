import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/labelText.dart';

// ignore: must_be_immutable
class HashRunListCard extends StatefulWidget {
  Run? run = new Run();
  String clubname = "";
  HashRunListCard({Key? key, this.run, this.clubname = ""}) : super(key: key);

  @override
  _HashRunListCardState createState() => _HashRunListCardState();
}

class _HashRunListCardState extends State<HashRunListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 10,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              LabelText(
                label: "Hash Club Name:",
                labelSize: 5,
                value: widget.clubname,
                color: Colors.pinkAccent,
              ),
              LabelText(
                label: "Run Date:",
                labelSize: 5,
                value: (widget.run?.run_date ?? '') +
                    ' ' +
                    (widget.run?.run_time ?? ''),
                color: Colors.pinkAccent,
              ),
              LabelText(
                label: "Run Number:",
                labelSize: 5,
                value: widget.run?.run_number ?? '',
                color: Colors.pinkAccent,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Click for Moer Details",
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
