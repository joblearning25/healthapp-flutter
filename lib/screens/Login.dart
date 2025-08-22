import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthapp/screens/doctor/DoctorHomeScreen.dart';
import 'package:healthapp/screens/doctor/RegisterDoctor.dart';
import 'package:healthapp/screens/patient/PatientPrescription.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneController= TextEditingController();
  final passwordController= TextEditingController();

  bool isLoading=false;

  // function to login 
  Future<void> handleLogin() async {
  final phone = phoneController.text.trim();
  final password = passwordController.text.trim();

  if (phone.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Phone and Password are required"),
        backgroundColor: Colors.amber,
      ),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  print("login function");
  final body = jsonEncode({'phone': phone, 'password': password});
  final url = Uri.parse("https://healthapi.pythonanywhere.com/login");
 
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    setState(() {
      isLoading = false;
    });

    print("Raw response body: ${response.body}");
    print("Status code: ${response.statusCode}");

    final resData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final role = resData['role'];
      final name = resData['name'];

      final pref = await SharedPreferences.getInstance();
      pref.setString('role', role);
      pref.setString('name', name);
      pref.setInt('id', resData['id']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome $role $name'),
          backgroundColor: Colors.green,
        ),
      );

      if (role == 'doctor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorHomeScreen(
              doctorId: resData['id'],
              doctorName: name,
            ),
          ),
        );
      } else if (role == 'patient') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PatientPrescription(
              patientId: resData['id'],
              patientName: name,
            ),
          ),
        );
      }
    } else {
      //  Now this will catch 401 and any other error codes
      final error = resData['error'] ?? 'Login failed';
      print('Login error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.lock , size: 60, color: Colors.blue,),
            SizedBox(height: 16,),
            Text("Welcome Back",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 16,),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
            ),

            SizedBox(height: 16,),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
            ),
            SizedBox(height: 16,),
            isLoading 
            ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton.icon(
              onPressed: handleLogin, 
              label: Text("Login"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
                backgroundColor: Colors.blue
              ),
            ),

            SizedBox(height: 16,),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_)=>RegisterDoctor())
                );
              }, 
              child: Text(
                "Don't have an Account? Register here",
                style: TextStyle(
                  decoration: TextDecoration.underline
                ),
              ))
          ],
        ),
      ),
    );
  }
}