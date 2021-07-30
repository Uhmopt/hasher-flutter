import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/clubsAction.dart';
import 'package:hasher/actions/countryAction.dart';
import 'package:hasher/components/autoComplete.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/myHashClub/createClub.dart';
import 'package:hasher/screens/myHashClub/selectClubPart2.dart';

class SelectClubPart1 extends StatefulWidget {
  SelectClubPart1({Key? key}) : super(key: key);

  @override
  _SelectClubPart1State createState() => _SelectClubPart1State();
}

class _SelectClubPart1State extends State<SelectClubPart1> {
  final GlobalKey<FormState> _selectClubForm = GlobalKey<FormState>();
  List<String> _countries = [];
  List<String> _clubs = [];
  String _country = '';
  String _club = '';

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

  _handleNext() {
    if (_selectClubForm.currentState!.validate()) {
      if (_country.isEmpty) {
        showMessage("Please select valid Country.");
        return;
      }
      if (_club.isEmpty) {
        showMessage("Please select valid Current Hash.");
        return;
      }

      // redirect
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SelectClubPart2(country: _country, club: _club),
          ));
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateClub(),
                  ));
            },
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
          child: ElevatedButton(
            onPressed: _handleNext,
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
