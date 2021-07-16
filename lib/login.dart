import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/actions/hasherAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/logo.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/forgetPassword.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/home.dart';
import 'package:hasher/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();

  TextEditingController _controllerEmail = TextEditingController(text: '');
  TextEditingController _controllerPassword = TextEditingController(text: '');

  _handleSubmit() {
    if (_loginForm.currentState!.validate()) {
      showLoading();
      String email = _controllerEmail.text;
      String password = _controllerPassword.text;
      try {
        loginAction(email, password).then((value) {
          if (value.status == 'success') {
            SharedPreferences.getInstance().then((prefs) {
              prefs.setBool(PREF_AUTH, true).then((value) {
                log("logged in");
                basicHasherInfo(email).then((hasher) {
                  // save preferences
                  prefs.setString(PREF_HASHER, jsonEncode(hasher.toJson()));
                  prefs.setInt(PREF_HASHER_ID, hasher.id);
                  prefs.setString(PREF_HASHER_NAME, hasher.hashname);
                  prefs.setString(PREF_EMAIL, hasher.hashname);

                  // close modal and show message
                  SmartDialog.dismiss();
                  showMessage("Successfully Logged in: " + email);

                  // redirect
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                  return hasher;
                });
                return value;
              });
              return prefs;
            });
          } else {
            _controllerPassword.clear();
            showMessage("Email or Password incorrect!");
          }
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(appTitle),
        ),
        body: Form(
          key: _loginForm,
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: new Logo(size: 120)),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: _controllerEmail,
                  validator: (String? value) {
                    if (value == null || value.isEmpty || !checkEmail(value)) {
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
                child: TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
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
                padding: const EdgeInsets.only(bottom: 25),
                child: TextButton(
                  child: Text(
                    'Forget Password?',
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    log("Forgot password Clicked");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  child: Text(
                    'Sign In',
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
                child: TextButton(
                  child: Text(
                    "Don't have an account? Sign up",
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
