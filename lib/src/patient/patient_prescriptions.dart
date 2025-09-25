import 'package:flutter/material.dart';

class PatientPrescriptions extends StatefulWidget {
  const PatientPrescriptions({super.key});

  @override
  State<PatientPrescriptions> createState() => _PatientPrescriptionsPageState();
}

class _PatientPrescriptionsPageState extends State<PatientPrescriptions> {
  // Example prescriptions (later replace with data from DB)
  final List<Map<String, String>> prescriptions = [
    {
      "date": "2025-09-01",
      "doctor": "Dr. Wakil Ahmed",
      "medicines": "Paracetamol 500mg (2x daily), Cough Syrup (10ml at night)"
    },
    {
      "date": "2025-08-20",
      "doctor": "Mr. Muhammad Jahidur Rahman",
      "medicines": "Amoxicillin 250mg (3x daily), Vitamin C 500mg (1x daily)"
    },
    {
      "date": "2025-08-05",
      "doctor": "Dr. Shahjabin sharna",
      "medicines": "Cetirizine (at night), Nasal Spray (2x daily)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Prescriptions"),
        centerTitle: true,
        // backgroundColor: ,
        foregroundColor: Colors.blue,
//ai khane back button default vabe thake ata jehetu root page na
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          final item = prescriptions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date & Doctor
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date: ${item["date"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      item["doctor"] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Medicines
                Text(
                  item["medicines"] ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 15),

                // Download button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
          );
        },
      ),
    );
  }
}
