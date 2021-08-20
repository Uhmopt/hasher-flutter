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
  final Map<String, Marker> _markers = {};

  LatLng _center = LatLng(DEFAULT_LATITUDDE, DEFAULT_LONGITUDE);

  _init() {
    _center = widget.location;
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers['location'] = Marker(
        markerId: MarkerId('location'),
        position: widget.location,
        infoWindow: InfoWindow(title: 'Run Location'),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.readOnly
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.0,
              ),
              markers: _markers.values.toSet(),
            )
          : PlacePicker(
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
              useCurrentLocation: DEFAULT_LATITUDDE == _center.latitude &&
                  DEFAULT_LONGITUDE == _center.longitude,
              selectInitialPosition: true,
              usePlaceDetailSearch: true,
            ),
    );
  }
}
