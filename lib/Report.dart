import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(("Report Page "),
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