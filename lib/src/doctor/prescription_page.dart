import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  // Controllers for all fields
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _complainController = TextEditingController();
  final TextEditingController _examinationController = TextEditingController();
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();
  final TextEditingController _testsController = TextEditingController();

  // Nullable DateTime with fallback
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Map<String, dynamic> getPrescriptionData() {
    final date = selectedDate ?? DateTime.now();
    return {
      'university': 'Noakhali Science and Technology University',
      'roll': _rollController.text.trim(),
      'name': _nameController.text.trim(),
      'age': _ageController.text.trim(),
      'gender': _genderController.text.trim(),
      'date': date.toIso8601String(),
      'complaints': _complainController.text.trim(),
      'examination': _examinationController.text.trim(),
      'medicines': _medicineController.text.trim(),
      'advice': _adviceController.text.trim(),
      'tests': _testsController.text.trim(),
      'createdAt': DateTime.now().toIso8601String(),
      'doctorSignature': "Doctor's Signature",
    };
  }

  void savePrescription() {
    final prescriptionData = getPrescriptionData();
    print('Prescription Data for Database: $prescriptionData');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Prescription Saved Successfully")),
    );
  }

  void clearForm() {
    setState(() {
      _rollController.clear();
      _nameController.clear();
      _ageController.clear();
      _genderController.clear();
      _complainController.clear();
      _examinationController.clear();
      _medicineController.clear();
      _adviceController.clear();
      _testsController.clear();
      selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prescription",
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          // Clear Form Button
          IconButton(
            onPressed: clearForm,
            icon: const Icon(Icons.clear_all, color: Colors.red),
            tooltip: 'Clear Form',
          ),
          // Print & Save Button
          ElevatedButton.icon(
            onPressed: savePrescription,
            icon: const Icon(Icons.print, color: Colors.white),
            label: const Text(
              'Print & Save',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade500,
              elevation: 0, // flat button in appbar
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // Align logo & text vertically center
                children: [
                  // University Logo
                  Image.asset(
                    'assets/images/nstu_logo.jpg',
                    height: screenWidth * 0.08,
                    // smaller height to reduce vertical space
                    width: screenWidth * 0.08,
                    // maintain aspect ratio
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),

                  // a little space between logo & text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // align text left
                    mainAxisSize: MainAxisSize.min,

                    // only take needed space
                    children: const [
                      Text(
                        "মেডিকেল সেন্টার",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "নোয়াখালী বিজ্ঞান ও প্রযুক্তি বিশ্ববিদ্যালয়",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Noakhali Science and Technology University",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(
              color: Colors.grey.shade400,
              thickness: 1, // line thickness
            ),
            // Patient Info Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Row 1: Patient Name + Date
                  Row(
                    children: [
                      const Text(
                        'Patient Name:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.only(bottom: 4),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Date:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextField(
                              controller: TextEditingController(
                                text:
                                    "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
                              ),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.only(bottom: 4),
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Row 2: Roll + Age + Gender
                  Row(
                    children: [
                      const Text(
                        'Roll:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _rollController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.only(bottom: 4),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Age:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.only(bottom: 4),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Gender:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _genderController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.only(bottom: 4),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1, // line thickness
            ),
            const SizedBox(height: 8),

            //Medicine Form Fields
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Left Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("C/C:", style: TextStyle(fontSize: 16)),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Write here...",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: InputBorder.none,
                            ),
                          ),

                          const Text("O/E:", style: TextStyle(fontSize: 16)),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Write here...",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: InputBorder.none,
                            ),
                          ),

                          const Text("Adv:", style: TextStyle(fontSize: 16)),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Write here...",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: InputBorder.none,
                            ),
                          ),

                          const Text("Test:", style: TextStyle(fontSize: 16)),
                          TextField(
                            controller: _testsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Write here...",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Vertical Divider
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                      width: 20,
                    ),

                    // Right Column: Rx
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Rx:", style: TextStyle(fontSize: 16)),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Write Medicine here...",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Optional small signature input
                  SizedBox(
                    width: 120, // slightly larger for better input
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Signature",
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: InputBorder.none, // optional: gives a small box
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Signature line
                  Container(
                    width: 130, // main signature line
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 5),

                  // Label
                  const Text(
                    "Doctor's Signature",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
