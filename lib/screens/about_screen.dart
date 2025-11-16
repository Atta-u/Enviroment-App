import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'About Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.eco, size: 90, color: Colors.green),
            const SizedBox(height: 15),
            Text(
              "Sustainable Living Guide",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "We are committed to promoting eco-friendly lifestyles by helping users "
              "track carbon footprint, reduce waste, discover sustainable products, "
              "and adopt greener living habits.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _AboutFeature(icon: Icons.eco, label: "Carbon Aware"),
                _AboutFeature(icon: Icons.shopping_bag, label: "Eco Products"),
                _AboutFeature(icon: Icons.flag, label: "Daily Challenges"),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Text(
                      "Our Mission 🌱",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "To inspire and empower individuals to reduce their environmental "
                      "impact and create a more sustainable future.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutFeature extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AboutFeature({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 35, color: Colors.green.shade700),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green.shade900,
          ),
        ),
      ],
    );
  }
}
