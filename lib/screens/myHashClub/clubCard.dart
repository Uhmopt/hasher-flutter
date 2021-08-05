import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/components/checkBox.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/labelText.dart';
import 'package:hasher/screens/myHashClub/editClub.dart';
import 'package:hasher/screens/myHashClub/runDetails.dart';

// ignore: must_be_immutable
class ClubCard extends StatefulWidget {
  Hash? hash = Hash();
  ClubCard({Key? key, this.hash}) : super(key: key);

  @override
  _ClubCardState createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  _handleEdit() {
    int id = widget.hash!.clubid;
    if (id > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditClub(hash: widget.hash ?? new Hash())));
    } else {
      showMessage('This club does not exist.\nLog out and try again.');
    }
  }

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
                  LabelText(label: 'Joined On', value: widget.hash!.rundate),
                  LabelText(
                      label: 'You have done',
                      value: widget.hash!.total_runs.toString() + ' Runs'),
                  LabelText(label: 'Run Area', value: widget.hash!.run_area),
                  LabelText(label: 'Country', value: widget.hash!.country),
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
                        child: IconButton(
                          onPressed: _handleEdit,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                            size: 30,
                          ),
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
                        value: widget.hash!.follow,
                        onChanged: (v) {},
                      ))
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunDetails(hash: widget.hash),
                        ));
                  },
                  child: Text(
                    'Next Run',
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
