import 'package:flutter/material.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/layouts/drawer.dart';
import 'package:hasher/screens/auth/signUpAvatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HashLayout extends StatefulWidget {
  Widget body;
  String title;
  HashLayout({Key? key, required this.body, this.title = appTitle})
      : super(key: key);

  @override
  _HashLayoutState createState() => _HashLayoutState();
}

class _HashLayoutState extends State<HashLayout> {
  String _avatar = '';
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _avatar = prefs.getString(PREF_HASHER_AVATAR)!;
      });
      return prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupAvatar()));
                },
                child: Avatar(src: _avatar, size: 35)),
          )
        ]),
        body: widget.body,
        drawer: HashDrawer(),
      ),
    );
  }
}
