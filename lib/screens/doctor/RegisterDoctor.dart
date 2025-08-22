import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterDoctor extends StatefulWidget {
  const RegisterDoctor({super.key});

  @override
  State<RegisterDoctor> createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final locationController=TextEditingController();
  final specialitController=TextEditingController();
  final councilNumberController=TextEditingController();
  final secretController=TextEditingController();
  final passwordController=TextEditingController();
  

  // Regiser function
  Future<void> registerDoctor () async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading=true;
    });        

    final url = Uri.parse("https://healthapi.pythonanywhere.com/doctor/register");
    // we are preparing data to send to api 
    final body = jsonEncode({
      "secret":secretController.text.trim(),
      "name":nameController.text.trim(),
      "phone":phoneController.text.trim(),
      "email":emailController.text.trim(),
      "location":locationController.text.trim(),
      "speciality":specialitController.text.trim(),
      "nursing_council_number":councilNumberController.text.trim(),
      "password":passwordController.text.trim()
    });

    try {
      final response=await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body:body
      );
      setState(() {
        isLoading=false;
      });

      final res = jsonDecode(response.body);
      // print(res);
      if (response.statusCode==200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res["message"],
          style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
          )
        );        
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['error'],
          style: TextStyle(
            color:Colors.white),),
            backgroundColor: Colors.red,
          )
        );
      }
      
    } catch (e) {
      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e ',
          style: TextStyle(
            color:Colors.white),),
            backgroundColor: Colors.red,
          )
        );
      
    }
  }
  
  // its for decorating inputs in somthing like a class
  InputDecoration buildInput(String lable,IconData icon){
    return InputDecoration(
      labelText: lable,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
    );
  }

  @override
  Widget build(BuildContext context) {
    // final themeColor=Theme.of(context).primaryColor
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Registration",),
        centerTitle:true,
        // backgroundColor:themeColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(child: Column(
        key: _formKey,
          children: [
            TextFormField(
              controller: nameController,
              decoration: buildInput("Full Name", Icons.person_3_rounded),
              validator: (value) => value!.isEmpty ? "Enter Name" :null
            ),
            SizedBox(height: 12,),

            // phone
            TextFormField(
              controller: phoneController,
              decoration: buildInput("Phone number", Icons.phone_android_rounded),
              validator: (value) => value!.isEmpty ? "Enter Phone " :null,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 12,),
            // email
            TextFormField(
              controller: emailController,
              decoration: buildInput("Email Address", Icons.email_rounded),
              validator: (value) => value!.isEmpty ? "Enter Email " :null,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 12,),
            // Location
            TextFormField(
              controller: locationController,
              decoration: buildInput("Location", Icons.location_on),

            ),

            SizedBox(height: 12,),
            // Specility
            TextFormField(
              controller: specialitController,
              decoration: buildInput("Speciality", Icons.medical_services_rounded),
              validator: (value) => value!.isEmpty ? "Enter Speciality" :null
            ),

            SizedBox(height: 12,),
            // nursing number
            TextFormField(
              controller: councilNumberController,
              decoration: buildInput("Council Number", Icons.medical_services_rounded),
              validator: (value) => value!.isEmpty ? "Enter Coucil Number" :null
            ),
            SizedBox(height: 12,),

            //secret
            TextFormField(
              controller: secretController,
              decoration: buildInput("Secret Key", Icons.lock),
              validator: (value) => value!.isEmpty ? "Enter secret key" :null
            ),

            SizedBox(height: 12,),
            TextFormField(
              controller: passwordController,
              decoration: buildInput("Enter Password", Icons.lock),
              validator: (value) => value!.isEmpty ? "Enter Passoword" :null
            ),
            SizedBox(height: 12,),
            isLoading
            ? CircularProgressIndicator()
            : ElevatedButton.icon(
              icon: Icon(Icons.app_registration_rounded),
              label: Text("Register", style: TextStyle(color: Colors.white),),
              style:ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14,  horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: Colors.lightBlue
              ),
          
              onPressed: registerDoctor
            )


          ],
        )),
      ),
    );
  }
}