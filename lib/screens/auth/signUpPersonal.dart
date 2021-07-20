import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/screens/auth/login.dart';
import 'package:hasher/screens/auth/signUpPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String page_title = 'Sign Up (Personal details)';

class SignupPersonal extends StatefulWidget {
  SignupPersonal({Key? key}) : super(key: key);

  @override
  _SignupPersonalState createState() => _SignupPersonalState();
}

class _SignupPersonalState extends State<SignupPersonal> {
  final GlobalKey<FormState> _signUpPersonalForm = GlobalKey<FormState>();
  TextEditingController _controllerFirst = TextEditingController(text: '');
  TextEditingController _controllerLast = TextEditingController(text: '');
  TextEditingController _controllerHash = TextEditingController(text: '');
  TextEditingController _controllerEmail = TextEditingController(text: '');
  TextEditingController _controllerPhone = TextEditingController(text: '');
  TextEditingController _controllerBirth = TextEditingController(text: '');
  TextEditingController _controllerFirstrun = TextEditingController(text: '');

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

  _handleNext() {
    if (_signUpPersonalForm.currentState!.validate()) {
      showLoading();
      try {
        signUpAction(
          _controllerFirst.text,
          _controllerLast.text,
          _controllerHash.text,
          _controllerEmail.text,
          _controllerPhone.text,
          _controllerBirth.text,
          _controllerFirstrun.text,
          DEFAULT_PASSWORD,
          '',
        ).then((value) {
          SmartDialog.dismiss();
          if (value.status == "fail") {
            showMessage("Sign up Failed!");
          }
          if (value.status == "already") {
            showMessage('You may already have an account with us.\n' +
                'A user with this email address already exists.\n' +
                'Try resetting your password or check your email spelling.');
          }
          // set preference
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString(PREF_HASHER_FIRST_NAME, _controllerFirst.text);
            prefs.setString(PREF_HASHER_LAST_NAME, _controllerLast.text);
            prefs.setString(PREF_HASHER_NAME, _controllerHash.text);
            prefs.setString(PREF_EMAIL, _controllerEmail.text);
            prefs.setString(PREF_HASHER_PHONE, _controllerPhone.text);
            prefs.setString(PREF_HASHER_BIRTH, _controllerBirth.text);
            prefs.setString(PREF_HASHER_FIRST_RUN, _controllerFirstrun.text);

            // redirect to login
            showMessage("Successfully signed up! \n Please Set New Password.");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupPassword()));
          });
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
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(page_title),
          ),
          body: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              Form(
                key: _signUpPersonalForm,
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: (ElevatedButton(
                  child: Text(
                    'Next',
                    textScaleFactor: 1.4,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _handleNext,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  ),
                )),
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
