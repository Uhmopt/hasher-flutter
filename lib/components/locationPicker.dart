import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasher/components/labelText.dart';

// ignore: must_be_immutable
class LocationPicker extends StatefulWidget {
  LocationPicker({
    Key? key,
    this.label = '',
    this.color = Colors.indigoAccent,
    required this.onSelect,
  }) : super(key: key);
  String label = '';
  Color color = Colors.indigoAccent;
  Function onSelect = () {};

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: () {},
        // elevation: 10,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Run Location',
                textScaleFactor: 1.4,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.indigoAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: LabelText(
                label: 'Longitude: ',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: LabelText(
                label: 'Latitude: ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
