// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myappp/Components/containerimage.dart';
import 'package:myappp/Components/errordialog.dart';
import 'package:myappp/Components/mloginbutton.dart';
import 'package:myappp/Components/mtextform.dart';
import 'package:myappp/Pages/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  State<RegisterPage> createState() => _HomePageState();
}

class _HomePageState extends State<RegisterPage> {
  TextEditingController conemail = TextEditingController();
  late TextEditingController conpass;
  late TextEditingController conconfirmpass;
  bool showsuffix = false;
  bool confirmshowsuffix = false;

  ValueNotifier<bool> isHidden = ValueNotifier(true);
  ValueNotifier<bool> isConfirmPasswordHidden = ValueNotifier(true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conpass = TextEditingController();
    conconfirmpass = TextEditingController();
    conpass.addListener(updatesuffixicon);
    conconfirmpass.addListener(updatesuffixiconforconfirmpass);
  }

  void updatesuffixiconforconfirmpass() {
    setState(() {
      confirmshowsuffix = conconfirmpass.text.isNotEmpty;
    });
  }

  void updatesuffixicon() {
    setState(() {
      showsuffix = conpass.text.isNotEmpty;
    });
  }

  void signinuser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      if (conpass.text == conconfirmpass.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: conemail.text, password: conpass.text);
      }
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => MErrorDialog(
                errortext: 'Account Created Successfully',
                btntext: 'okay',
                onPressed: () => Navigator.pop(context),
              ));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => MErrorDialog(
                errortext: e.code,
                btntext: "Retry",
                onPressed: () => Navigator.pop(context),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register User'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.lock,
              size: 50,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Create an account for you",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            MTextForm(
              controller: conemail,
              hinttext: "Email / Username",
              prefixIcon: const Icon(Icons.email),
              obscureText: false,
            ),
            ValueListenableBuilder(
              valueListenable: isHidden,
              builder: (context, value, child) {
                return MTextForm(
                    controller: conpass,
                    hinttext: "Enter Password",
                    prefixIcon: const Icon(Icons.password),
                    obscureText: isHidden.value,
                    suffixIcon: showsuffix
                        ? IconButton(
                            onPressed: () {
                              isHidden.value = !isHidden.value;
                            },
                            icon: Icon(isHidden.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          )
                        : null);
              },
            ),
            ValueListenableBuilder(
              valueListenable: isConfirmPasswordHidden,
              builder: (context, value, child) {
                return MTextForm(
                    controller: conconfirmpass,
                    hinttext: "Confirm Password",
                    prefixIcon: const Icon(Icons.password),
                    obscureText: isConfirmPasswordHidden.value,
                    suffixIcon: confirmshowsuffix
                        ? IconButton(
                            onPressed: () {
                              isConfirmPasswordHidden.value =
                                  !isConfirmPasswordHidden.value;
                            },
                            icon: Icon(isConfirmPasswordHidden.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          )
                        : null);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            MButton(
              text: "Sign up",
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                signinuser();
              },
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MImageContainer(
                  image: AssetImage('lib/Images/google.png'),
                  onTap: () => AuthService().Signinwithgoogle,
                ),
                MImageContainer(
                  image: AssetImage('lib/Images/apple.png'),
                  onTap: () {},
                ),
              ],
            ),
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Reduces the Row's width to its content
              children: [
                const Text("Already have a account",
                    style: TextStyle(fontSize: 16)),
                MaterialButton(
                  padding:
                      EdgeInsets.zero, // Removes default padding of the button
                  minWidth: 0, // Removes minimum width of the button
                  onPressed: widget.onPressed,
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
