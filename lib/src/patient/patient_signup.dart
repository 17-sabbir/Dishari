import 'package:flutter/material.dart';
import 'package:spl2/src/home_page.dart';
import 'package:spl2/src/patient/patient_dashboard.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  // Controllers for new fields
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _sessionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow scroll when keyboard appears
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
                obscureText: false,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
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

              // University Email/ID
              TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  labelText: 'University Email/ID',
                  hintText: 'ASH***M or abc@student.nstu.edu.bd',
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
                obscureText: false,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
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

              // 🔹 New: Student ID
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

              // 🔹 New: Department
              TextField(
                controller: _departmentController,
                decoration: InputDecoration(
                  labelText: "Department",
                  hintText: "CSE",
                  prefixIcon: const Icon(Icons.school, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 New: Session
              TextField(
                controller: _sessionController,
                decoration: InputDecoration(
                  labelText: "Session",
                  hintText: "2022-2023",
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
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
                obscureText: true,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
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
                obscureText: true,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
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
                obscureText: false,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
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

              // Allergies
              TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  labelText: 'Allergies (if any)',
                  hintText: '(e,g. Dal,Dust)',
                  prefixIcon:
                  const Icon(Icons.health_and_safety, color: Colors.blue),
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
