import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or ID is required';
    }
    return null; // no other checks
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null; // no length check
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double horizontalPadding;
    if (screenWidth < 600) {
      horizontalPadding = 20.0; // মোবাইল
    } else {
      horizontalPadding = screenWidth * 0.3; // ওয়েব/ট্যাব
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),

                // Icon with shadow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.local_hospital,
                    size: 60,
                    color: Colors.blue.shade700,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  'Dishari',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue.shade700,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 30),

                // ID/Email Field
                TextFormField(//input validation er jonne textformfield use kora hoise
                  controller: _idController,
                  obscureText: false,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Enter your ID or Email',
                    hintText: 'ASH****M',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person, color: Colors.blue),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: _validateEmail,
                ),

                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Enter Your Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: _validatePassword
                ),

                const SizedBox(height: 40),

                // Login Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      final input = _idController.text.trim().toLowerCase();

                      if (input == 'admin') {
                        Navigator.pushNamed(context, '/admin-dashboard');
                      } else if (input == 'patient') {
                        Navigator.pushNamed(context, '/patient-dashboard');
                      } else if (input == 'dispenser') {
                        Navigator.pushNamed(context, '/dispenser-dashboard');
                      } else if (input == 'doctor') {
                        Navigator.pushNamed(context, '/doctor-dashboard');
                      } else if (input == 'lab') {
                        Navigator.pushNamed(context, '/lab-dashboard');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter admin/doctor/lab/patient/dispenser',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }
                    }},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Log In',
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

                // Forget Password Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Forget Password?'),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Click here'),
                    ),
                  ],
                ),

                // SignUp Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Not yet registered?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/patient-signup');
                      },
                      child: const Text('SignUp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}