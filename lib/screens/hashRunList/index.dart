import 'package:flutter/cupertino.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/hashRunList/hashRunList.dart';

const String pageTitle = 'Hash Run List';

class HashRunListPage extends StatefulWidget {
  HashRunListPage({Key? key}) : super(key: key);

  @override
  _HashRunListPageState createState() => _HashRunListPageState();
}

class _HashRunListPageState extends State<HashRunListPage> {
  @override
  Widget build(BuildContext context) {
    return HashLayout(title: pageTitle, body: HashRunList());
  }
}
