import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hash_name/actions/authAction.dart';
import 'package:hash_name/config.dart';
import 'package:hash_name/helper/helpers.dart';
import 'package:hash_name/login.dart';

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

  _handleTakeCameraPhoto() {}

  _handleSubmit() {
    if (_signUpForm.currentState!.validate()) {
      signUpAction(
        _controllerFirst.text,
        _controllerLast.text,
        _controllerHash.text,
        _controllerEmail.text,
        _controllerPhone.text,
        _controllerBirth.text,
        _controllerFirstrun.text,
        _controllerPassword.text,
        defaultAvatar,
      ).then((value) {
        if (value.status == "fail") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Sign up Failed!")));
          return value;
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Successfully signed!")));
        return value;
      });
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
                  child: Image.asset('images/profile.jpg',
                      width: 100, height: 100, fit: BoxFit.cover),
                )),
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
                        onPressed: () {},
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
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
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
                      keyboardType: TextInputType.datetime,
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
