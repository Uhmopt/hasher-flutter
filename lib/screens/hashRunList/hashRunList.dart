import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/screens/hashRunList/hashRunListCard.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:hasher/screens/myHashClub/selectClubPart1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HashRunList extends StatefulWidget {
  HashRunList({Key? key}) : super(key: key);

  @override
  _HashRunListState createState() => _HashRunListState();
}

class _HashRunListState extends State<HashRunList> {
  List<Hash> _clubList = [];
  String _clubname = "";
  RunList _runList = new RunList();
  String _email = "";
  String _hashName = "";

  _loadRunList({Function callback = log, String club = ""}) {
    if (club.length == 0 && _clubname.length > 0) {
      club = _clubname;
    }
    showLoading();
    getRunList(email: _email, club: club).then((runList) {
      SmartDialog.dismiss();
      setState(() {
        _runList = runList;
      });
      callback(runList);
    });
  }

  _loadClubList({Function callback = log}) {
    showLoading();
    getMyHashes(_email).then((clubList) {
      SmartDialog.dismiss();
      if (clubList.status == 'success') {
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
        if (clubList?.status == 'success') {
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
    return WillPopScope(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              child: GestureDetector(
                  onTap: _loadRunList,
                  child: Text(
                    _hashName,
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                  )),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black38, width: 2))),
            ),
            _clubList.isEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: DropdownButton<String>(
                          hint: Text(
                              "My Hash Club" + _clubList.length.toString()),
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
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
            Container(
              child: Column(
                children: [
                  ...((_runList.runlist == null
                      ? [
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Card(
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: Text(
                                      "There is not existed Run of this club yet.",
                                      textScaleFactor: 1.3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )))
                        ]
                      : _runList.runlist!.map<Widget>((run) => HashRunListCard(
                            run: run,
                            clubname: _clubname,
                          ))))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectClubPart1(),
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Follow More Clubs",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        onWillPop: () async {
          // redirect
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          return false;
        });
  }
}
