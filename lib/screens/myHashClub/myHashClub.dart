import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hasherAction.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/screens/myHashClub/clubCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyHashClub extends StatefulWidget {
  List<Hash>? hashes;
  MyHashClub({Key? key, this.hashes}) : super(key: key);

  @override
  _MyHashClubState createState() => _MyHashClubState();
}

class _MyHashClubState extends State<MyHashClub> {
  String email = '';
  List<Hash>? _hashArray;
  init() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        email = prefs.getString(PREF_EMAIL)!;
      });
      return prefs;
    });
  }

  loadClubs() {
    if (widget.hashes == null) {
      SharedPreferences.getInstance().then((prefs) {
        String strEmail = prefs.getString(PREF_EMAIL)!;
        if (strEmail.length > 0) {
          showLoading();
          basicHasherInfo(strEmail).then((hashesResult) {
            if (hashesResult.status == 'success') {
              setState(() {
                _hashArray = hashesResult.hashes;
              });
              SmartDialog.dismiss();
            } else {
              SmartDialog.dismiss();
              showMessage("Unknow Error ( fetch data ).");
            }
            return hashesResult;
          });
        } else {
          SmartDialog.dismiss();
          showMessage("Session is destroied. Please Relog in and Retry.");
        }
        return prefs;
      });
    } else {
      setState(() {
        _hashArray = widget.hashes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    loadClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: TextButton(
              child: Text('reload'),
              onPressed: () {
                loadClubs();
              },
            ),
          ),
          ...(_hashArray == null
              ? []
              : _hashArray!.map<Widget>((item) {
                  return ClubCard(
                    hash: item,
                  );
                }).toList()),
        ],
      ),
    );
  }
}
