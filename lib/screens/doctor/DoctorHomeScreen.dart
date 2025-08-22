import 'package:flutter/material.dart';
import 'package:healthapp/screens/doctor/AppointmentsScreen.dart';
import 'package:healthapp/screens/doctor/PatientSCreen.dart';
import 'package:healthapp/screens/doctor/PrescibeScreen.dart';

class DoctorHomeScreen extends StatefulWidget {
  final int doctorId;
  final String doctorName;

  const DoctorHomeScreen({super.key, required this.doctorId, required this.doctorName});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  // screen selector index
  int _selectedIndex=0;
  late final List<Widget>_screens;

  @override
  void initState() {
    
    super.initState();
    _screens=[
      // sharing data from this screen to the prescribe screen 
      PrescribeScreen(doctorId:widget.doctorId),
      PatientsSCreen(),
      AppointmentsScreen()

    ];
  }

  // what happens when the navigation is tapped
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Doctor Home SCreen"),),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: "Prescribe"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: "Patients"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Appointments"
          )
        ]
      ),
    );
  }
}