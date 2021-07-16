import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/layouts/menuButton.dart';

class HashDrawer extends StatelessWidget {
  const HashDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: InternalAvatar(),
            ),
            color: Colors.indigoAccent,
          ),
          MenuButton(
            title: 'My Profile',
            icon: Icons.group,
            onPressed: () {},
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
        ],
      ),
    );
  }
}
