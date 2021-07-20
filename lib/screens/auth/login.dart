import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/actions/hasherAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/logo.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/screens/auth/forgetPassword.dart';
import 'package:hasher/screens/auth/signUpPersonal.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
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
        loginAction(email, password).then((result) {
          log(result.status);
          if (result.status == 'success') {
            basicHasherInfo(email).then((hasher) {
              log(hasher.status);
              if (hasher.status == 'success') {
                // close modal and show message
                SmartDialog.dismiss();
                showMessage("Successfully Logged in: " + email);

                // redirect
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(hashes: hasher.hashes),
                    ));
              } else {
                SmartDialog.dismiss();
                showMessage("Unknow error occurred!");
              }
              return hasher;
            });
          } else {
            _controllerPassword.clear();
            SmartDialog.dismiss();
            showMessage("Email or Password incorrect!");
          }
        });
      } catch (e) {
        SmartDialog.dismiss();
        showMessage("Can not connect to the internet!");
      }
    }
  }

  _initScreen() {
    SharedPreferences.getInstance().then((prefs) {
      int id = prefs.getInt(PREF_HASHER_ID) ?? 0;
      if (id > 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initScreen();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPersonal()));
                      },
                    ),
                  )
                ],
              ),
            )),
        onWillPop: () async {
          // redirect
          showAlertDialog(
            context: context,
            title: 'Are you sure?',
            description: 'Are you sure to close this app.',
            left: 'Yes',
            onLeft: () {
              SystemNavigator.pop();
            },
            right: 'No',
            onRight: () {},
          );
          return false;
        });
  }
}
