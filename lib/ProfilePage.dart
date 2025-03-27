import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(("profile Page"),
            style: TextStyle(
              fontSize: 30,
            )),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView(),
    );
  }
}
