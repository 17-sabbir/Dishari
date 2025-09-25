import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile",style: TextStyle(color: Colors.blueAccent),),
      automaticallyImplyLeading: false,
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.teal),
            const SizedBox(height: 10),
            const Text("Dr. John Doe",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Cardiologist"),

            const Divider(height: 40),

            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change Password"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                // Logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
