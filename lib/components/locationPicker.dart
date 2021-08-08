import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hasher/components/gMap.dart';
import 'package:hasher/components/labelText.dart';
import 'package:hasher/constant.dart';

// ignore: must_be_immutable
class LocationPicker extends StatefulWidget {
  LocationPicker({
    Key? key,
    this.label = '',
    this.color = Colors.indigoAccent,
    this.location = const LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE),
    required this.onSelect,
  }) : super(key: key);
  String label = '';
  Color color = Colors.indigoAccent;
  LatLng location = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);
  Function(LatLng, PickResult) onSelect = (v, p) {};

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          log('message');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GMap(
                  location: widget.location,
                  onSelect: widget.onSelect,
                ),
              ));
        },
        // elevation: 10,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.label,
                textScaleFactor: 1.4,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: LabelText(
                label: 'Longitude: ',
                color: widget.color,
                value: (widget.location.latitude == DEFAULT_LATITUDDE)
                    ? ""
                    : widget.location.latitude.toString(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: LabelText(
                label: 'Latitude: ',
                color: widget.color,
                value: (widget.location.longitude == DEFAULT_LONGITUDE)
                    ? ""
                    : widget.location.longitude.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
