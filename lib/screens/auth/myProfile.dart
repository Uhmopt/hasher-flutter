import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/profileAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<FormState> _signUpPersonalForm = GlobalKey<FormState>();
  TextEditingController _controllerFirst = TextEditingController(text: '');
  TextEditingController _controllerLast = TextEditingController(text: '');
  TextEditingController _controllerHash = TextEditingController(text: '');
  TextEditingController _controllerEmail = TextEditingController(text: '');
  TextEditingController _controllerPhone = TextEditingController(text: '');
  TextEditingController _controllerBirth = TextEditingController(text: '');
  TextEditingController _controllerFirstrun = TextEditingController(text: '');
  int id = 0;

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

  _handleSave() {
    if (_signUpPersonalForm.currentState!.validate()) {
      showLoading();
      try {
        updateProfileAction(
          id: id,
          first: _controllerFirst.text,
          last: _controllerLast.text,
          hash: _controllerHash.text,
          email: _controllerEmail.text,
          phone: _controllerPhone.text,
          birth: _controllerBirth.text,
          firstrun: _controllerFirstrun.text,
        ).then((value) {
          SmartDialog.dismiss();
          if (value.status == "fail") {
            showMessage("Update profile Failed!\nPlease log out and retry.");
            return;
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
            showMessage("Successfully updated your profile.");
          });
        });
      } catch (e) {
        SmartDialog.dismiss();
        showMessage("Can not connect to the internet!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getInt(PREF_HASHER_ID) ?? 0;
        _controllerFirst.text = prefs.getString(PREF_HASHER_FIRST_NAME) ?? '';
        _controllerLast.text = prefs.getString(PREF_HASHER_LAST_NAME) ?? '';
        _controllerHash.text = prefs.getString(PREF_HASHER_NAME) ?? '';
        _controllerEmail.text = prefs.getString(PREF_EMAIL) ?? '';
        _controllerPhone.text = prefs.getString(PREF_HASHER_PHONE) ?? '';
        _controllerBirth.text = prefs.getString(PREF_HASHER_BIRTH) ?? '';
        _controllerFirstrun.text = prefs.getString(PREF_HASHER_FIRST_RUN) ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: HashLayout(
            title: "My Profile",
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
                          readOnly: true,
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                      'Save',
                      textScaleFactor: 1.4,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _handleSave,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    ),
                  )),
                ),
              ],
            )),
        onWillPop: () async {
          // redirect
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          return false;
        });
  }
}
