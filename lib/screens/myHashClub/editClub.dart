import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/actions/roleAction.dart';
import 'package:hasher/components/checkBox.dart';
import 'package:hasher/components/dialogs.dart';
import 'package:hasher/constant.dart';
import 'package:hasher/helper/helpers.dart';
import 'package:hasher/layouts/index.dart';
import 'package:hasher/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class EditClub extends StatefulWidget {
  Hash hash = new Hash();
  EditClub({Key? key, required this.hash}) : super(key: key);

  @override
  _EditClubState createState() => _EditClubState();
}

class _EditClubState extends State<EditClub> {
  final GlobalKey<FormState> _editClubForm = GlobalKey<FormState>();
  TextEditingController _textRuns = TextEditingController();
  bool _isCurrent = false;
  bool _isFollow = false;

  _handleUpdate() {
    if (_editClubForm.currentState!.validate()) {
      showLoading();
      SharedPreferences.getInstance().then((prefs) {
        String email = prefs.getString(PREF_EMAIL) ?? '';
        updateRoleAction(
                club: widget.hash.hashclubname,
                email: email,
                current: _isCurrent,
                follow: _isFollow,
                total: _textRuns.text)
            .then((result) {
          SmartDialog.dismiss();
          if (result.status == 'success') {
            showMessage("Successfully updated.");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else {
            showMessage("Can not update role.");
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _textRuns.text = widget.hash.total_runs.toString();
      _isCurrent = widget.hash.current;
      _isFollow = widget.hash.follow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HashLayout(
      title: 'Edit Club Info',
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              widget.hash.hashclubname,
              textScaleFactor: 2,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            color: Colors.pinkAccent,
            width: double.infinity,
          ),
          ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                Form(
                    key: _editClubForm,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25),
                          child: TextFormField(
                            controller: _textRuns,
                            validator: (String? value) {
                              if (value == null || !checkNumber(value)) {
                                return 'Please inset correct number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Total Runds",
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
                            textScaleFactor: 1.4,
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
                            label: 'Follow Hash',
                            textScaleFactor: 1.4,
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: _handleUpdate,
                            child: Text(
                              'Updated Club Info',
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(20))),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 40),
                        )
                      ],
                    ))
              ])
        ],
      )),
    );
  }
}
