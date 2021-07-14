import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

const String page_title = 'Forget Password';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(page_title),
          ),
          body: Form(
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
                    onPressed: () {
                      log('Clicked forget password / send button');
                    },
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
