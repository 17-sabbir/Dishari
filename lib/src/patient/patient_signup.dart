import 'package:flutter/material.dart';
import 'package:spl2/src/universal_login.dart';
import 'package:spl2/src/patient/patient_dashboard.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _sessionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController(); // optional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Registration Form',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),

              // Full Name
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Full Name',
                  hintText: 'Md Sabbir Ahamed',
                  prefixIcon: const Icon(Icons.person, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'abc@gmail.com or abc@student.nstu.edu.bd',
                  prefixIcon: const Icon(Icons.mail, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Phone Number
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+8801********',
                  prefixIcon: const Icon(Icons.phone, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Student ID
              TextField(
                controller: _studentIdController,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  hintText: "ASH2225005M",
                  prefixIcon: const Icon(Icons.badge, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Department
              TextField(
                controller: _departmentController,
                decoration: InputDecoration(
                  labelText: 'Department',
                  hintText: 'IIT',
                  prefixIcon: const Icon(Icons.business, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Session
              TextField(
                controller: _sessionController,
                decoration: InputDecoration(
                  labelText: 'Session',
                  hintText: '2021-2022',
                  prefixIcon: const Icon(Icons.calendar_month, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm Password
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Blood Group
              TextField(
                controller: _bloodGroupController,
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  hintText: '(e.g. B-, O+, O-)',
                  prefixIcon: const Icon(Icons.bloodtype, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Allergies (optional)
              TextField(
                controller: _allergiesController,
                decoration: InputDecoration(
                  labelText: 'Allergies (if any)',
                  hintText: '(e.g. Dal, Dust)',
                  prefixIcon: const Icon(Icons.health_and_safety, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String phone = _phoneController.text;
                    String studentId = _studentIdController.text;
                    String department = _departmentController.text;
                    String session = _sessionController.text;
                    String password = _passwordController.text;
                    String confirmPassword = _confirmPasswordController.text;
                    String bloodGroup = _bloodGroupController.text;
                    String allergies = _allergiesController.text; // optional

                    // Validate required fields (excluding Allergies)
                    if (name.isEmpty ||
                        email.isEmpty ||
                        phone.isEmpty ||
                        studentId.isEmpty ||
                        department.isEmpty ||
                        session.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty ||
                        bloodGroup.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all required fields"),
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match"),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientDashboard(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 6,
                    shadowColor: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Already registered?
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Already Registered?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
