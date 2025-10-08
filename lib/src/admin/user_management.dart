import 'package:flutter/material.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  String selectedCategory = "Doctor";
  final TextEditingController searchController = TextEditingController();
  final Color primaryColor = const Color(0xFF00796B); // Deep Teal

  // Dummy data: Roles as per SRS (Doctor, Dispenser, Lab Staff, Patient, Admin)
  final Map<String, List<Map<String, String>>> _allUsers = {
    "Doctor": [
      {"name": "Dr. Amina Patel", "email": "amina@nstumedical.com", "role": "Doctor", "icon": "local_hospital"},
      {"name": "Dr. Hasan Khan", "email": "hasan@nstumedical.com", "role": "Doctor", "icon": "local_hospital"},
    ],
    "Dispenser": [
      {"name": "Dispenser Sumon", "email": "sumon@pharmacy.com", "role": "Dispenser", "icon": "medication"},
    ],
    "Lab Staff": [
      {"name": "Lab Tech Lima", "email": "lima@lab.com", "role": "Lab Staff", "icon": "science"},
    ],
    "Patient": [
      {"name": "Mina Akter", "email": "mina@gmail.com", "role": "Patient", "icon": "person"},
      {"name": "Arif Islam", "email": "arif@gmail.com", "role": "Patient", "icon": "person"},
    ],
    "Admin": [
      {"name": "Admin User", "email": "admin@healthcare.org", "role": "Admin", "icon": "admin_panel_settings"},
    ],
  };

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'local_hospital': return Icons.local_hospital;
      case 'medication': return Icons.medication;
      case 'science': return Icons.science;
      case 'admin_panel_settings': return Icons.admin_panel_settings;
      default: return Icons.person;
    }
  }

  // Improved UI: Filter Chips for selection
  Widget _buildCategorySelector() {
    final categories = _allUsers.keys.toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(category),
              selected: selectedCategory == category,
              selectedColor: primaryColor.withOpacity(0.8),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: selectedCategory == category ? Colors.white : Colors.black87,
                fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = _allUsers[selectedCategory]!
        .where((user) =>
    searchController.text.isEmpty ||
        user["email"]!.toLowerCase().contains(searchController.text.toLowerCase()) ||
        user["name"]!.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search User by Name or Email",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00796B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            _buildCategorySelector(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Icon(_getIcon(user['icon']!), color: primaryColor),
                      ),
                      title: Text(
                        user['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        "${user['email']!}\nRole: ${user['role']!}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Implement user modification logic here (dummy)
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Editing ${user['name']}...")));
                        },
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddUserDialog(context),
        label: const Text("Create Account", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        String role = "Doctor"; // Default role
        final nameController = TextEditingController();
        final emailController = TextEditingController();

        // Validation state variables
        bool _isNameValid = true;
        bool _isEmailValid = true;
        bool _isPasswordValid = true;

        // Use StatefulBuilder to manage validation state locally
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Create New User"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        errorText: _isNameValid ? null : "Name is required", // Error feedback
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email/ID",
                        errorText: _isEmailValid ? null : "Email/ID is required", // Error feedback
                      ),
                    ),
                    // Initial Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: true, // Hides the password input
                      decoration: InputDecoration(
                        labelText: "Initial Password",
                        prefixIcon: const Icon(Icons.lock),
                        errorText: _isPasswordValid ? null : "Password is required", // Error feedback
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: role,
                      items: const [
                        DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
                        DropdownMenuItem(value: "Dispenser", child: Text("Dispenser")),
                        DropdownMenuItem(value: "Lab Staff", child: Text("Lab Staff")),
                        DropdownMenuItem(value: "Patient", child: Text("Patient")),
                        DropdownMenuItem(value: "Admin", child: Text("Admin")),
                      ],
                      onChanged: (value) {
                        setStateDialog(() { // Use setStateDialog to update role locally
                          role = value!;
                        });
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
                    // --- Validation Logic ---
                    bool isValid = true;

                    // Reset and Check Name
                    if (nameController.text.isEmpty) {
                      isValid = false;
                      setStateDialog(() { _isNameValid = false; });
                    } else {
                      setStateDialog(() { _isNameValid = true; });
                    }

                    // Reset and Check Email
                    if (emailController.text.isEmpty) {
                      isValid = false;
                      setStateDialog(() { _isEmailValid = false; });
                    } else {
                      setStateDialog(() { _isEmailValid = true; });
                    }

                    // Reset and Check Password
                    if (passwordController.text.isEmpty) {
                      isValid = false;
                      setStateDialog(() { _isPasswordValid = false; });
                    } else {
                      setStateDialog(() { _isPasswordValid = true; });
                    }

                    // If validation fails, return early. Error text will show automatically.
                    if (!isValid) {
                      return;
                    }
                    // --- End Validation Logic ---


                    // If valid, proceed with creation (using the main setState for UI update)
                    setState(() {
                      _allUsers[role]!.add({
                        "name": nameController.text,
                        "email": emailController.text,
                        "role": role,
                        "icon": role == "Doctor" ? "local_hospital" : (role == "Admin" ? "admin_panel_settings" : "person"),
                      });
                    });

                    Navigator.pop(context);

                    // Success message still shows via SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$role ${nameController.text} created successfully with initial password: ${passwordController.text}")),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("Create", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}