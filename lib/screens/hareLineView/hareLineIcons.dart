import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/hasherIcon.dart';

class HareLineIcons extends StatefulWidget {
  HareLineIcons({Key? key}) : super(key: key);

  @override
  _HareLineIconsState createState() => _HareLineIconsState();
}

class _HareLineIconsState extends State<HareLineIcons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.indigoAccent,
        child: Container(
            padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HasherIcon(
                  icon: Icons.arrow_back_ios,
                ),
                HasherIcon(
                  icon: Icons.event_available,
                ),
                HasherIcon(
                  icon: Icons.directions_run,
                ),
                HasherIcon(
                  icon: Icons.adb,
                ),
                HasherIcon(
                  icon: Icons.edit,
                ),
                HasherIcon(
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            )),
      ),
    );
  }
}
