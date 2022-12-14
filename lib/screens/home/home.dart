import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/auth/signUpAvatar.dart';
import 'package:hasher/screens/myHashClub/myHashClub.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  List<Hash>? hashes;
  bool isFirst = false;
  Home({Key? key, this.hashes, this.isFirst = false}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _initScreen() {
    if (widget.isFirst) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => showConfirmDialog(
            context: context,
            title: "Alert",
            description: "Would you like to upload your photo?",
            left: 'Go to Upload',
            onLeft: () {
              // redirect to login
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupAvatar()));
            },
            right: 'SKIP',
            onRight: () {}),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initScreen();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: HashLayout(
            title: 'My Hash Clubs', body: MyHashClub(hashes: widget.hashes)),
        onWillPop: () async {
          // redirect
          return showConfirmDialog(
            context: context,
            title: 'Are you sure?',
            // description: 'Are you sure to log out from this app.',
            description: 'Are you sure to close this app.',
            left: 'Yes',
            onLeft: () {
              SharedPreferences.getInstance().then((prefs) {
                // prefs.clear();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Login(),
                //     ));
                SystemNavigator.pop();
                return false;
              });
            },
            right: 'No',
            onRight: () {
              return false;
            },
          );
        });
  }
}
