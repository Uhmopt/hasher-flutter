import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/screens/auth/login.dart';

const String page_title = 'Forget Password';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _forgetPasswordForm = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController(text: '');
  bool _isReset = false;

  _handleSubmit() {
    if (_isReset) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      return;
    }
    if (_forgetPasswordForm.currentState!.validate()) {
      showLoading();
      try {
        forgotAction(_controllerEmail.text).then((value) {
          SmartDialog.dismiss();
          if (value.status == 'success') {
            showMessage("Password reset email has been sent to " +
                _controllerEmail.text);
            setState(() {
              _isReset = true;
            });
            return value;
          }
          showMessage("Please enter a valid email!");
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
    return WillPopScope(
        child: Container(
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(page_title),
              ),
              body: Form(
                key: _forgetPasswordForm,
                child: ListView(
                  padding: const EdgeInsets.all(32),
                  children: [
                    Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Image.asset('images/logo.png',
                              width: 150, height: 150, fit: BoxFit.cover),
                        )),
                    Text(
                      'Please enter your email address.',
                      textScaleFactor: 1.4,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigoAccent),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 50),
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
                      child: ElevatedButton(
                        child: Text(
                          _isReset ? 'CONTINUE' : 'RESET PASSWORD',
                          textScaleFactor: 1.4,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _handleSubmit,
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                        ),
                      ),
                    )
                  ],
                ),
              )),
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
