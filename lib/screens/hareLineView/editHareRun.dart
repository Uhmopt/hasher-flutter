import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hareAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/textDropDown.dart';
import 'package:hasher/components/textDropDownMulti.dart';
import 'package:hasher/helper/helpers.dart';

// ignore: must_be_immutable
class EditHareRun extends StatefulWidget {
  EditHareRun(
      {Key? key,
      required this.run,
      required this.committee,
      this.clubname = ''})
      : super(key: key);
  Run run = new Run();
  List<String> committee = [];
  String clubname = "";

  @override
  _EditHareRunState createState() => _EditHareRunState();
}

class _EditHareRunState extends State<EditHareRun> {
  final GlobalKey<FormState> _editHareRunForm = GlobalKey<FormState>();
  TextEditingController _textRunNumber = new TextEditingController();
  TextEditingController _textRunDate = new TextEditingController();
  TextEditingController _textRunTime = new TextEditingController();
  List<String> _harenames = [];
  String _harename = '';
  List<String> _coharenames = [];

  Future _selectDate(TextEditingController tc) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
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
      initialTime: new TimeOfDay.now(),
    );
    if (picked != null)
      setState(() => tc.text = picked.hour.toString().padLeft(2, '0') +
          ':' +
          picked.minute.toString().padLeft(2, '0'));
  }

  _initHare() {
    showLoading();
    getClubHare(widget.clubname).then((hares) {
      SmartDialog.dismiss();
      setState(() {
        _harenames = hares;
      });
    });
  }

  _saveHareRun() {
    if (_editHareRunForm.currentState!.validate()) {
      showLoading();
      addHareRun(
        runnumber: _textRunNumber.text,
        rundate: _textRunDate.text,
        runtime: _textRunTime.text,
        hare: _harename,
        club: widget.clubname,
      ).then((value) {
        SmartDialog.dismiss();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initHare();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _editHareRunForm,
        child: Container(
          child: Column(
            children: [
              Container(
                  child: TextButton(
                child: Text('asd'),
                onPressed: _initHare,
              )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _textRunNumber,
                  validator: (String? value) {
                    if (value == null || !checkNumber(value)) {
                      return 'Please inset correct number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Run Number",
                      prefixIcon: Icon(Icons.format_list_numbered),
                      isDense: true,
                      hintText: "Please input Run Number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
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
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextDropDown(
                  value: _harename,
                  label: 'Hare',
                  hint: 'Select Hare',
                  options: _harenames,
                  onChange: (value) {
                    setState(() {
                      _harename = value ?? '';
                    });
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: TextDropDownMulti(
                  onSelect: (List<String> value) {
                    setState(() {
                      _coharenames = value;
                    });
                  },
                  options: _harenames,
                  selected: _coharenames,
                  hint: 'Select CoHare',
                  label: 'CoHare',
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: _saveHareRun,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Update Run',
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Add or Edit Details',
                      textScaleFactor: 1.3,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent)),
                ),
              )
            ],
          ),
        ));
  }
}
