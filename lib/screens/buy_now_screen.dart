import 'package:flutter/material.dart';

class BuyNowScreen extends StatelessWidget {
  final Map<String, String> product;

  const BuyNowScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F2),
      appBar: AppBar(
        title: Text(
          'Buy ${product['title']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product['image']!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🏷 Product Name
            Text(
              product['title']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 10),

            // 🧾 Subtitle
            Text(
              product['subtitle']!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // 💵 Price
            Text(
              'Price: ${product['price']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Spacer(),

            // 🛒 Confirm Purchase Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product['title']} purchased successfully!',
                        style: const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.green.shade700,
                    ),
                  );

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text(
                  'Confirm Purchase',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
