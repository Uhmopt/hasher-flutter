import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hasher/actions/runDetailAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/locationPicker.dart';
import 'package:hasher/components/radioGroup.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';

// ignore: must_be_immutable
class EditHareRunDetailForm extends StatefulWidget {
  EditHareRunDetailForm({Key? key, required this.run, this.clubname = ''})
      : super(key: key);
  Run run = new Run();
  List<String> committee = [];
  String clubname = "";

  @override
  _EditHareRunDetailFormState createState() => _EditHareRunDetailFormState();
}

class _EditHareRunDetailFormState extends State<EditHareRunDetailForm> {
  final GlobalKey<FormState> _editHareRunDetailForm = GlobalKey<FormState>();
  TextEditingController _textRunNumber = new TextEditingController();
  TextEditingController _textRunDate = new TextEditingController();
  TextEditingController _textRunTime = new TextEditingController();
  TextEditingController _textRunDirections = new TextEditingController();
  TextEditingController _textRunFee = new TextEditingController();
  TextEditingController _textRunDescription = new TextEditingController();
  bool _isEdit = false;
  String _onon = '';
  LatLng _runLocation = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);
  LatLng _ononLocation = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);

  Future _selectDate(TextEditingController tc) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(tc.text),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now().add(const Duration(days: 3650)));
    if (picked != null)
      setState(() => tc.text = picked.year.toString() +
          '-' +
          picked.month.toString().padLeft(2, '0') +
          '-' +
          picked.day.toString().padLeft(2, '0'));
  }

  Future _selectTime(TextEditingController tc) async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(DateTime.parse('1970-01-01 ' + tc.text)),
    );
    if (picked != null)
      setState(() => tc.text = picked.hour.toString().padLeft(2, '0') +
          ':' +
          picked.minute.toString().padLeft(2, '0'));
  }

  _saveRunDetail() {
    if (_editHareRunDetailForm.currentState!.validate()) {
      if (_runLocation.latitude == DEFAULT_LATITUDDE &&
          _runLocation.longitude == DEFAULT_LONGITUDE) {
        showMessage(MSG_REQUIRE_RUN_LOCATION);
        return;
      }
      if (_ononLocation.latitude == DEFAULT_LATITUDDE &&
          _ononLocation.longitude == DEFAULT_LONGITUDE) {
        showMessage(MSG_REQUIRE_ONON_LOCATION);
        return;
      }
      if (_onon.isEmpty) {
        showMessage(MSG_REQUIRE_ONON);
        return;
      }
      showLoading();
      addRunDetail(
        club: widget.clubname,
        confirm: _textRunFee.text,
        direction: _textRunDirections.text,
        ondesc: _textRunDescription.text,
        rundate: _textRunDate.text,
        runtime: _textRunTime.text,
        runnumber: _textRunNumber.text,
        onon: (_onon == 'Yes').toString(),
        latitude: _runLocation.latitude.toString(),
        longitude: _runLocation.longitude.toString(),
      ).then((result) {
        SmartDialog.dismiss();
        if (result.status == SUCCESS) {
          showMessage(MSG_SAVED);
          Navigator.pop(context);
        } else {
          showMessage(MSG_NOT_SAVED);
        }
      });
    }
  }

  _initValues() {
    setState(() {
      _textRunNumber.text = widget.run.runnumber;
      _textRunDate.text = widget.run.rundate;
      _textRunTime.text = widget.run.runtime;
      _textRunTime.text = widget.run.runtime;

      _isEdit = int.parse(widget.run.hashrunid) > 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _editHareRunDetailForm,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _textRunNumber,
                  validator: (String? value) {
                    if (value == null || !checkNumber(value)) {
                      return MSG_INPUT_NUMBER;
                    }
                    return null;
                  },
                  readOnly: _isEdit,
                  decoration: InputDecoration(
                      labelText: "Run Number",
                      prefixIcon: Icon(Icons.format_list_numbered),
                      isDense: true,
                      hintText: MSG_INPUT_NUMBER),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());
                    // Show Date Picker Here
                    _selectTime(_textRunTime);
                  },
                  controller: _textRunTime,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Run Time';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Run Time",
                    prefixIcon: Icon(Icons.query_builder),
                    isDense: true,
                  ),
                  enableInteractiveSelection: false,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _textRunDirections,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return MSG_REQUIRE_FIELD;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Run Directions",
                    prefixIcon: Icon(Icons.show_chart),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LocationPicker(
                    label: 'Run Location',
                    color: Colors.indigoAccent,
                    onSelect: (latlng, pickResult) {
                      setState(() {
                        _runLocation = latlng;
                        if (_textRunDirections.text.trim().isEmpty) {
                          _textRunDirections.text =
                              pickResult.formattedAddress ?? '';
                        }
                      });
                    },
                    location: _runLocation,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: Colors.indigoAccent,
                        ),
                        Text(
                          " OnOn: ",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Colors.indigoAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: RadioGroup(
                            options: ['Yes', 'No'],
                            value: _onon,
                            onChanged: (value) {
                              setState(() {
                                _onon = value ?? '';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _textRunFee,
                  validator: (String? value) {
                    if (value == null || !checkNumber(value)) {
                      return MSG_INPUT_NUMBER;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "OnOn Fee",
                      prefixIcon: Icon(Icons.attach_money),
                      isDense: true,
                      hintText: MSG_INPUT_NUMBER),
                  keyboardType: TextInputType.number,
                  inputFormatters: inputNumberFormatter,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LocationPicker(
                    label: 'OnOn Location',
                    color: Colors.pinkAccent,
                    onSelect: (latlng, pickResult) {
                      setState(() {
                        _ononLocation = latlng;
                        if (_textRunDescription.text.trim().isEmpty) {
                          _textRunDescription.text =
                              pickResult.formattedAddress ?? '';
                        }
                      });
                    },
                    location: _ononLocation,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _textRunDescription,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return MSG_REQUIRE_FIELD;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "OnOn Description",
                    prefixIcon: Icon(Icons.show_chart),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: _saveRunDetail,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Add Run Detail',
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
