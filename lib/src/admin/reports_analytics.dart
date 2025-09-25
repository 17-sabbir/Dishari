import 'package:flutter/material.dart';

class ReportsAnalytics extends StatelessWidget {
  const ReportsAnalytics({super.key});

  // Sample data for reports
  final List<Map<String, dynamic>> prescriptionReports = const [
    {"period": "Today", "prescriptions": 128, "uniquePatients": 84, "medicinesUsed": 42},
    {"period": "This Week", "prescriptions": 560, "uniquePatients": 400, "medicinesUsed": 210},
    {"period": "This Month", "prescriptions": 2300, "uniquePatients": 1800, "medicinesUsed": 950},
    {"period": "This Year", "prescriptions": 28000, "uniquePatients": 21000, "medicinesUsed": 10500},
  ];

  final List<Map<String, dynamic>> diseaseTrends = const [
    {"disease": "Influenza", "weeklyCases": 32, "monthlyCases": 128},
    {"disease": "Hypertension", "weeklyCases": 24, "monthlyCases": 95},
    {"disease": "Diabetes", "weeklyCases": 19, "monthlyCases": 80},
    {"disease": "COVID-19", "weeklyCases": 8, "monthlyCases": 35},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Prescription Reports",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...prescriptionReports.map((report) => Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(
                "${report['period']} Prescriptions: ${report['prescriptions']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Unique Patients: ${report['uniquePatients']} | Medicines Used: ${report['medicinesUsed']}"),
            ),
          )),

          const SizedBox(height: 20),
          const Text(
            "Disease Trends",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...diseaseTrends.map((disease) => Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(
                disease['disease'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Weekly Cases: ${disease['weeklyCases']} | Monthly Cases: ${disease['monthlyCases']}"),
            ),
          )),
        ],
      ),
    );
  }
}
