import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:healthapp/screens/diet.dart';
import 'package:healthapp/screens/exercise.dart';
import 'package:healthapp/screens/sleep.dart';
import 'package:healthapp/screens/mental_health.dart';
import 'package:healthapp/screens/hydration.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // 🔄 Auto switch based on system theme
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        useMaterial3: false,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        cardColor: Colors.grey[850],
        scaffoldBackgroundColor: Colors.black,
      ),
      home:  HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  List<Map<String, dynamic>> get cards => [
        {
          'title': 'Diet Guide',
          'image': 'assets/images/diet.jpg',
          'screen':  DietScreen(),
        },
        {
          'title': 'Exercise',
          'image': 'assets/images/exercise.jpg',
          'screen':  ExerciseScreen(),
        },
        {
          'title': 'Hydration',
          'image': 'assets/images/water.jpg',
          'screen':  HydrationScreen(),
        },
        {
          'title': 'Mental Health',
          'image': 'assets/images/mental.jpg',
          'screen':  MentalHealthScreen(),
        },
        {
          'title': 'Sleep Tips',
          'image': 'assets/images/sleep.jpg',
          'screen':  SleepScreen(),
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Health Categories', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            return GestureDetector(              
              onTap: () {                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => card['screen']),
                );
              },
              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // ✅ Fade-in image with placeholder
                    Positioned.fill(
                      child: FadeInImage(
                        placeholder:  AssetImage('assets/images/yoga.jpg'),
                        image: AssetImage(card['image']),
                        fit: BoxFit.cover,
                        fadeInDuration:  Duration(milliseconds: 300),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    // Title
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Text(
                        card['title'],
                        style:  TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
