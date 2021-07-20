import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/actions/profileAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/screens/auth/login.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String page_title = 'Sign Up ( Password )';

class SignupPassword extends StatefulWidget {
  SignupPassword({Key? key}) : super(key: key);

  @override
  _SignupPasswordState createState() => _SignupPasswordState();
}

class _SignupPasswordState extends State<SignupPassword> {
  String _email = '';
  final GlobalKey<FormState> _signUpPasswordForm = GlobalKey<FormState>();

  TextEditingController _controllerPassword = TextEditingController(text: '');
  TextEditingController _controllerPasswordConfirm =
      TextEditingController(text: '');

  _handleNext() {
    if (_signUpPasswordForm.currentState!.validate()) {
      showLoading();
      try {
        updatePassword(
                email: _email,
                oldpass: DEFAULT_PASSWORD,
                password: _controllerPassword.text)
            .then((value) {
          SmartDialog.dismiss();
          if (value.status == "fail") {
            showMessage("Failed!");
            return value;
          }
          showMessage("Successfully new password is setted! \nLoggin in...");
          // login
          showLoading();
          loginAction(_email, _controllerPassword.text).then((result) {
            SmartDialog.dismiss();
            if (result.status == 'success') {
              showMessage('Successfully Logged in.');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home(isFirst: true)));
            } else {
              showMessage('An unknown error occoured.');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }
            return result;
          });
          return value;
        });
      } catch (e) {
        SmartDialog.dismiss();
        showMessage("Can not connect to the internet!");
      }
    }
  }

  _initProfile() {
    SharedPreferences.getInstance().then((prefs) {
      String email = prefs.getString(PREF_EMAIL) ?? '';
      if (!checkEmail(email)) {
        showMessage("Can not read email!");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
      setState(() {
        _email = email;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initProfile();
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
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: [
                  Form(
                    key: _signUpPasswordForm,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25),
                          child: TextFormField(
                            controller: _controllerPassword,
                            obscureText: true,
                            validator: (String? value) {
                              if (value == null || !checkPassword(value)) {
                                return 'Password must contain at least one letter or number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                isDense: true,
                                hintText:
                                    "Must be 8 characters and must contain letters and numbers."),
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
                                return 'Confirm Password does not match';
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
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      child: Text(
                        'Next',
                        textScaleFactor: 1.4,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _handleNext,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          // redirect
          showMessage('Please select the passowrd!');
          return false;
        });
  }
}
