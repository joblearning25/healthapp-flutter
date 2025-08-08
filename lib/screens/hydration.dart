import 'package:flutter/material.dart';

class HydrationScreen extends StatelessWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hydration Tips')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Stay Hydrated',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTipCard('💧 Drink Regularly', 'Don’t wait to feel thirsty.'),
          _buildTipCard('🍋 Flavor It', 'Add lemon or cucumber to make water more enjoyable.'),
          _buildTipCard('📱 Set Reminders', 'Use apps or alarms to remind you to drink.'),
          _buildTipCard('🥤 Water First', 'Start your meals with a glass of water.'),
          _buildTipCard('🥗 Eat Hydrating Foods', 'Fruits like watermelon and cucumber help hydrate.'),
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
