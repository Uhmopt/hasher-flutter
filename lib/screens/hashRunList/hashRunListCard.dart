import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/labelText.dart';
import 'package:hasher/screens/hareLineView/editHareRunDetail.dart';
import 'package:hasher/screens/myHashClub/runDetails.dart';

// ignore: must_be_immutable
class HashRunListCard extends StatefulWidget {
  Run? run = new Run();
  String clubname = "";
  bool readOnly = true;
  HashRunListCard(
      {Key? key, this.run, this.clubname = "", this.readOnly = true})
      : super(key: key);

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
                value: (widget.run?.rundate ?? '') +
                    ' ' +
                    (widget.run?.runtime ?? ''),
                color: Colors.pinkAccent,
              ),
              LabelText(
                label: "Run Number:",
                labelSize: 5,
                value: widget.run?.runnumber ?? '',
                color: Colors.pinkAccent,
              ),
              widget.readOnly
                  ? Container()
                  : Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          "Add or Edit Details",
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditHareRunDetail(
                                  run: widget.run ?? Run(),
                                  clubname: widget.clubname,
                                ),
                              ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigoAccent)),
                      ),
                    ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Click for More Details",
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunDetails(
                            hash: new Hash(
                              hashclubname: widget.clubname,
                              rundate: (widget.run?.rundate ?? '') +
                                  ' ' +
                                  (widget.run?.runtime ?? ''),
                              total_runs:
                                  int.tryParse(widget.run?.runnumber ?? '') ??
                                      0,
                            ),
                            hashRunId: widget.run?.hashrunid ?? 'next',
                          ),
                        ));
                  },
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
