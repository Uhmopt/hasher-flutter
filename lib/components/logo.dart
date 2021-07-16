import 'package:flutter/cupertino.dart';

class Logo extends StatefulWidget {
  final double size;
  Logo({Key? key, required this.size}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('images/logo.png',
          width: widget.size, height: widget.size, fit: BoxFit.cover),
    );
  }
}
