import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nice_water/screens/map/map_screen.dart';
import 'package:nice_water/screens/report_waste/report_waste_screen.dart';
import 'package:nice_water/screens/settings/settings_screen.dart';
import 'package:nice_water/widgets/side_menu.dart';

import '../../utils/theme.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});
  static const String routePath = '/homeContainer';

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();
  int selectMenu = 0;
  List<Widget>? menuItems;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menuItems = [
        MapScreen(drawerController: _drawerController),
        RepostWasteScreen(drawerController: _drawerController),
        SettingsScreen(drawerController: _drawerController)
      ];
    });
  }

  switchMenu(int index) {
    setState(() {
      selectMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      borderRadius: 50,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      menuScreenTapClose: true,
      angle: 10,
      mainScreenScale: 0.2,
      menuBackgroundColor: primaryColor,
      mainScreen: menuItems?.elementAt(selectMenu) ??
          MapScreen(drawerController: _drawerController),
      moveMenuScreen: false,
      menuScreen:
          SideMenu(drawerController: _drawerController, switchMenu: switchMenu),
    );
  }
}
