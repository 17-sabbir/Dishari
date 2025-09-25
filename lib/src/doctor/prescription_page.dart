import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _complainController = TextEditingController();
  final TextEditingController _examinationController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();
  final TextEditingController _medicineController = TextEditingController();

  String? patientName;

  void checkPatient() {
    String input = _patientIdController.text.trim();
    if (input == "12345") {
      setState(() {
        patientName = "Existing Patient: Ali Hossain";
      });
    } else {
      setState(() {
        patientName = "New Patient Created";
      });
    }
  }

  void savePrescription() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Prescription Saved & Sent")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prescription",style: TextStyle(color: Colors.blueAccent),),
        automaticallyImplyLeading: false,
        centerTitle: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _patientIdController,
              decoration: InputDecoration(
                labelText: "Patient ID / Phone",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: checkPatient,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            if (patientName != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(patientName!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 15),

            const Text("C/C:", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _complainController),

            const SizedBox(height: 10),
            const Text("O/E:", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _examinationController),

            const SizedBox(height: 10),
            const Text("Adv:", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _adviceController),

            const SizedBox(height: 10),
            const Text("Medicines:", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _medicineController),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: savePrescription,
                  icon: const Icon(Icons.save),
                  label: const Text("Save & Send"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Print logic
                  },
                  icon: const Icon(Icons.print),
                  label: const Text("Print"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
