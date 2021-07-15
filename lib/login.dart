import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/config.dart';
import 'package:hasher/forgetPassword.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/signUp.dart';

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
      loginAction(_controllerEmail.text, _controllerPassword.text)
          .then((value) {
        SmartDialog.dismiss();
        if (value.status == 'success') {
          _controllerPassword.clear();
          showMessage("Successfully Login: " + _controllerEmail.text);
        } else {
          _controllerPassword.clear();
          showMessage("Login Failed!");
        }
        return value;
      });
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
                  child: Center(
                    child: Image.asset('images/logo.png',
                        width: 120, height: 120, fit: BoxFit.cover),
                  )),
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
