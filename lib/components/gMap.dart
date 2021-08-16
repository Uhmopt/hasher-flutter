import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hasher/constant.dart';

// ignore: must_be_immutable
class GMap extends StatefulWidget {
  GMap({
    Key? key,
    this.location = const LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE),
    required this.onSelect,
    this.readOnly = false,
  }) : super(key: key);
  LatLng location = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);
  Function(LatLng, PickResult) onSelect = (v, p) {};
  bool readOnly = false;

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  late GoogleMapController mapController;

  LatLng _center = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);

  _init() {
    _center = widget.location;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacePicker(
        apiKey: "AIzaSyDDQ7LN9NLxnW5NmpPmUQvnbtqMmpep_nA",
        onPlacePicked: (result) {
          widget.onSelect(
              LatLng(
                result.geometry?.location.lat ?? 0,
                result.geometry?.location.lng ?? 0,
              ),
              result);
          Navigator.of(context).pop();
        },
        initialPosition: _center,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePlaceDetailSearch: true,
      ),
    );
  }
}
