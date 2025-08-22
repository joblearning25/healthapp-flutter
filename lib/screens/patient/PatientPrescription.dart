import 'package:flutter/material.dart';

class PatientPrescription extends StatefulWidget {
  const PatientPrescription({super.key, required patientName, required patientId});

  @override
  State<PatientPrescription> createState() => _PatientPrescriptionState();
}

class _PatientPrescriptionState extends State<PatientPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Prescription"),
      ),
    );
  }
}