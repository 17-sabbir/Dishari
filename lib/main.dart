import 'package:flutter/material.dart';
import 'package:spl2/src/universal_login.dart';
import 'package:spl2/src/admin/admin_dashboard.dart';
import 'package:spl2/src/doctor/doctor_dashboard.dart';
import 'package:spl2/src/doctor/prescription_page.dart';
import 'package:spl2/src/doctor/setting.dart';
import 'package:spl2/src/doctor/doctor_profile.dart';
import 'package:spl2/src/dispenser/dispenser_dashboard.dart';
import 'package:spl2/src/dispenser/dispenser_profile.dart';
import 'package:spl2/src/lab_test/lab_tester_home.dart';
import 'package:spl2/src/lab_test/lab_staff_profile.dart';
import 'package:spl2/src/patient/patient_dashboard.dart';
import 'package:spl2/src/patient/patient_profile.dart';
import 'package:spl2/src/patient/patient_prescriptions.dart';
import 'package:spl2/src/patient/patient_report.dart';
import 'package:spl2/src/patient/patient_report_upload.dart';
import 'package:spl2/src/patient/patient_lab_test_availability.dart';
import 'package:spl2/src/patient/patient_ambulance_staff.dart';
import 'package:spl2/src/patient/patient_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Center Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/doctor-dashboard': (context) => const DoctorDashboard(),
        '/prescription-page': (context) => const PrescriptionPage(),
        '/doctor-reports': (context) => const Setting(),
        '/doctor-profile': (context) => const ProfilePage(),
        '/dispenser-dashboard': (context) => const DispenserDashboard(),
        '/dispenser-profile': (context) => const DispenserProfile(),
        '/lab-dashboard': (context) => const LabTesterHome(),
        '/lab-panel': (context) => const LabTesterHome(),
        '/lab-profile': (context) => const LabTesterProfile(),
        '/patient-dashboard': (context) => const PatientDashboard(),
        '/patient-profile': (context) => const PatientProfilePage(),
        '/patient-prescriptions': (context) => const PatientPrescriptions(),
        '/patient-reports': (context) => const PatientReports(),
        '/patient-report-upload': (context) => const PatientReportUpload(),
        '/patient-lab-availability': (context) => const PatientLabTestAvailability(),
        '/patient-ambulance-staff': (context) => const PatientAmbulanceStaff(),
        '/patient-signup': (context) => const PatientSignupPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
        body: Center(child: Text("Page not found"),),
    ),
      ),
    );
  }
}