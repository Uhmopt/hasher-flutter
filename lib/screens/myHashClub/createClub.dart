import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/clubsAction.dart';
import 'package:hasher/actions/countryAction.dart';
import 'package:hasher/components/autoComplete.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/layouts/index.dart';

class CreateClub extends StatefulWidget {
  CreateClub({Key? key}) : super(key: key);

  @override
  _CreateClubState createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  final GlobalKey<FormState> _createClubForm = GlobalKey<FormState>();
  List<String> _countries = [];
  String _country = "";
  TextEditingController _textRunArea = new TextEditingController();
  TextEditingController _textClubName = new TextEditingController();
  TextEditingController _textFirstRun = new TextEditingController();
  TextEditingController _textCurrentRunNumber = new TextEditingController();
  TextEditingController _textRunDate = new TextEditingController();

  _init() {
    showLoading();
    getCountries().then((countries) {
      SmartDialog.dismiss();
      setState(() {
        _countries = countries;
      });
    });
  }

  Future _selectDate(TextEditingController tc) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());
    if (picked != null)
      setState(() => tc.text = picked.year.toString() +
          '-' +
          picked.month.toString().padLeft(2, '0') +
          '-' +
          picked.day.toString().padLeft(2, '0'));
  }

  _handleCreate() {
    if (_country.isEmpty) {
      showMessage("Please Select a valid country.");
      return;
    }
    if (_createClubForm.currentState!.validate()) {
      showLoading();
      createClub(
              country: _country,
              runarea: _textRunArea.text,
              clubname: _textClubName.text,
              firstrun: _textFirstRun.text,
              currunnum: _textCurrentRunNumber.text,
              rundate: _textRunDate.text)
          .then((result) {
        SmartDialog.dismiss();
        if (result.status == SUCCESS) {
          showMessage("Successfully Created!");
          Navigator.pop(context);
        } else {
          showMessage("Can not Create the hash club.");
        }
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
        title: 'Create Hash Club',
        body: Form(
            key: _createClubForm,
            child: Container(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AutoComplete(
                      label: 'Country',
                      icon: Icons.language,
                      options: _countries,
                      onSelected: (value) {
                        setState(() {
                          _country = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _textRunArea,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Run Area';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Run Area",
                        prefixIcon: Icon(Icons.gps_fixed),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _textClubName,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Hash Club Name.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Hash Club Name",
                        prefixIcon: Icon(Icons.add_circle),
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show Date Picker Here
                        _selectDate(_textFirstRun);
                      },
                      controller: _textFirstRun,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter First Run';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "First Run",
                        prefixIcon: Icon(Icons.date_range),
                        isDense: true,
                      ),
                      enableInteractiveSelection: false,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _textCurrentRunNumber,
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
                      inputFormatters: inputNumberFormatter,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show Date Picker Here
                        _selectDate(_textRunDate);
                      },
                      controller: _textRunDate,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Run Date';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Run Date",
                        prefixIcon: Icon(Icons.date_range),
                        isDense: true,
                      ),
                      enableInteractiveSelection: false,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: _handleCreate,
                      child: Text(
                        'Add Club',
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15))),
                    ),
                  )
                ],
              ),
            )));
  }
}
