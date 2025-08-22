import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class PrescribeScreen extends StatefulWidget {
  final int doctorId;
  const PrescribeScreen({super.key, required this.doctorId});

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
  final _formKey=GlobalKey<FormState>();
  final _patientController=TextEditingController();
  final _diagnosisController=TextEditingController();
  final _prescriptionController=TextEditingController();
  final _notesController=TextEditingController();

  Future<void> _submitPrecription() async {
    if (_formKey.currentState!.validate()){
      final url = Uri.parse("https://healthapi.pythonanywhere.com/doctor/prescribe");
      final body={
        "doctor_id":widget.doctorId,
        "patient_number":_patientController.text.trim(),
        "diagnosis":_diagnosisController.text.trim(),
        "prescription":_prescriptionController.text.trim(),      
      };
      try {
        final response=await http.post(
          url,
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(body)
        );
        final data=jsonDecode((response.body));
        if (response.statusCode==200) {
          // final resData=response.body;
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" ${data['message']}")));
          _patientController.clear();
          _diagnosisController.clear();
          _prescriptionController.clear();
          _notesController.clear();
        }else{
           // final resData=response.body;
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${data['error']}")));

        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")));
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Prescribe"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _patientController,
                decoration: InputDecoration(labelText: "Patient Number"),
                validator: (value) => value!.isEmpty ? "Enter Patient Number": null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: "Diagnosis Number"),
                validator: (value) => value!.isEmpty ? "Enter Patient Number": null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _prescriptionController,
                decoration: InputDecoration(labelText: "Prescription"),
                validator: (value) => value!.isEmpty ? "Enter Patient Number": null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: "Notes Number"),
                validator: (value) => value!.isEmpty ? "Enter Notes": null,
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: _submitPrecription, child: Text("Submit Prescription"))
            ],
          )
        ),
      ),
    );
  }
}