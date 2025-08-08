import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Plan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Recommended Diet',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDietCard('🥗 Breakfast', 'Oatmeal, fruits, and green tea.'),
          _buildDietCard('🍛 Lunch', 'Grilled chicken, brown rice, and vegetables.'),
          _buildDietCard('🥣 Snack', 'Nuts and Greek yogurt.'),
          _buildDietCard('🍲 Dinner', 'Salmon, sweet potatoes, and spinach.'),
        ],
      ),
    );
  }

  Widget _buildDietCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
