import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../map/map_round_buttons.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});
  static const String routePath = '/locationPicker';

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  // Map setup
  LatLng _initialCenter = LatLng(12.9716, 77.5946);
  static const double _initialZoom = 18;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialZoom: _initialZoom,
              initialCenter: _initialCenter,
              onTap: (tapPosition, point) {
                setState(() {
                  _initialCenter = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  // ignore: unnecessary_null_comparison
                  if (_initialCenter != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _initialCenter,
                      child: const Icon(
                        LineAwesomeIcons.map_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 10,
            child: MapRoundButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconData: Icons.navigate_before,
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: MapRoundButton(
              onPressed: () {
                Navigator.of(context).pop(_initialCenter);
              },
              iconData: Icons.done,
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: MapRoundButton(
              onPressed: () {
                getCurrentLocation();
              },
              iconData: Icons.gps_fixed_outlined,
            ),
          ),
        ],
      ),
    );
  }

  void getCurrentLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _initialCenter = LatLng(position.latitude, position.longitude);
      mapController.move(_initialCenter, _initialZoom);
      setState(() {});
    }
  }
}
