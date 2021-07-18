import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/components/blueLabelText.dart';
import 'package:hasher/components/checkBox.dart';

// ignore: must_be_immutable
class ClubCard extends StatefulWidget {
  Hash? hash = Hash();
  ClubCard({Key? key, this.hash}) : super(key: key);

  @override
  _ClubCardState createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Text(
                  widget.hash!.hashclubname,
                  textScaleFactor: 1.7,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                ),
              ),
              Column(
                children: [
                  BlueLabelText(
                      label: 'Joined On', value: widget.hash!.rundate),
                  BlueLabelText(
                      label: 'You have done',
                      value: widget.hash!.total_runs.toString() + ' Runs'),
                  BlueLabelText(
                      label: 'Run Area', value: widget.hash!.run_area),
                  BlueLabelText(label: 'Country', value: widget.hash!.country),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Role',
                        textScaleFactor: 1.7,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: CheckBoxLabel(
                        label: 'Current Hash',
                        value: widget.hash!.current,
                        onChanged: (v) {},
                      )),
                  Expanded(
                      flex: 4,
                      child: CheckBoxLabel(
                        label: 'Mother Hash',
                        value: widget.hash!.mother,
                        onChanged: (v) {},
                      ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: CheckBoxLabel(
                        label: 'Committee Member',
                        value: widget.hash!.committee,
                        onChanged: (v) {},
                      )),
                  Expanded(
                      flex: 4,
                      child: CheckBoxLabel(
                        label: 'Follow Hash',
                        value: widget.hash!.last,
                        onChanged: (v) {},
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
