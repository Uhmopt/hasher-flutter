import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/components/logo.dart';
import 'package:hasher/constant.dart';

showLoading() {
  SmartDialog.showLoading(
      widget: Container(
          width: 110,
          height: 110,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Logo(size: 100),
              ),
              OverlayEntry(
                builder: (context) => Container(
                  child: CircularProgressIndicator(),
                  width: 110,
                  height: 110,
                ),
              )
            ],
          )));
}

showMessage(String message) {
  SmartDialog.showToast(message);
}

showAlertDialog({
  required BuildContext context,
  String title = '',
  String description = '',
  String left = '',
  String right = '',
  dynamic Function() onLeft = DEFAULT_FUNCTION,
  dynamic Function() onRight = DEFAULT_FUNCTION,
}) {
  // set up the buttons
  Widget leftButton = TextButton(
    child: Text(left),
    onPressed: () {
      onLeft();
      Navigator.pop(context);
    },
  );
  Widget rightButton = TextButton(
    child: Text(right),
    onPressed: () {
      onRight();
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      leftButton,
      rightButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
