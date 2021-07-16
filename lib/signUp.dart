import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/components/avatar.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/config.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/login.dart';
import 'package:image_picker/image_picker.dart';

const String page_title = 'Sign Up';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _signUpForm = GlobalKey<FormState>();
  TextEditingController _controllerFirst = TextEditingController(text: '');
  TextEditingController _controllerLast = TextEditingController(text: '');
  TextEditingController _controllerHash = TextEditingController(text: '');
  TextEditingController _controllerEmail = TextEditingController(text: '');
  TextEditingController _controllerPhone = TextEditingController(text: '');
  TextEditingController _controllerBirth = TextEditingController(text: '');
  TextEditingController _controllerFirstrun = TextEditingController(text: '');
  TextEditingController _controllerPassword = TextEditingController(text: '');
  TextEditingController _controllerPasswordConfirm =
      TextEditingController(text: '');

  final ImagePicker _picker = ImagePicker();
  PickedFile? _avatarImage;

  Future _selectDate(TextEditingController tc) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());
    if (picked != null)
      setState(() => tc.text = picked.year.toString() +
          '-' +
          picked.month.toString() +
          '-' +
          picked.day.toString());
  }

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

  _handleSubmit() {
    showLoading();
    if (_signUpForm.currentState!.validate()) {
      try {
        signUpAction(
          _controllerFirst.text,
          _controllerLast.text,
          _controllerHash.text,
          _controllerEmail.text,
          _controllerPhone.text,
          _controllerBirth.text,
          _controllerFirstrun.text,
          _controllerPassword.text,
          (_avatarImage == null)
              ? defaultAvatar
              : base64Encode(
                  File(_avatarImage!.path.toString()).readAsBytesSync()),
        ).then((value) {
          SmartDialog.dismiss();
          if (value.status == "fail") {
            showMessage("Sign up Failed!");
            return value;
          }
          showMessage("Successfully signed up! Please Log in.");
          // redirect to login
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
          return value;
        });
      } catch (e) {
        SmartDialog.dismiss();
        showMessage("Can not connect to the internet!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(page_title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: [
            Container(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                    child: Avatar(
                  src:
                      _avatarImage == null ? '' : _avatarImage!.path.toString(),
                  size: 100,
                ))),
            Container(
              child: Wrap(
                // scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: TextButton(
                        onPressed: _handleTakeCameraPhoto,
                        child: Row(children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 40,
                          ),
                          Text(
                            'Photo to Camera',
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ])),
                  ),
                  Container(
                    child: TextButton(
                        onPressed: _handleTakeGalleryPhoto,
                        child: Row(children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                          ),
                          Text(
                            'Photo to Storage',
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ])),
                  )
                ],
              ),
            ),
            Form(
              key: _signUpForm,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerFirst,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter First Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerLast,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Last Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: Icon(Icons.person_outline),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerHash,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Hash Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Hash Name",
                        prefixIcon: Icon(Icons.person_pin),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerEmail,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !checkEmail(value)) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Icons.email),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerPhone,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Mobile Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        prefixIcon: Icon(Icons.phone),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show Date Picker Here
                        _selectDate(_controllerBirth);
                      },
                      controller: _controllerBirth,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Birthday';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Birthday",
                        prefixIcon: Icon(Icons.date_range),
                        isDense: true,
                      ),
                      enableInteractiveSelection: false,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show Date Picker Here
                        _selectDate(_controllerFirstrun);
                      },
                      controller: _controllerFirstrun,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter First Run Date';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "First Run Date",
                        prefixIcon: Icon(Icons.event),
                        isDense: true,
                      ),
                      enableInteractiveSelection: false,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerPassword,
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: _controllerPasswordConfirm,
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            _controllerPassword.text != value) {
                          return 'Confirm Password is not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                child: Text(
                  'Sign Up',
                  textScaleFactor: 1.4,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _handleSubmit,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                child: Text(
                  "Already have an account? Sign in",
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
