import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/hasherIcon.dart';
import 'package:hasher/components/iconText.dart';

// ignore: must_be_immutable
class HareLineRunCard extends StatefulWidget {
  HareLineRunCard({Key? key, this.run, this.editable = false})
      : super(key: key);
  Run? run = new Run();
  bool editable = false;

  @override
  _HareLineRunCardState createState() => _HareLineRunCardState();
}

class _HareLineRunCardState extends State<HareLineRunCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        elevation: 10,
        color: Colors.white,
        onPressed: () {},
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        IconText(
                          icon: Icons.event_available,
                          text: (widget.run?.rundate ?? '') +
                              ' ' +
                              (widget.run?.runtime ?? ''),
                        ),
                        IconText(
                          icon: Icons.adb,
                          text: widget.run?.hashname ?? '',
                        ),
                        IconText(
                          icon: Icons.directions_run,
                          text: widget.run?.runnumber ?? '',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: widget.editable
                        ? HasherIcon(
                            icon: Icons.edit,
                            color: Colors.indigoAccent,
                          )
                        : Container(),
                  )
                ])),
      ),
    );
  }
}
