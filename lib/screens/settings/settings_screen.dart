import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_water/screens/onboarding/login.dart';
import 'package:nice_water/utils/theme.dart';
import 'package:nice_water/widgets/input_field_light.dart';
import 'package:nice_water/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import '../../services/auth_provider.dart';
import '../../services/snakbar_service.dart';
import '../../widgets/gaps.dart';
import '../../widgets/user_profile_image.dart';
import '../map/map_round_buttons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.drawerController});
  final ZoomDrawerController drawerController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isImageUploading = false;
  bool hidePassword = true;
  late AuthProvider _auth;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadUserData());
  }

  loadUserData() async {
    await _auth.user?.reload();
    _nameCtrl.text = _auth.user?.displayName ?? '';
    _emailCtrl.text = _auth.user?.email ?? '';
  }

  togglePasswordVisibiliy() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 70),
                height: MediaQuery.of(context).size.height - 120,
                child: ListView(
                  padding: const EdgeInsets.all(defaultPadding),
                  children: [
                    header(context),
                    verticalGap(defaultPadding),
                    getSubTitle(context, 'Update Name'),
                    InputFieldLight(
                      hint: 'Name',
                      controller: _nameCtrl,
                      keyboardType: TextInputType.name,
                      obscure: false,
                      icon: LineAwesomeIcons.user,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _auth.updateName(_nameCtrl.text).then((value) {
                            loadUserData();
                            SideMenu.reloadSide!();
                          });
                        },
                        child: Text('Save'),
                      ),
                    ),
                    verticalGap(defaultPadding),
                    getSubTitle(context, 'Update Password'),
                    InputFieldLight(
                      hint: 'Password',
                      controller: _passwordCtrl,
                      keyboardType: TextInputType.emailAddress,
                      obscure: hidePassword,
                      icon: LineAwesomeIcons.lock,
                      togglePassword: togglePasswordVisibiliy,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _auth
                              .updatePassword(_passwordCtrl.text)
                              .then((value) {
                            loadUserData();
                            _auth.logoutUser();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginScreen.routePath, (route) => false);
                          });
                        },
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 100, right: defaultPadding),
                child: Text(
                  'Settings',
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
          ],
        ),
      ),
    );
  }

  Padding getSubTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.grey),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: UserProfileImage(
                userImage: _auth.user?.photoURL,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            left: 70,
            child: PopupMenuButton(
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit profile image'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete profile image'),
                  ),
                ];
              },
              enabled: !isImageUploading,
              onSelected: (value) async {
                switch (value) {
                  case 'edit':
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {}
                    return;
                  case 'delete':
                    // userModel.image = '';

                    return;
                }
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
