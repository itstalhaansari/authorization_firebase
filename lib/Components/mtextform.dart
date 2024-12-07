import 'package:flutter/material.dart';

class MTextForm extends StatelessWidget {
  MTextForm(
      {super.key,
      required this.controller,
      this.hinttext,
      this.prefixIcon,
      required this.obscureText,
      this.suffixIcon});
  final TextEditingController? controller;
  final String? hinttext;
  final Widget? prefixIcon;
  bool obscureText = true;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 10, right: 13),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            hintText: hinttext,
            suffixIcon: suffixIcon),
        controller: controller,
      ),
    );
  }
}
