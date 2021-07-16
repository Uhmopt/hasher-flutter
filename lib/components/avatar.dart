import 'dart:io';

import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Avatar extends StatefulWidget {
  String src = '';
  double size = 100;
  Avatar({Key? key, this.src = '', this.size = 100}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: (widget.src.length == 0)
          ? Image.asset('images/profile.jpg',
              width: widget.size, height: widget.size, fit: BoxFit.cover)
          : widget.src.contains('http')
              ? Image.network(widget.src,
                  width: widget.size, height: widget.size, fit: BoxFit.cover)
              : Image.file(File(widget.src),
                  width: widget.size, height: widget.size, fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(widget.size / 2),
    );
  }
}
