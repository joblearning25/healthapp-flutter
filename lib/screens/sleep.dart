import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep Tips')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Better Sleep Habits',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTipCard('🛏️ Regular Schedule', 'Go to bed and wake up at the same time daily.'),
          _buildTipCard('📵 Avoid Screens', 'No screens at least 1 hour before bed.'),
          _buildTipCard('☕ Avoid Caffeine', 'Limit caffeine intake in the evening.'),
          _buildTipCard('🕯️ Relaxing Routine', 'Try reading or meditating before sleep.'),
          _buildTipCard('🌡️ Comfortable Room', 'Keep room cool, dark, and quiet.'),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
