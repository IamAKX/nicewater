import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/models/map_filter_model.dart';
import 'package:nice_water/models/reports_model.dart';
import 'package:nice_water/screens/map/map_utils.dart';
import 'package:nice_water/screens/report_waste/location_picker.dart';
import 'package:nice_water/services/db_provider.dart';
import 'package:nice_water/services/snakbar_service.dart';
import 'package:nice_water/widgets/gaps.dart';
import 'package:nice_water/widgets/input_field_light.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/google_map_address_model.dart';
import '../../services/api_provider.dart';
import '../../utils/theme.dart';
import '../map/map_round_buttons.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({super.key});
  static const String routePath = '/createReport';
  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _commentCtrl = TextEditingController();
  LatLng _initialCenter = LatLng(12.9716, 77.5946);
  List<MapFilterModel> wasteType = getMapFilters();
  MapFilterModel? selectedType;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  fetchAddressFromLatLon(LatLng latLng) async {
    GoogleMapAddressModel address =
        await ApiProvider.instance.getAddressFromLatLon(latLng);
    // ignore: unnecessary_null_comparison
    if (address != null) {
      setState(() {
        _addressCtrl.text = address.results?.first.formattedAddress ?? '';
        _cityCtrl.text = address.results?.first.addressComponents
                ?.firstWhere(
                    (element) => element.types?.contains('locality') ?? false)
                .longName ??
            '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    wasteType.removeWhere((element) => element.id == 0);
    SnackBarService.instance.buildContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 100, right: defaultPadding),
                child: Text(
                  'Report',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color.fromRGBO(85, 85, 85, 1),
                      ),
                ),
              ),
            ),
            Positioned(
              child: MapRoundButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                iconData: Icons.navigate_before,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height - 120,
                child: ListView(
                  padding: const EdgeInsets.all(defaultPadding),
                  children: [
                    Text(
                      'COORDINATES : ${_initialCenter.latitude.toStringAsFixed(6)}° N, ${_initialCenter.longitude.toStringAsFixed(6)}° E',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LocationPicker.routePath)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              _initialCenter = value as LatLng;
                              fetchAddressFromLatLon(_initialCenter);
                            });
                          }
                        });
                      },
                      child: const Text('Pick location'),
                    ),
                    verticalGap(defaultPadding * 1.5),
                    InputFieldLight(
                      hint: 'Address',
                      controller: _addressCtrl,
                      keyboardType: TextInputType.streetAddress,
                      obscure: false,
                      icon: LineAwesomeIcons.map_marked,
                      enabledLable: true,
                    ),
                    verticalGap(defaultPadding),
                    InputFieldLight(
                      hint: 'City',
                      controller: _cityCtrl,
                      keyboardType: TextInputType.streetAddress,
                      obscure: false,
                      icon: LineAwesomeIcons.map_marked,
                      enabledLable: true,
                    ),
                    verticalGap(defaultPadding),
                    InputFieldLight(
                      hint: 'Comment',
                      controller: _commentCtrl,
                      keyboardType: TextInputType.text,
                      obscure: false,
                      icon: LineAwesomeIcons.comment,
                      enabledLable: true,
                    ),
                    verticalGap(defaultPadding * 3),
                    Text(
                      'Select waste type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey.withOpacity(0.7)),
                    ),
                    DropdownButton<MapFilterModel>(
                      value: selectedType,
                      onChanged: (MapFilterModel? newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                      items: wasteType.map<DropdownMenuItem<MapFilterModel>>(
                          (MapFilterModel value) {
                        return DropdownMenuItem<MapFilterModel>(
                          value: value,
                          child: Text(value.name ?? '-'),
                        );
                      }).toList(),
                      hint: const Text('Waste Type'),
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      isExpanded: true,
                      underline: const Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 2,
                      ),
                    ),
                    verticalGap(
                      defaultPadding,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_addressCtrl.text.isEmpty ||
                            _cityCtrl.text.isEmpty ||
                            _commentCtrl.text.isEmpty ||
                            selectedType == null) {
                          SnackBarService.instance
                              .showSnackBarError('All fields are mandatory');
                          return;
                        }

                        ReportModel reportModel = ReportModel(
                            address: _addressCtrl.text,
                            city: _cityCtrl.text,
                            comment: _commentCtrl.text,
                            createdBy: '-1',
                            createdOn: Timestamp.now(),
                            type: selectedType?.type,
                            location: GeoPoint(_initialCenter.latitude,
                                _initialCenter.longitude),
                            status: true,
                            otherInfo: '');
                        DbProvider.instance
                            .createdWasteIncedent(reportModel)
                            .then((value) => Navigator.pop(context));
                      },
                      child: const Text('Create'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _initialCenter = LatLng(position.latitude, position.longitude);
      setState(() {});
      fetchAddressFromLatLon(_initialCenter);
    }
  }
}
