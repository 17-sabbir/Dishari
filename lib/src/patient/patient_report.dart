import 'package:flutter/material.dart';

class PatientReports extends StatefulWidget {
  const PatientReports({super.key});

  @override
  State<PatientReports> createState() => _PatientReportsState();
}

class _PatientReportsState extends State<PatientReports> {
  final Color kPrimaryColor = const Color(0xFF00796B); // Deep Teal

  // SRS Compliance: Dummy reports (later replace with DB data)
  final List<Map<String, String>> reports = const [
    {
      "date": "2025-09-05",
      "type": "Blood Test (Internal)",
      "doctor": "Dr. Wakil Ahmed",
      "status": "Normal",
      "notes": "Hemoglobin levels are stable. No concerns."
    },
    {
      "date": "2025-08-28",
      "type": "Urine Test (Internal)",
      "doctor": "Dr. Shahjabin Sharna",
      "status": "Infection Detected",
      "notes": "Indication of UTI. Medication prescribed."
    },
    {
      "date": "2025-08-10",
      "type": "X-Ray (Chest) (External)",
      "doctor": "Self Uploaded",
      "status": "Clear",
      "notes": "Lungs appear clear. Consult with your doctor."
    },
    {
      "date": "2025-07-20",
      "type": "Sugar Test (Internal)",
      "doctor": "Dr. Wakil Ahmed",
      "status": "High",
      "notes": "Fasting blood sugar is elevated. Follow dietary advice."
    },
  ];

  Color _getStatusColor(String status) {
    if (status.contains("Normal") || status.contains("Clear")) {
      return Colors.green.shade700;
    } else if (status.contains("Infection") || status.contains("High")) {
      return Colors.red.shade700;
    } else {
      return Colors.blueGrey;
    }
  }

  IconData _getStatusIcon(String status) {
    if (status.contains("Normal") || status.contains("Clear")) {
      return Icons.check_circle_outline;
    } else if (status.contains("Infection") || status.contains("High")) {
      return Icons.warning_amber_outlined;
    } else {
      return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("My Reports", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          final statusColor = _getStatusColor(report["status"]!);
          final statusIcon = _getStatusIcon(report["status"]!);

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: statusColor.withOpacity(0.3), width: 1.5) // Status border
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Report Date and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: kPrimaryColor, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            report["date"]!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),

                      // Status Indicator (Visually improved)
                      Row(
                        children: [
                          Icon(statusIcon, color: statusColor, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            report["status"]!,
                            style: TextStyle(
                                fontSize: 15,
                                color: statusColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),

                  // Report Type
                  Text(
                    report["type"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Doctor
                  Text(
                    "Reviewed by: ${report["doctor"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Notes/Summary
                  Text(
                    "Notes: ${report["notes"]}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic
                    ),
                  ),


                  const SizedBox(height: 15),

                  // Download button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // SRS Compliance: Download or view action logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Downloading ${report["type"]} from ${report["date"]}...")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                      ),
                      icon: const Icon(Icons.download, color: Colors.white, size: 18),
                      label: const Text(
                        "Download",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}