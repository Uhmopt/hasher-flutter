import 'package:flutter/cupertino.dart';
import 'package:hasher/myHashClub/clubCard.dart';

class MyHashClub extends StatefulWidget {
  MyHashClub({Key? key}) : super(key: key);

  @override
  _MyHashClubState createState() => _MyHashClubState();
}

class _MyHashClubState extends State<MyHashClub> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [ClubCard()],
      ),
    );
  }
}
