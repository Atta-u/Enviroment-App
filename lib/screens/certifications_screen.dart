import 'package:flutter/material.dart';

class CertificationsScreen extends StatelessWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final labels = [
      {'title': 'Energy Star', 'desc': 'Energy efficiency'},
      {'title': 'Fair Trade', 'desc': 'Ethical production'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Green Certifications & Labels')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final l = labels[index];
          return Card(
            child: ListTile(
              title: Text(l['title']!),
              subtitle: Text(l['desc']!),
            ),
          );
        },
      ),
    );
  }
}
