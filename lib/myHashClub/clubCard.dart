import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/blueLabelText.dart';
import 'package:hasher/components/checkBox.dart';

class ClubCard extends StatefulWidget {
  ClubCard({Key? key}) : super(key: key);

  @override
  _ClubCardState createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Title',
                  textScaleFactor: 1.7,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                ),
              ),
              Column(
                children: [
                  BlueLabelText(label: 'Joined On', value: '01/01/2020'),
                  BlueLabelText(label: 'You have done', value: '2 Runs'),
                  BlueLabelText(
                      label: 'Run Area Country', value: 'Country Name'),
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
                        value: true,
                        onChanged: (v) {},
                      )),
                  Expanded(
                      flex: 4,
                      child: CheckBoxLabel(
                        label: 'Mother Hash',
                        value: true,
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
                        value: true,
                        onChanged: (v) {},
                      )),
                  Expanded(
                      flex: 4,
                      child: CheckBoxLabel(
                        label: 'Follow Hash',
                        value: true,
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
