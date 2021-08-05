import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/actions/runDetailAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/labelText.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/layouts/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RunDetails extends StatefulWidget {
  RunDetails({Key? key, this.hash, this.hashRunId = 'next'}) : super(key: key);
  Hash? hash = new Hash();
  String hashRunId = 'next';

  @override
  _RunDetailsState createState() => _RunDetailsState();
}

class _RunDetailsState extends State<RunDetails> {
  String _email = '';
  RunDetail? _runDetail;
  _init() {
    showLoading();
    SharedPreferences.getInstance().then((prefs) {
      String email = prefs.getString(PREF_EMAIL) ?? '';
      setState(() {
        _email = email;
      });
      getRunDetail(
              club: widget.hash?.hashclubname ?? '',
              email: email,
              hashrunid: widget.hashRunId)
          .then((value) {
        setState(() {
          _runDetail = value;
        });
        SmartDialog.dismiss();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return HashLayout(
        title: 'Run Detail',
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              child: Center(
                  child: Text(
                widget.hash?.hashclubname ?? '',
                textScaleFactor: 1.8,
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              )),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black45, width: 2))),
            ),
            // TextButton(onPressed: _init, child: Text('reload')),
            Container(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: (_runDetail?.rundate != '')
                        ? Column(
                            children: [
                              _runDetail?.hare.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "Hare",
                                      value: _runDetail?.hare ?? '',
                                    ),
                              _runDetail?.rundate.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "Run Date",
                                      value: _runDetail?.rundate ?? '',
                                    ),
                              _runDetail?.runtime.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "Run Time",
                                      value: _runDetail?.runtime ?? '',
                                    ),
                              _runDetail?.runnum.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "Run Number",
                                      value: _runDetail?.runnum ?? '',
                                    ),
                              _runDetail?.location.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "location",
                                      value: _runDetail?.location ?? '',
                                    ),
                              _runDetail?.direction.isEmpty ?? false
                                  ? Container()
                                  : LabelText(
                                      label: "direction",
                                      value: _runDetail?.direction ?? '',
                                    ),
                            ],
                          )
                        : Center(
                            child: Text(
                            "Not existed Mext Run yet...",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent),
                          )),
                  ),
                ))
          ],
        ));
  }
}
