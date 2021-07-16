import 'package:flutter/material.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/config.dart';
import 'package:hasher/layouts/drawer.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: [
          Container(
              padding: const EdgeInsets.all(10),
              child: InternalAvatar(size: 40))
        ]),
        body: widget.body,
        drawer: HashDrawer(),
      ),
    );
  }
}