import 'package:flutter/material.dart';

class MErrorDialog extends StatelessWidget {
  MErrorDialog(
      {super.key,
      required this.errortext,
      required this.btntext,
      this.onPressed});
  // ignore: prefer_typing_uninitialized_variables
  var errortext;
  final String btntext;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(errortext),
      actions: [
        MaterialButton(
          onPressed: onPressed,
          child: Text(
            btntext,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}
