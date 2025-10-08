// this is the lab tester profile page

import 'package:flutter/material.dart';

class LabTesterProfile extends StatefulWidget {
  const LabTesterProfile({super.key});
  @override
  State<LabTesterProfile> createState() => _LabTesterProfileState();
}
class _LabTesterProfileState extends State<LabTesterProfile> {
  String name = " Kamal Hosen";
  String email = "kamlhosen@nstu.edu.bd";
  String phone = "+880 1712 345678";
  String department = "Pathology Laboratory";
  String joinedDate = "January 15, 2022";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Change Password"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _oldPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Current Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter current password" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _newPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Enter new password";
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm New Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Confirm new password" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      if (_newPassword.text == _confirmPassword.text) {
        Navigator.pop(context); // Close dialog first
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password changed successfully"),
            backgroundColor: Colors.green,
          ),
        );
        _oldPassword.clear();
        _newPassword.clear();
        _confirmPassword.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("New passwords do not match"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("My Profile",style: TextStyle(color: Colors.blueAccent),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.science, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Senior Lab Technician",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildProfileInfoRow(Icons.email, "Email", email),
                    const SizedBox(height: 12),
                    _buildProfileInfoRow(Icons.phone, "Phone", phone),
                    const SizedBox(height: 12),
                    _buildProfileInfoRow(Icons.work, "Department", department),
                    const SizedBox(height: 12),
                    _buildProfileInfoRow(
                      Icons.calendar_today,
                      "Joined",
                      joinedDate,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Change Password Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _showChangePasswordDialog,
                icon: const Icon(Icons.lock_reset),
                label: const Text("Change Password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Additional Options
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.blue,
                    ),
                    title: const Text("Notification Settings"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to notification settings
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      // Implement logout
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}