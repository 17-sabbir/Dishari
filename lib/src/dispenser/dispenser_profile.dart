import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DispenserProfile extends StatefulWidget {
  const DispenserProfile({super.key});

  @override
  State<DispenserProfile> createState() => _DispenserProfileState();
}

class _DispenserProfileState extends State<DispenserProfile> {
  String name = 'Rakib Islam';
  String email = 'Rakib@university.edu';
  File? _avatar;

  final ImagePicker _picker = ImagePicker();

  void _changePassword() {
    showDialog(
      context: context,
      builder: (ctx) {
        final newCtrl = TextEditingController();
        final confirmCtrl = TextEditingController();
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: confirmCtrl,
                obscureText: true,
                decoration:
                const InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newCtrl.text == confirmCtrl.text) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password changed (dummy)')));
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logged out (dummy)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dispenser Profile',
          style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  InkWell(
                    onTap: () async {
                      // Directly open gallery here manually
                      final x = await _picker.pickImage(
                          source: ImageSource.gallery);
                      if (x != null) {
                        setState(() {
                          _avatar = File(x.path);
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      _avatar != null ? FileImage(_avatar!) : null,
                      child: _avatar == null
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () async {
                        // Directly open gallery manually for edit icon
                        final x = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (x != null) {
                          setState(() {
                            _avatar = File(x.path);
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.edit,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Name', border: InputBorder.none),
                              controller: TextEditingController(text: name),
                              readOnly: false, // Editable now
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Email', border: InputBorder.none),
                              controller: TextEditingController(text: email),
                              readOnly: false, // Editable now
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _changePassword,
                        icon: const Icon(Icons.lock),
                        label: const Text('Change Password'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.4,
                            48,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Profile saved (dummy)')));
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.4,
                            48,
                          ),
                        ),

                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.4,
                            48,
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
