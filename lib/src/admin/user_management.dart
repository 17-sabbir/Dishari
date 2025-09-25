import 'package:flutter/material.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  String selectedCategory = "Doctor";
  final TextEditingController searchController = TextEditingController();

  final Map<String, List<Map<String, String>>> _allUsers = {
    "Doctor": [
      {"name": "Dr. Rahim", "email": "rahim@hospital.com", "role": "Doctor"},
      {"name": "Dr. Karim", "email": "karim@hospital.com", "role": "Doctor"},
    ],
    "Dispenser": [
      {"name": "Dispenser Ali", "email": "ali@dispensary.com", "role": "Dispenser"},
    ],
    "Lab Tester": [
      {"name": "Tester Babu", "email": "babu@lab.com", "role": "Lab Tester"},
    ],
    "Patient": [
      {"name": "Patient Mina", "email": "mina@gmail.com", "role": "Patient"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final users = _allUsers[selectedCategory]!
        .where((user) =>
    searchController.text.isEmpty ||
        user["email"]!.toLowerCase().contains(searchController.text.toLowerCase()) ||
        user["name"]!.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔹 Category selection
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: const [
                    DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
                    DropdownMenuItem(value: "Dispenser", child: Text("Dispenser")),
                    DropdownMenuItem(value: "Lab Tester", child: Text("Lab Tester")),
                    DropdownMenuItem(value: "Patient", child: Text("Patient")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      searchController.clear();
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Search bar
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search by Name/Email",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Users List
            users.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Text(
                  "No accounts found",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true, // important for scroll inside scroll
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.person, color: Colors.blue),
                    ),
                    title: Text(
                      user["name"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${user["email"]} • ${user["role"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _allUsers[selectedCategory]!.remove(user);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Account deleted")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // 🔹 Create Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () { final TextEditingController nameController = TextEditingController();
        final TextEditingController emailController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();
        String role = selectedCategory;

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Create Account"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: role,
                      items: const [
                        DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
                        DropdownMenuItem(value: "Dispenser", child: Text("Dispenser")),
                        DropdownMenuItem(value: "Lab Tester", child: Text("Lab Tester")),
                        DropdownMenuItem(value: "Patient", child: Text("Patient")),
                        DropdownMenuItem(value: "Admin", child: Text("Admin")),
                      ],
                      onChanged: (value) {
                        role = value!;
                      },
                      decoration: const InputDecoration(labelText: "Select Role"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _allUsers[role]!.add({
                        "name": nameController.text,
                        "email": emailController.text,
                        "role": role,
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$role created successfully")),
                    );
                  },
                  child: const Text("Create"),
                ),
              ],
            );
          },
        );
        },
        icon: const Icon(Icons.add),
        label: const Text("Create Account",),
      ),
    );
  }
}
