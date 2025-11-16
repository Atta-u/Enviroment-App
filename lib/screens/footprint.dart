import 'package:flutter/material.dart';

class CarbonFootprintScreen extends StatefulWidget {
  const CarbonFootprintScreen({super.key});

  @override
  State<CarbonFootprintScreen> createState() => _CarbonFootprintScreenState();
}

class _CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  final TextEditingController carKmController = TextEditingController();
  final TextEditingController electricityController = TextEditingController();
  final TextEditingController meatController = TextEditingController();

  double? result;
  String suggestion = "";

  void calculateFootprint() {
    double carKm = double.tryParse(carKmController.text) ?? 0;
    double electricity = double.tryParse(electricityController.text) ?? 0;
    double meat = double.tryParse(meatController.text) ?? 0;

    // ✅ Simple Carbon Footprint Formula (approximation for UI demonstration)
    double carbon = (carKm * 0.12) + (electricity * 0.5) + (meat * 1.2);

    setState(() {
      result = carbon;

      if (carbon < 10) {
        suggestion = "Great! Your carbon footprint is low 🌱\nKeep using eco-friendly habits!";
      } else if (carbon < 25) {
        suggestion =
            "Good effort! 😊\nTry reducing car usage and save more electricity.";
      } else {
        suggestion =
            "High carbon footprint ⚠\nConsider public transport, energy-saving appliances & reduce meat consumption.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Tracker'),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calculate Your Daily Carbon Footprint 🌍",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Inputs
            buildInputField("Daily km by Car", carKmController),
            buildInputField("Electricity (kWh per day)", electricityController),
            buildInputField("Meat meals per week", meatController),

            const SizedBox(height: 20),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: calculateFootprint,
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Result Display
            if (result != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.lightGreen.shade100,
                ),
                child: Column(
                  children: [
                    Text(
                      "Your Footprint: ${result!.toStringAsFixed(2)} kg CO₂/day",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      suggestion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Reusable Input Widget
  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
