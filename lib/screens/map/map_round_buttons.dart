import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class MapRoundButton extends StatelessWidget {
  const MapRoundButton(
      {super.key, required this.onPressed, required this.iconData});
  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        color: const Color.fromRGBO(85, 85, 85, 1),
        icon: Icon(iconData),
      ),
    );
  }
}
