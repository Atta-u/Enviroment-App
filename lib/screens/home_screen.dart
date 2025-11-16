import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _electricityController = TextEditingController();
  final TextEditingController _travelController = TextEditingController();

  double? carbonFootprint;
  String suggestion = "";

  bool showCalculator = false;

  void calculateCarbonFootprint() {
    double electricity = double.tryParse(_electricityController.text) ?? 0;
    double travel = double.tryParse(_travelController.text) ?? 0;
    double footprint = (electricity * 0.5) + (travel * 0.21);

    setState(() {
      carbonFootprint = footprint;
      if (footprint < 50) {
        suggestion = "✅ Great job! Very low footprint 🌱";
      } else if (footprint < 100) {
        suggestion = "🙂 Good effort! Try reducing travel a bit";
      } else {
        suggestion = "⚠️ High footprint! Use public transport more 🚴‍♂️";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F0),
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: const Text(
          'Sustainable Living',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade700),
              accountName: const Text("User Name"),
              accountEmail: const Text("user@example.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.green, size: 45),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () => Navigator.pushNamed(context, '/contact'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
            ),
          ],
        ),
      ),
      body: showCalculator ? _carbonCalculatorUI() : _homeOptionsUI(),
    );
  }

  Widget _homeOptionsUI() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD7F9D7), Color(0xFFF0FFF0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Welcome 🌿\nChoose a section to explore",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _HomeCard(
                    title: "Carbon Footprint",
                    icon: Icons.eco,
                    color: Colors.green,
                    onTap: () => setState(() => showCalculator = true),
                  ),
                  _HomeCard(
                    title: "Products",
                    icon: Icons.shopping_bag,
                    color: Colors.teal,
                    onTap: () => Navigator.pushNamed(context, '/products'),
                  ),
                  _HomeCard(
                    title: "Challenges",
                    icon: Icons.flag,
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/Challange'),
                  ),
                  _HomeCard(
                    title: "Waste Tracker",
                    icon: Icons.delete,
                    color: Colors.redAccent,
                    onTap: () => Navigator.pushNamed(context, '/waste'),
                  ),
                  _HomeCard(
                    title: "Recipes",
                    icon: Icons.restaurant,
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/recipes'),
                  ),
                  _HomeCard(
                    title: "Gallery",
                    icon: Icons.photo,
                    color: Colors.blueAccent,
                    onTap: () => Navigator.pushNamed(context, '/gallery'),
                  ),
                  _HomeCard(
                    title: "Profile",
                    icon: Icons.person,
                    color: Colors.green.shade800,
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carbonCalculatorUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Calculate Your Carbon Footprint 🌍",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTextField(_electricityController, "Electricity usage (kWh per month)"),
          const SizedBox(height: 12),
          _buildTextField(_travelController, "Travel Distance (km per week)"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: calculateCarbonFootprint,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Calculate", style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 20),
          if (carbonFootprint != null) ...[
            Text(
              "Carbon Footprint: ${carbonFootprint!.toStringAsFixed(2)} kg CO₂/month",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 10),
            Text(
              suggestion,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => setState(() => showCalculator = false),
            child: const Text("← Back"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  const _HomeCard({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Choose a readable text color depending on the card color brightness
    final textColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.18),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

        
      
    
  

