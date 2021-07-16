import 'dart:io';

import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class InternalAvatar extends StatefulWidget {
  String avatarUrl = '';
  double size = 100;
  InternalAvatar({Key? key, this.avatarUrl = '', this.size = 100})
      : super(key: key);

  @override
  _InternalAvatarState createState() => _InternalAvatarState();
}

class _InternalAvatarState extends State<InternalAvatar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: (widget.avatarUrl.length == 0)
          ? Image.asset('images/profile.jpg',
              width: widget.size, height: widget.size, fit: BoxFit.cover)
          : Image.file(File(widget.avatarUrl),
              width: widget.size, height: widget.size, fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(widget.size / 2),
    );
  }
}
