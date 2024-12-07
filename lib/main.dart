import 'package:flutter/material.dart';
import 'package:myappp/Pages/firebaseauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  //   FirebaseAuth.instance.setSettings(makeRequest:   (request) {
  //   request.headers['X-Client-Version'] = Firebase.version;
  //   return request;
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthPage(),
    );
  }
}
