import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/clubsAction.dart';
import 'package:hasher/actions/countryAction.dart';
import 'package:hasher/components/autoComplete.dart';
import 'package:hasher/components/checkBox.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectClub extends StatefulWidget {
  SelectClub({Key? key}) : super(key: key);

  @override
  _SelectClubState createState() => _SelectClubState();
}

class _SelectClubState extends State<SelectClub> {
  final GlobalKey<FormState> _selectClubForm = GlobalKey<FormState>();
  List<String> _countries = [];
  List<String> _clubs = [];
  String _country = '';
  String _club = '';
  TextEditingController _textRuns = new TextEditingController();
  bool _isCurrent = false;
  bool _isMother = false;
  bool _isCommittee = false;
  bool _isFollow = false;

  _init() {
    showLoading();
    getCountries().then((countries) {
      SmartDialog.dismiss();
      setState(() {
        _countries = countries;
      });
    });
  }

  _initHash(String country) {
    showLoading();
    getClubNames(country).then((clubs) {
      SmartDialog.dismiss();
      setState(() {
        _clubs = clubs;
      });
    });
  }

  _handleSave() {
    if (_selectClubForm.currentState!.validate()) {
      String roles = (_isCurrent ? 'Current Hash,' : '') +
          (_isMother ? 'Mother Hash,' : '') +
          (_isFollow ? 'Follow This Hash Events,' : '') +
          (_isCommittee ? 'Committee Member,' : '');
      if (_country.isEmpty) {
        showMessage("Please select valid Country.");
        return;
      }
      if (_club.isEmpty) {
        showMessage("Please select valid Current Hash.");
        return;
      }
      showLoading();
      SharedPreferences.getInstance().then((prefs) {
        String email = prefs.getString(PREF_EMAIL) ?? '';
        selectClub(
                country: _country,
                curhashclub: _club,
                curtotalrun: _textRuns.text,
                email: email,
                roles: roles)
            .then((result) {
          SmartDialog.dismiss();
          if (result.status == 'success') {
            showMessage("Successfully selected");
            showConfirmDialog(
                context: context,
                title: 'Additional Club',
                description: 'Wold you like to?',
                left: 'Follow More Clubs',
                onLeft: () {
                  Navigator.pop(context);
                },
                right: 'Go to Main Menu',
                onRight: () {
                  // redirect
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                });
          } else {
            showMessage('Can not select this club.');
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return HashLayout(
        body: Form(
      key: _selectClubForm,
      child: ListView(children: [
        Container(
          child: AutoComplete(
            label: 'Country',
            icon: Icons.language,
            options: _countries,
            onSelected: (value) {
              setState(() {
                _country = value;
              });
              _initHash(value);
            },
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        Container(
          child: AutoComplete(
            label: 'Current Hash',
            icon: Icons.run_circle,
            options: _clubs,
            onSelected: (value) {
              setState(() {
                _club = value;
              });
            },
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "If you club is not listed, Click here.",
              textScaleFactor: 1.3,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(10))),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        Container(
          child: TextFormField(
            validator: (String? value) {
              if (value == null || !checkNumber(value)) {
                return 'Please inset correct number';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "Total Runs",
                prefixIcon: Icon(Icons.format_list_numbered),
                isDense: true,
                hintText: "Please input total Runs"),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CheckBoxLabel(
            value: _isCurrent,
            onChanged: (value) {
              setState(() {
                _isCurrent = value ?? false;
              });
            },
            label: 'Current Hash',
            labelColor: Colors.pinkAccent,
            textScaleFactor: 1.2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CheckBoxLabel(
            value: _isMother,
            onChanged: (value) {
              setState(() {
                _isMother = value ?? false;
              });
            },
            label: 'Mother Hash',
            labelColor: Colors.pinkAccent,
            textScaleFactor: 1.2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CheckBoxLabel(
            value: _isCommittee,
            onChanged: (value) {
              setState(() {
                _isCommittee = value ?? false;
              });
            },
            label: 'Committee Member',
            labelColor: Colors.pinkAccent,
            textScaleFactor: 1.2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CheckBoxLabel(
            value: _isFollow,
            onChanged: (value) {
              setState(() {
                _isFollow = value ?? false;
              });
            },
            label: 'Follow This Hash Events',
            labelColor: Colors.pinkAccent,
            textScaleFactor: 1.2,
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: _handleSave,
            child: Text(
              "Next",
              textScaleFactor: 1.3,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
          ),
          padding: const EdgeInsets.all(20),
        )
      ], padding: const EdgeInsets.all(20)),
    ));
  }
}
