import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  const MButton({super.key, this.onPressed, required this.text});
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minWidth: 160,
      height: 50,
      onPressed: onPressed,
      color: Colors.black,
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
