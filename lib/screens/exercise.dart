import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Plan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Recommended Exercises',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildExerciseCard('🚶 Morning Walk', '30 minutes brisk walking'),
          _buildExerciseCard('🏋️ Strength Training', 'Full-body workout, 3 times a week'),
          _buildExerciseCard('🧘 Yoga', '15-20 minutes daily for flexibility and stress relief'),
          _buildExerciseCard('🚴 Cardio', 'Cycling or running, 3 times a week'),
          _buildExerciseCard('🛌 Stretching', 'Before bed to relax muscles'),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
