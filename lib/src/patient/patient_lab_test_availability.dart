import 'package:flutter/material.dart';

class PatientLabTestAvailability extends StatefulWidget {
  const PatientLabTestAvailability({super.key});

  @override
  State<PatientLabTestAvailability> createState() =>
      _PatientLabTestAvailabilityState();
}

class _PatientLabTestAvailabilityState
    extends State<PatientLabTestAvailability> {
  // Simulated lab tests database
  final List<Map<String, dynamic>> labTestsDB = List.generate(25, (index) {
    return {
      "name": "Lab Test ${index + 1}",
      "description": "Description for Lab Test ${index + 1}",
      "available": index % 4 != 0, // every 4th test unavailable
    };
  });

  // Simulated doctor suggestions (from prescriptions)
  final List<String> doctorSuggestedTests = [
    "Lab Test 1",
    "Lab Test 2",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Lab Test Availability"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: labTestsDB.length,
        itemBuilder: (context, index) {
          final test = labTestsDB[index];
          final bool doctorSuggested =
          doctorSuggestedTests.contains(test["name"]);
          final bool canBook = test["available"];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
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
                // Test Name & Availability
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          test["name"],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          test["description"],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    Text(
                      test["available"] ? "Available" : "Not Available",
                      style: TextStyle(
                        color: test["available"] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Doctor Suggestion Info
                Text(
                  doctorSuggested
                      ? "Doctor suggested this test"
                      : "Not suggested by doctor",
                  style: TextStyle(
                    color: doctorSuggested ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                // Book button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: canBook
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "${test["name"]} booked successfully!")),
                      );
                    }
                        : null, // disabled if cannot book
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      canBook ? Colors.blue.shade700 : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Book Test",
                      style: const TextStyle(color: Colors.white),
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
