import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/coHareAction.dart';
import 'package:hasher/actions/hareAction.dart';
import 'package:hasher/actions/runListAction.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/components/textDropDown.dart';
import 'package:hasher/constant.dart';
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
  bool _isEdit = false;

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
      if (_isEdit) {
        updateHareRun(
          hashrunid: widget.run.hashrunid,
          hare: _harename,
          rundate: _textRunDate.text,
          runtime: _textRunTime.text,
        ).then((value) {
          if (value.status == 'success') {
            showMessage(MSG_SAVED);
          } else {
            showMessage(MSG_NOT_SAVED);
          }
          SmartDialog.dismiss();
        });
      } else {
        addHareRun(
          runnumber: _textRunNumber.text,
          rundate: _textRunDate.text,
          runtime: _textRunTime.text,
          hare: _harename,
          club: widget.clubname,
        ).then((value) {
          if (value.status == 'success') {
            showMessage(MSG_SAVED);
            // redirect
            Navigator.pop(context);
          } else {
            showMessage(MSG_NOT_SAVED);
          }
          SmartDialog.dismiss();
        });
      }
    }
  }

  _addCoHare(value) {
    if (_isEdit) {
      showLoading();
      addCoHare(hashrunid: widget.run.hashrunid, cohare: value).then((res) {
        SmartDialog.dismiss();
        if (res.status == 'success') {
          setState(() {
            _coharenames = [..._coharenames, (value ?? '')];
          });
        } else {
          showMessage(MSG_NOT_SAVED);
        }
      });
    }
  }

  _removeCoHare(value) {
    if (_isEdit) {
      showLoading();
      deleteCoHare(hashrunid: widget.run.hashrunid, cohare: value).then((res) {
        SmartDialog.dismiss();
        if (res.status == 'success') {
          setState(() {
            _coharenames =
                _coharenames.where((element) => element != value).toList();
          });
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
      _harename = widget.run.hashname;

      _isEdit = int.parse(widget.run.hashrunid) > 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _initValues();
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
              (_isEdit)
                  ? Container(
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
                    )
                  : Container(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextDropDown(
                    // value: _harename,
                    label: 'CoHare',
                    hint: 'Add CoHare',
                    options: _harenames,
                    onChange: _addCoHare),
              ),
              Container(
                child: Wrap(
                  children: List<Widget>.from(_coharenames.map((cohare) => Chip(
                      label: Text(cohare),
                      onDeleted: () => _removeCoHare(cohare)))),
                  spacing: 5,
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
