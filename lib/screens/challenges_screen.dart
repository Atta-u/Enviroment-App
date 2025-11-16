import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = [
      'Plastic-Free Week',
      'Meatless Monday for a month',
      'Reduce AC use by 2°C',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(challenges[index]),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${challenges[index]} accepted')));
                },
                child: const Text('Accept'),
              ),
            ),
          );
        },
      ),
    );
  }
}
