import 'package:flutter/material.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Admin Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.admin_panel_settings, size: 50),
            ),
            const SizedBox(height: 20),
            const Text("Name: Admin User",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Email: admin@university.edu",
                style: TextStyle(fontSize: 16)),
            const Text("Role: Administrator", style: TextStyle(fontSize: 16)),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.blue),
              title: const Text("Contact Info"),
              subtitle: const Text("Phone: +880 1234 567890"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype, color: Colors.red),
              title: const Text("Blood Group"),
              subtitle: const Text("O+"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text("Allergies"),
              subtitle: const Text("Penicillin"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
