import 'package:flutter/material.dart';
import 'doctor_profile.dart';
import 'setting.dart';
import 'patient_records.dart';
import 'emergency_cases.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _currentIndex = 0;

  // keep track of visited page history
  final List<int> _navigationHistory = [];

  final List<Widget> _pages = [
    const ProfilePage(),
    const PatientRecordsPage(),
    const EmergencyCasesPage(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigationHistory.isNotEmpty) {
          setState(() {
            _currentIndex = _navigationHistory.removeLast();
          });
          return false; // Don't exit app, just go back to previous tab
        } else {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit App?"),
              content: const Text("Do you want to exit the application?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
          return shouldExit ?? false;
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              if (index != _currentIndex) {
                _navigationHistory.add(_currentIndex); // save previous index
                _currentIndex = index;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Patients",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emergency),
              label: "Emergency",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return const Text("My Profile");
      case 1:
        return const Text("Patient Records");
      case 2:
        return const Text("Emergency Cases");
      case 3:
        return const Text("Settings");
      default:
        return const Text("Doctor Dashboard");
    }
  }
}
