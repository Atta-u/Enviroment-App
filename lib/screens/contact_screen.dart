import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.support_agent, size: 80, color: Colors.green),
            const SizedBox(height: 15),
            Text(
              "We're here to help! 💬",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Have questions or suggestions? "
              "Feel free to reach out to us anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 25),

            /// Name Input
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Email Input
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Message Input
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Your Message",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.message),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),

            /// Send button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Message Sent! ✅ (UI only)'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  "Send Message",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
