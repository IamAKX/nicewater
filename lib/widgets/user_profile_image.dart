import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/user_model.dart';

// ignore: must_be_immutable
class UserProfileImage extends StatelessWidget {
  UserProfileImage(
      {super.key, required this.userModel, this.height, this.width});
  final UserModel? userModel;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: userModel!.image!,
      fit: BoxFit.cover,
      width: width,
      height: height,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          LineAwesomeIcons.user,
          size: 35,
        ),
      ),
    );
  }
}
