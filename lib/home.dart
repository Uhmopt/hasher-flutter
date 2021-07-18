import 'package:flutter/material.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/myHashClub/myHashClub.dart';

class Home extends StatefulWidget {
  List<Hash>? hashes;
  Home({Key? key, this.hashes}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HashLayout(
        title: 'My Hash Clubs', body: MyHashClub(hashes: widget.hashes));
  }
}
