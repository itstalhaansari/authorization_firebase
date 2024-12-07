import 'package:flutter/material.dart';
import 'package:myappp/Pages/Registerpage.dart';
import 'package:myappp/Pages/loginpage.dart';

class BoolPage extends StatefulWidget {
  const BoolPage({super.key});

  @override
  State<BoolPage> createState() => _BoolPageState();
}

class _BoolPageState extends State<BoolPage> {
  bool showloginpage = true;
  void changepage() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage == true) {
      return LoginPage(
        onPressed: changepage,
      );
    } else {
      return RegisterPage(
        onPressed: changepage,
      );
    }
  }
}
