import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InputFieldDark extends StatelessWidget {
  const InputFieldDark(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.keyboardType,
      required this.obscure,
      required this.icon,
      this.maxChar,
      this.enabled,
      this.togglePassword})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final IconData icon;
  final int? maxChar;
  final bool? enabled;
  final Function()? togglePassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      keyboardType: keyboardType,
      autocorrect: true,
      obscureText: obscure,
      controller: controller,
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      maxLength: maxChar,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
          size: 30,
        ),
        suffix: togglePassword == null
            ? null
            : IconButton(
                onPressed: togglePassword,
                color: Colors.white70,
                icon: Icon(obscure
                    ? LineAwesomeIcons.eye
                    : LineAwesomeIcons.eye_slash),
              ),
        alignLabelWithHint: true,
        filled: false,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white70),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
