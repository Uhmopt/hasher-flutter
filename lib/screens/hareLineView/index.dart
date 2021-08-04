import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/hareLineView/hareLineViewContent.dart';
import 'package:hasher/screens/home/home.dart';

class HareLineView extends StatefulWidget {
  HareLineView({Key? key}) : super(key: key);

  @override
  _HareLineViewState createState() => _HareLineViewState();
}

class _HareLineViewState extends State<HareLineView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: HashLayout(title: 'Hare Line View', body: HareLineViewContent()),
        onWillPop: () async {
          // redirect
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
          return false;
        });
  }
}
