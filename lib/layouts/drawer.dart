import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/layouts/menuButton.dart';
import 'package:hasher/screens/auth/login.dart';
import 'package:hasher/screens/auth/myProfile.dart';
import 'package:hasher/screens/auth/signUpAvatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HashDrawer extends StatefulWidget {
  HashDrawer({Key? key}) : super(key: key);
  @override
  _HashDrawerState createState() => _HashDrawerState();
}

class _HashDrawerState extends State<HashDrawer> {
  String _avatarPath = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      print(prefs);
      setState(() {
        _avatarPath = prefs.getString(PREF_HASHER_AVATAR)!;
      });
      return prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupAvatar()));
            },
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Avatar(
                  src: _avatarPath,
                ),
              ),
              color: Colors.indigoAccent,
            ),
          ),
          MenuButton(
            title: 'My Profile',
            icon: Icons.group,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  ));
            },
          ),
          MenuButton(
            title: 'Reset Password',
            icon: Icons.loop,
            onPressed: () {},
          ),
          MenuButton(
            title: 'Hash Run List',
            icon: Icons.directions_run,
            onPressed: () {},
          ),
          MenuButton(
            title: 'My Hash Clubs',
            icon: Icons.home,
            onPressed: () {},
          ),
          MenuButton(
            title: 'For Committe',
            icon: Icons.domain,
            onPressed: () {},
          ),
          MenuButton(
            title: 'Hare Line',
            icon: Icons.add_box,
            onPressed: () {},
          ),
          MenuButton(
            title: 'Change email',
            icon: Icons.cached,
            onPressed: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              });
            },
          ),
        ],
      ),
    );
  }
}
