import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/models/map_filter_model.dart';
import 'package:nice_water/screens/map/map_round_buttons.dart';
import 'package:nice_water/screens/map/map_utils.dart';
import 'package:nice_water/utils/theme.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:permission_handler/permission_handler.dart';

import '../report_waste/create_report.dart';
// import 'package:nice_water/widgets/marker_popup.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.drawerController});
  final ZoomDrawerController drawerController;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedFilterId = 0;

  // Map setup
  static const LatLng _initialCenter = LatLng(12.9716, 77.5946);
  static const double _initialZoom = 7;
  final MapController mapController = MapController();
  final SuperclusterImmutableController superclusterImmutableController =
      SuperclusterImmutableController();

  // Dummy marker
  final Random _random = Random(42);
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    generateDummyMarkers();
    getLocationPermission();
  }

  generateDummyMarkers() {
    _markers.clear();

    _markers = List<Marker>.generate(
      500,
      (_) => Marker(
        child: const Icon(
          LineAwesomeIcons.map_pin,
          color: primaryColor,
        ),
        point: LatLng(
          _random.nextDouble() * 3 - 1.5 + _initialCenter.latitude,
          _random.nextDouble() * 3 - 1.5 + _initialCenter.longitude,
        ),
      ),
    );
    debugPrint('length = ${_markers.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
              child: FlutterMap(
                mapController: mapController,
                options: const MapOptions(
                  initialZoom: _initialZoom,
                  initialCenter: _initialCenter,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  SuperclusterLayer.immutable(
                    initialMarkers: _markers,
                    indexBuilder: IndexBuilders.rootIsolate,
                    controller: superclusterImmutableController,

                    // popupOptions: PopupOptions(
                    //   popupDisplayOptions: PopupDisplayOptions(
                    //     builder: (context, marker) {
                    //       return showMarkerPopup(
                    //           context,
                    //           getMapFilters()
                    //                   .elementAt(selectedFilterId)
                    //                   .name ??
                    //               '');
                    //     },
                    //   ),
                    //   markerTapBehavior:
                    //       MarkerTapBehavior.togglePopupAndHideRest(),
                    // ),
                    builder:
                        (context, position, markerCount, extraClusterData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            markerCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 100, right: defaultPadding),
                child: Text(
                  getMapFilters().elementAt(selectedFilterId).name ?? '',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color.fromRGBO(85, 85, 85, 1),
                      ),
                ),
              ),
            ),
            Positioned(
              child: MapRoundButton(
                  onPressed: () {
                    widget.drawerController.toggle!();
                  },
                  iconData: Icons.sort),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 100, right: defaultPadding),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateReport.routePath);
                  },
                  child: Text(
                    'ADD',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 1,
              child: MapRoundButton(
                onPressed: () {
                  mapController.move(_initialCenter, _initialZoom);
                },
                iconData: Icons.gps_fixed_outlined,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  itemCount: getMapFilters().length,
                  itemBuilder: (context, index) {
                    MapFilterModel filter = getMapFilters().elementAt(index);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedFilterId = filter.id ?? 0;
                        });
                        mapController.move(_initialCenter, _initialZoom);
                        superclusterImmutableController.clear();
                        generateDummyMarkers();
                        superclusterImmutableController.replaceAll(_markers);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: selectedFilterId == filter.id
                            ? primaryColor
                            : Colors.white,
                        elevation: 20,
                        margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 70,
                          height: 70,
                          child: Icon(
                            selectedFilterId == filter.id
                                ? filter.selectedIconData
                                : filter.iconData,
                            size: 30,
                            color: selectedFilterId == filter.id
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    debugPrint('status : ${status.isGranted}');
  }
}
