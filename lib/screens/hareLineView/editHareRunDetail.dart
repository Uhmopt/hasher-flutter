import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/runDetailAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/hareLineView/editHareRunDetailContent.dart';

// ignore: must_be_immutable
class EditHareRunDetail extends StatefulWidget {
  EditHareRunDetail({Key? key, required this.run, this.clubname = ''})
      : super(key: key);
  Run run = new Run();
  String clubname = "";

  @override
  _EditHareRunDetailState createState() => _EditHareRunDetailState();
}

class _EditHareRunDetailState extends State<EditHareRunDetail> {
  RunDetail _runDetail = RunDetail();
  bool _isLoaded = false;

  _init() {
    showLoading();
    getRunDetail(
      club: widget.clubname,
      email: widget.run.email,
      hashrunid: widget.run.hashrunid,
    ).then((value) {
      setState(() {
        _runDetail = value;
        _isLoaded = true;
      });
      SmartDialog.dismiss();
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
      title: 'Add Run Detail',
      body: _isLoaded
          ? EditHareRunDetailContent(
              run: widget.run,
              clubname: widget.clubname,
              runDetail: _runDetail,
            )
          : Container(
              child: Text(MSG_LOADING),
            ),
    );
  }
}
