import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    try {
      final doc = await _firestore.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        setState(() => userData = doc.data());
      } else {
        setState(() => userData = {'name': 'Guest', 'email': user!.email});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading profile: $e")),
        );
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  Stream<QuerySnapshot> getOrders(String status) {
    if (user == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: user!.uid)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: const Center(
          child: Text('You are not logged in. Please login first.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: logout),
        ],
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchUserData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 🌿 Profile Card
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, size: 50, color: Color(0xFF4CAF50)),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData?['name'] ?? 'User',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userData?['email'] ?? '',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Joined: ${_formatDate(userData?['createdAt'])}",
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🕒 Pending Orders
                    _orderSection("Pending Orders", getOrders("pending")),
                    const SizedBox(height: 20),

                    // ✅ Delivered Orders
                    _orderSection("Delivered Orders", getOrders("delivered")),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _orderSection(String title, Stream<QuerySnapshot> stream) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text("No orders found.");
            }

            return Column(
              children: snapshot.data!.docs.map((doc) {
                final order = doc.data() as Map<String, dynamic>;
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text("Order ID: ${doc.id}"),
                    subtitle: Text("Status: ${order['status']}"),
                    trailing: Text(
                      order['total'] != null ? "\$${order['total']}" : "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      final date = timestamp.toDate();
      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return 'Unknown';
    }
  }
}
