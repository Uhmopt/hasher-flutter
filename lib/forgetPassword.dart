import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/helper/helpers.dart';

const String page_title = 'Forget Password';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _forgetPasswordForm = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController(text: '');

  _handleSubmit() {
    if (_forgetPasswordForm.currentState!.validate()) {
      forgotAction(_controllerEmail.text).then((value) {
        if (value.status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Password Resetted! You will receive an email: " +
                  _controllerEmail.text)));
          return value;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please enter a valid email!")));
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
                      fontWeight: FontWeight.bold, color: Colors.indigoAccent),
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
                      'Send',
                      textScaleFactor: 1.4,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _handleSubmit,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
