import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class UserProfileImage extends StatelessWidget {
  UserProfileImage(
      {super.key, required this.userImage, this.height, this.width});
  final String? userImage;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: userImage ?? default_user_image,
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
