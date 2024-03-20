import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nice_water/screens/map/map_utils.dart';
import 'package:nice_water/screens/report_waste/create_report.dart';
import 'package:nice_water/utils/theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:nice_water/utils/timestamp_util.dart';

import '../../models/reports_model.dart';
import '../../services/db_provider.dart';
import '../map/map_round_buttons.dart';

class RepostWasteScreen extends StatefulWidget {
  const RepostWasteScreen({super.key, required this.drawerController});
  final ZoomDrawerController drawerController;

  @override
  State<RepostWasteScreen> createState() => _RepostWasteScreenState();
}

class _RepostWasteScreenState extends State<RepostWasteScreen> {
  List<ReportModel> reportList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => buildAllMarkers());
  }

  buildAllMarkers() async {
    reportList.clear();
    reportList = await DbProvider.instance
        .getAllReport(getMapFilters().elementAt(0).type!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 100, right: defaultPadding),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CreateReport.routePath)
                        .then((value) => buildAllMarkers());
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
              child: MapRoundButton(
                  onPressed: () {
                    widget.drawerController.toggle!();
                  },
                  iconData: Icons.sort),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      ReportModel item = reportList.elementAt(index);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.withOpacity(0.2),
                          radius: 25,
                          child: Icon(
                            getPointerIconDateByType(item.type!),
                            color: primaryColor,
                          ),
                        ),
                        title: Text(getFilterNameByType(item.type!)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.address ?? '',
                              maxLines: 3,
                            ),
                            Text(
                              getTimesAgoFromTimestamp(item.createdOn!),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.scale,
                                  title: 'Information',
                                  desc: item.comment ?? '',
                                  btnOkOnPress: () {},
                                ).show();
                              },
                              icon: const Icon(
                                Icons.info_outline,
                                color: Colors.blueGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                MapsLauncher.launchCoordinates(
                                    item.location!.latitude,
                                    item.location!.longitude);
                              },
                              icon: const Icon(
                                Icons.navigation_outlined,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        indent: 70,
                      );
                    },
                    itemCount: reportList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
