// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myappp/Components/containerimage.dart';
import 'package:myappp/Components/errordialog.dart';
import 'package:myappp/Components/mloginbutton.dart';
import 'package:myappp/Components/mtextform.dart';
import 'package:myappp/Pages/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  TextEditingController conemail = TextEditingController();
  late TextEditingController conpass;
  bool showsuffix = false;
  ValueNotifier<bool> isHidden = ValueNotifier(true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conpass = TextEditingController();
    conpass.addListener(updatesuffixicon);
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: conemail.text, password: conpass.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        showDialog(
            context: context,
            builder: (context) => MErrorDialog(
                onPressed: () => Navigator.pop(context),
                errortext: 'Invaild Credentials Entered',
                btntext: "Retry"));
      } else if (e.code == 'too-many-requests') {
        showDialog(
            context: context,
            builder: (context) => MErrorDialog(
                onPressed: () => Navigator.pop(context),
                errortext: "Kindly try again later after a while",
                btntext: "Thank you"));
      } else {
        showDialog(
          context: context,
          builder: (context) => MErrorDialog(
            errortext: e.code,
            btntext: "Retry",
            onPressed: () => Navigator.pop(context),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Firebase login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Welcome to my App",
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
                    hinttext: "Password",
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
            const SizedBox(
              height: 15,
            ),
            MButton(
              text: "Login",
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
                const Text("Not an existing user?? ",
                    style: TextStyle(fontSize: 16)),
                MaterialButton(
                  padding:
                      EdgeInsets.zero, // Removes default padding of the button
                  minWidth: 0, // Removes minimum width of the button
                  onPressed: widget.onPressed,
                  child: const Text(
                    "Sign up",
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
