import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' as html;

class PatientPrescriptions extends StatefulWidget {
  const PatientPrescriptions({super.key});

  @override
  State<PatientPrescriptions> createState() => _PatientPrescriptionsPageState();
}

class _PatientPrescriptionsPageState extends State<PatientPrescriptions> {

  late pw.Font _banglaFont;
  bool _fontLoaded = false;

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
      "doctor": "Dr. Shahjabin Sharna",
      "medicines":
      "Rx:\n1. Cetirizine - 0+0+1 (at night) for 3 days\n2. Nasal Spray - 2 puffs in each nostril, 2x daily"
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFont();
  }

  Future<void> _loadFont() async {
    try {
      final fontData = await rootBundle.load("assets/fonts/SolaimanLipi.ttf");
      _banglaFont = pw.Font.ttf(fontData);
      if (mounted) {
        setState(() {
          _fontLoaded = true;
        });
      }
    } catch (e) {
      print("Error loading Bangla font: $e");
      if (mounted) {
        setState(() {
          _fontLoaded = false;
        });
      }
      // Consider showing an error to the user
    }
  }

  // Helper function for the left column fields in PDF
  pw.Widget _buildField(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: const pw.TextStyle(fontSize: 14)),
        pw.SizedBox(height: 2),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 10, bottom: 8),
          child: pw.Text(
            content,
            style: pw.TextStyle(fontSize: 12, lineSpacing: 1.2),
          ),
        ),
      ],
    );
  }

  // Function to generate and download PDF
  Future<void> _generateAndDownloadPDF(Map<String, String> prescription) async {
    if (!_fontLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Loading resources... Please try again in a moment.")),
      );
      return;
    }

    try {
      // NOTE: This SnackBar does NOT need a mounted check as it's the first line in the async block
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Downloading prescription PDF...")),
      );

      // Load NSTU logo from assets
      final logo = pw.MemoryImage(
        (await rootBundle.load('assets/images/nstu_logo.jpg'))
            .buffer
            .asUint8List(),
      );

      // Placeholder data
      const String patientName = 'John Doe';
      const String patientRoll = '001';
      const String patientAge = '35 years';
      const String patientGender = 'Male';
      const String complaint = 'Fever and cold for 3 days, Body ache.';
      const String examination = 'General condition stable. Mildly inflamed throat.';
      const String advice = 'Rest well and drink plenty of fluids.';
      const String tests = 'CBC, Urine R/M/E';

      // Extracting available data
      final String prescriptionDate = prescription["date"] ?? "";
      final String doctorName = prescription["doctor"] ?? "";
      final String medicines = prescription["medicines"] ?? "";

      // Create PDF document
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header (Medical Center/NSTU)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Image(logo, width: 45, height: 45), // Smaller logo
                    pw.SizedBox(width: 8),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'মেডিকেল সেন্টার',
                          // Use the loaded Bangla Font
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold, font: _banglaFont),
                        ),
                        pw.Text(
                          'নোয়াখালী বিজ্ঞান ও প্রযুক্তি বিশ্ববিদ্যালয়',
                          // Use the loaded Bangla Font
                          style: pw.TextStyle(fontSize: 12, font: _banglaFont),
                        ),
                        pw.Text(
                          'Noakhali Science and Technology University',
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.blueAccent,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Divider
                pw.Divider(color: PdfColors.grey400, thickness: 1),

                // Patient Info Section
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Row 1: Patient Name + Date
                      pw.Row(
                        children: [
                          pw.Text(
                            'Patient Name: ',
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(patientName,
                              style: const pw.TextStyle(fontSize: 12)),
                          pw.Spacer(),
                          pw.Text(
                            'Date: ',
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            prescriptionDate,
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                          pw.SizedBox(width: 20),
                        ],
                      ),
                      pw.SizedBox(height: 10),

                      // Row 2: Roll + Age + Gender
                      pw.Row(
                        children: [
                          pw.Text(
                            'Roll: ',
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(patientRoll,
                              style: const pw.TextStyle(fontSize: 12)),
                          pw.Spacer(flex: 2),
                          pw.Text(
                            'Age: ',
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(patientAge,
                              style: const pw.TextStyle(fontSize: 12)),
                          pw.Spacer(flex: 1),
                          pw.Text(
                            'Gender: ',
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(patientGender,
                              style: const pw.TextStyle(fontSize: 12)),
                          pw.Spacer(flex: 2),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider
                pw.Divider(color: PdfColors.black, thickness: 1),
                pw.SizedBox(height: 8),

                // Medicine Form Fields (Two Columns)
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                      children: [
                        // Left Column (C/C, O/E, Adv, Test)
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _buildField('C/C:', complaint),
                              _buildField('O/E:', examination),
                              _buildField('Adv:', advice),
                              _buildField('Test:', tests),
                            ],
                          ),
                        ),

                        // Vertical Divider
                        pw.Container(
                          width: 1,
                          color: PdfColors.black,
                          margin: const pw.EdgeInsets.symmetric(horizontal: 15),
                        ),

                        // Right Column: Rx (Medicines)
                        pw.Expanded(
                          flex: 4,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("Rx:",
                                  style: const pw.TextStyle(fontSize: 14)),
                              pw.SizedBox(height: 5),
                              // Display Medicines
                              pw.Text(
                                medicines,
                                style: pw.TextStyle(
                                    fontSize: 12, lineSpacing: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Final Signature/Footer
                pw.SizedBox(height: 15),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 150,
                        height: 1,
                        color: PdfColors.black,
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        doctorName,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue700,
                        ),
                      ),
                      pw.Text(
                        "Doctor's Signature",
                        style: pw.TextStyle(
                            fontSize: 10, fontStyle: pw.FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
              ],
            );
          },
        ),
      );

      // Get the PDF bytes
      final bytes = await pdf.save();

      if (kIsWeb) {
        _downloadPDFWeb(bytes, prescription);
        // The check for the catch block is handled below
      } else {
        await _downloadPDFMobile(bytes, prescription);
      }

      // FIX: Check mounted status before accessing context in catch block (if mobile fails)
      if (!mounted) return;

    } catch (e) {
      if (!mounted) return; // FIX
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading PDF: $e")),
      );
    }
  }

  // Download PDF for mobile platforms
  Future<void> _downloadPDFMobile(
      Uint8List bytes, Map<String, String> prescription) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'Prescription_${prescription["date"]?.replaceAll('-', '_')}.pdf';
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);

      if (!mounted) return; // FIX: Check mounted before SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PDF saved and opened successfully"),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return; // FIX: Check mounted before SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving PDF: $e")),
      );
    }
  }

  // Download PDF for web platform
  void _downloadPDFWeb(Uint8List bytes, Map<String, String> prescription) {
    try {
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final fileName =
          'Prescription_${prescription["date"]?.replaceAll('-', '_')}.pdf';

      // FIX: Use an underscore to mark 'anchor' as intentionally unused
      final _anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();

      html.Url.revokeObjectUrl(url);

      if (!mounted) return; // FIX: Check mounted before SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PDF download started"),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return; // FIX: Check mounted before SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading PDF: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Prescriptions"),
        centerTitle: true,
        foregroundColor: Colors.blue,
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
                  // The use of withOpacity is correct and not deprecated
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
                      _generateAndDownloadPDF(item);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
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