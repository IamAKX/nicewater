import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/utils/constants.dart';
import 'package:nice_water/utils/theme.dart';
import 'package:nice_water/widgets/gaps.dart';

class SideMenu extends StatefulWidget {
  final ZoomDrawerController drawerController;
  final Function(int) switchMenu;
  const SideMenu(
      {super.key, required this.drawerController, required this.switchMenu});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalGap(100),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: default_user_image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        LineAwesomeIcons.user,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                horizontalGap(defaultPadding / 2),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guest user',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Anonymous login',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white60,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalGap(defaultPadding * 3),
            TextButton.icon(
              onPressed: () {
                widget.switchMenu(0);
                widget.drawerController.toggle!();
              },
              icon: const Icon(
                LineAwesomeIcons.map_marker,
                color: Colors.white54,
              ),
              label: Text(
                'Map',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                widget.switchMenu(1);
                widget.drawerController.toggle!();
              },
              icon: const Icon(
                LineAwesomeIcons.trash,
                color: Colors.white54,
              ),
              label: Text(
                'Report Waste',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                widget.switchMenu(2);
                widget.drawerController.toggle!();
              },
              icon: const Icon(
                LineAwesomeIcons.cog,
                color: Colors.white54,
              ),
              label: Text(
                'Settings',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                widget.drawerController.toggle!();
              },
              icon: const Icon(
                LineAwesomeIcons.alternate_sign_out,
                color: Colors.white54,
              ),
              label: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            verticalGap(50),
            Text(
              '© ${DateTime.now().year} Nice Water',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white60,
                  ),
            ),
            verticalGap(20),
          ],
        ),
      ),
    );
  }
}
