import 'package:flutter/material.dart';
import 'package:nice_water/utils/theme.dart';

Widget showMarkerPopup(BuildContext context, String text) {
  return Card(
    elevation: 20,
    color: primaryColor,
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
      ),
    ),
  );
}
