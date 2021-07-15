import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

showLoading() {
  SmartDialog.showLoading(
      widget: Container(
          width: 110,
          height: 110,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Center(
                  child: Image.asset(
                    'images/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.softLight,
                  ),
                ),
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
