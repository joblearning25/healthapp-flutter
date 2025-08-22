import 'package:flutter/material.dart';

class PatientsSCreen extends StatefulWidget {
  const PatientsSCreen({super.key});

  @override
  State<PatientsSCreen> createState() => _PatientsSCreenState();
}

class _PatientsSCreenState extends State<PatientsSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients "),
      ),
    );
  }
}