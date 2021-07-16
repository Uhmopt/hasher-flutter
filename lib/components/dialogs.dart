import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/components/logo.dart';

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
