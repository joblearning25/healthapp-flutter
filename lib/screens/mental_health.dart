import 'package:flutter/material.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mental Health')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Mental Wellbeing Tips',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTipCard('🧘 Mindfulness', 'Practice meditation or breathing exercises.'),
          _buildTipCard('💬 Talk to Someone', 'Share your thoughts with friends or professionals.'),
          _buildTipCard('🛑 Take Breaks', 'Avoid burnout by resting between tasks.'),
          _buildTipCard('📔 Journal', 'Write down your thoughts and emotions daily.'),
          _buildTipCard('🚶 Exercise', 'Physical activity improves mood and reduces stress.'),
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
