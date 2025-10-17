// import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/services.dart' show rootBundle;

class PatientPrescriptions extends StatefulWidget {
  const PatientPrescriptions({super.key});

  @override
  State<PatientPrescriptions> createState() => _PatientPrescriptionsPageState();
}

class _PatientPrescriptionsPageState extends State<PatientPrescriptions> {
  late bool _fontLoaded = true; // Keep it true since PDF is disabled

  // Example prescriptions (later replace with data from DB)
  final List<Map<String, String>> prescriptions = [
    {
      "date": "2025-09-01",
      "doctor": "Dr. Wakil Ahmed",
      "medicines":
      "Rx:\n1. Paracetamol 500mg - 1+0+1 (After meal) for 5 days\n2. Cough Syrup - 10ml at night for 3 days"
    },
    {
      "date": "2025-08-20",
      "doctor": "Mr. Muhammad Jahidur Rahman",
      "medicines":
      "Rx:\n1. Amoxicillin 250mg - 1+1+1 (After meal) for 7 days\n2. Vitamin C 500mg - 1x daily for 10 days"
    },
    {
      "date": "2025-08-05",
      "doctor": "Dr. Salma Akter",
      "medicines":
      "Rx:\n1. Cetirizine - 0+0+1 (at night) for 3 days\n2. Nasal Spray - 2 puffs in each nostril, 2x daily"
    },
  ];

  @override
  void initState() {
    super.initState();
    // _loadFont(); // PDF font loading not needed now
  }

  // Commenting out PDF functions
  /*
  Future<void> _loadFont() async { ... }
  Future<void> _generateAndDownloadPDF(Map<String, String> prescription) async { ... }
  Future<void> _downloadPDFMobile(Uint8List bytes, Map<String, String> prescription) async { ... }
  void _downloadPDFWeb(Uint8List bytes, Map<String, String> prescription) { ... }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Prescriptions"),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
      ),
      body: prescriptions.isEmpty || !_fontLoaded
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Loading resources...",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
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

                // Download button (disabled)
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed:(){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("PDF download is not implemented"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Disabled color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.download,
                        color: Colors.white, size: 18),
                    label: const Text(
                      "Download PDF",
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
