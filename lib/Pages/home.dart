import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged in successfully'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(
          "Logged in as ${user.email!}",
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
