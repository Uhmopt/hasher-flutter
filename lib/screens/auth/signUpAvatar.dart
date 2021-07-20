import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/actions/profileAction.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/screens/auth/login.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String page_title = 'Sign Up';

class SignupAvatar extends StatefulWidget {
  SignupAvatar({Key? key}) : super(key: key);

  @override
  _SignupAvatarState createState() => _SignupAvatarState();
}

class _SignupAvatarState extends State<SignupAvatar> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _avatarImage;
  String? _oldPath;

  _handleTakeCameraPhoto() async {
    try {
      final _pickedImage = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _avatarImage = _pickedImage;
      });
    } catch (e) {
      setState(() {
        _avatarImage = null;
      });
      showMessage("Can not connect to camera!");
    }
  }

  _handleTakeGalleryPhoto() async {
    try {
      final _pickedImage = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _avatarImage = _pickedImage;
      });
    } catch (e) {
      setState(() {
        _avatarImage = null;
      });
      showMessage("Can not open gallery!");
    }
  }

  _handleUpload() {
    if (_avatarImage == null) {
      showMessage("Please Take a photo.");
      return;
    }
    showLoading();
    SharedPreferences.getInstance().then((prefs) {
      int id = prefs.getInt(PREF_HASHER_ID) ?? 0;
      String email = prefs.getString(PREF_EMAIL) ?? '';
      String password = prefs.getString(PREF_PASSWORD) ?? '';
      if (id > 0) {
        updateProfile(
          id: id,
          first: prefs.getString(PREF_HASHER_FIRST_NAME),
          last: prefs.getString(PREF_HASHER_LAST_NAME),
          hash: prefs.getString(PREF_HASHER_NAME),
          email: email,
          phone: prefs.getString(PREF_HASHER_PHONE),
          birth: prefs.getString(PREF_HASHER_BIRTH),
          firstrun: prefs.getString(PREF_HASHER_FIRST_RUN),
          base64image: base64Encode(
              File(_avatarImage!.path.toString()).readAsBytesSync()),
        ).then((resilt) {
          if (resilt.status == 'success') {
            loginAction(email, password).then((value) {
              SmartDialog.dismiss();
              showMessage('Successfully uploaded');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            });
          } else {
            SmartDialog.dismiss();
            showMessage("An unknow error occoured. ( save photo )");
          }
        });
      }
      SmartDialog.dismiss();
      showMessage("Destoryed Session.\nPlease log in again.");
      // redirect to login
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return true;
    });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _oldPath = prefs.getString(PREF_HASHER_AVATAR);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(page_title),
            ),
            body: ListView(
              padding: const EdgeInsets.only(left: 10, right: 10),
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Center(
                        child: Avatar(
                      src: _avatarImage == null
                          ? _oldPath ?? ''
                          : _avatarImage!.path.toString(),
                      size: 250,
                    ))),
                TextButton(
                    onPressed: _handleTakeCameraPhoto,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 40,
                              )),
                          Text(
                            'Photo to Camera',
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ])),
                TextButton(
                    onPressed: _handleTakeGalleryPhoto,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                              )),
                          Text(
                            'Photo to Storage',
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ])),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    child: Text(
                      'Upload',
                      textScaleFactor: 1.4,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _handleUpload,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    child: Text(
                      "Upload photo later",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          // redirect
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
          return false;
        });
  }
}
