import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InputFieldLight extends StatelessWidget {
  const InputFieldLight(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.keyboardType,
      required this.obscure,
      required this.icon,
      this.maxChar,
      this.enabled,
      this.enabledLable,
      this.togglePassword})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final IconData icon;
  final int? maxChar;
  final bool? enabled;
  final bool? enabledLable;
  final Function()? togglePassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      keyboardType: keyboardType,
      autocorrect: true,
      obscureText: obscure,
      controller: controller,
      maxLength: maxChar,
      decoration: InputDecoration(
        hintText: hint,
        labelText: enabledLable == true ? hint : null,
        filled: true,
        prefixIcon: Icon(icon),
        suffix: togglePassword == null
            ? null
            : IconButton(
                onPressed: togglePassword,
                icon: Icon(obscure
                    ? LineAwesomeIcons.eye
                    : LineAwesomeIcons.eye_slash),
              ),
      ),
    );
  }
}
