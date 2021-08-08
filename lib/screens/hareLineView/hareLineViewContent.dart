import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/checkBox.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/screens/hareLineView/hareLineIcons.dart';
import 'package:hasher/screens/hareLineView/hareLineRunList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HareLineViewContent extends StatefulWidget {
  HareLineViewContent({Key? key}) : super(key: key);

  @override
  _HareLineViewContentState createState() => _HareLineViewContentState();
}

class _HareLineViewContentState extends State<HareLineViewContent> {
  List<Hash> _clubList = [];
  String _clubname = "";
  String _email = "";
  String _hashName = "";
  bool _isPrevious = false;
  HareRunList _runList = new HareRunList();

  _loadRunList({Function callback = log, String club = ""}) {
    if (club.length == 0 && _clubname.length > 0) {
      club = _clubname;
    }
    showLoading();
    getHareRunList(club: club).then((hareRunList) {
      SmartDialog.dismiss();
      setState(() {
        _runList = hareRunList;
      });
      callback(hareRunList);
    });
  }

  _loadClubList({Function callback = log}) {
    showLoading();
    getMyHashes(_email).then((clubList) {
      SmartDialog.dismiss();
      if (clubList.status == SUCCESS) {
        setState(() {
          _clubList = clubList.hashes ?? [];
          _clubname = clubList.hashes![0].hashclubname;
        });
        callback(clubList);
      }
      callback(false);
    });
  }

  _init() {
    showLoading();
    SharedPreferences.getInstance().then((prefs) {
      SmartDialog.dismiss();
      String email = prefs.getString(PREF_EMAIL) ?? '';
      String hashName = prefs.getString(PREF_HASHER_NAME) ?? '';
      setState(() {
        _email = email;
        _hashName = hashName;
      });
      _loadClubList(callback: (clubList) {
        if (clubList?.status == SUCCESS) {
          _loadRunList(club: clubList?.hashes[0]?.hashclubname ?? '');
        }
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
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: _clubList.isEmpty
              ? Container(
                  child: Text(MSG_CONNECTING),
                )
              : Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: DropdownButton<String>(
                        hint: Text("My Hash Club"),
                        items: (_clubList.isEmpty ? [] : _clubList)
                            .map((club) => DropdownMenuItem<String>(
                                value: (club.hashclubname).toString(),
                                child: Text(club.hashclubname)))
                            .toList(),
                        value: _clubname.isEmpty
                            ? _clubList[0].hashclubname.toString()
                            : _clubname,
                        onChanged: (value) {
                          setState(() {
                            _clubname = value ?? '';
                          });
                          _loadRunList(club: value ?? '');
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.black45),
                          borderRadius:
                              BorderRadius.all(Radius.circular(BORDER_RADIUS)),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: CheckBoxLabel(
            value: _isPrevious,
            onChanged: (v) {
              setState(() {
                _isPrevious = v ?? false;
              });
            },
            label: "Enable Previous Runs",
            labelColor: Colors.pinkAccent,
            checkColor: Colors.pinkAccent,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: HareLineIcons(),
        ),
        Container(
            child: HareLineRunList(
                runList: (_runList.hares ?? []).where((run) {
                  if (_isPrevious) {
                    return true;
                  }
                  DateTime t = DateTime.parse(run.rundate);
                  return t.isAfter(DateTime.now());
                }).toList(),
                committee: _runList.committee,
                hashname: _hashName,
                clubname: _clubname))
      ],
    );
  }
}
