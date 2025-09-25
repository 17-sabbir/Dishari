import 'package:flutter/material.dart';

// ✅ Staff & Ambulance Page
class PatientAmbulanceStaff extends StatefulWidget {
  const PatientAmbulanceStaff({super.key});

  @override
  State<PatientAmbulanceStaff> createState() => _PatientAmbulanceStaffState();
}

class _PatientAmbulanceStaffState extends State<PatientAmbulanceStaff> {
  // Simulated database for ambulance and staff info
  final String ambulanceContact1 = "+৮৮-০১৩৩৩১৯৯০৮৫ ||+88-01333199085";
  final String ambulanceContact2 = "+৮৮-০১৭৭৬৫০৩৪৬৯ ||+88-01776503469";

  final List<Map<String, String>> staffList = [
    {
      "name": "Dr. Mohammed Mafizul Islam",
      "designation": "Chief Medical officer (Administrative Charge)",
      "contact": "+88-01734956003"
    },
    {
      "name": "Dr. Esmat Ara Parvin",
      "designation": "Deputy Chief Medical officer (Current Charge)",
      "contact": "+88-01764341056"
    },
    {
      "name": "Dr. Shahjabin sharna",
      "designation": "Medical officer (Residence)",
      "contact": "+88-01728776208"
    },
    {
      "name": "Dr. Md. Rubel Sarder (Abdullah)",
      "designation": "Medical officer (Study Leave)",
      "contact": "+88-01729552944"
    },
    {
      "name": "Dr. Wakil Ahmed",
      "designation": "Medical officer",
      "contact": "+88-01751032351"
    },
    {
      "name": "Dr. Most. Mousumi Akther",
      "designation": "Medical officer (Maternity Leave)",
      "contact": "+88-01751692556"
    },
    {
      "name": "Mrs. Nomita Rani Dey",
      "designation": "Nurse",
      "contact": "+88-01865538596"
    },
    {
      "name": "Mr. Muhammad Jahidur Rahman",
      "designation": "Medical assistant",
      "contact": "+88-001712327649"
    },
    {
      "name": "Mrs. Najnin Akter",
      "designation": "Medical attendant",
      "contact": "+88-01887512822"
    },
    {
      "name": "Mrs. Salma Akter",
      "designation": "Care taker",
      "contact": "N/A"
    },
    {
      "name": "Mrs. Razia Akter",
      "designation": "Computer operator",
      "contact": "N/A"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Ambulance & Staff Info"),
        centerTitle: true,
        foregroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ambulance contacts
            const Text(
              "Ambulance Contacts:",
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "1. $ambulanceContact1",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              "2. $ambulanceContact2",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            const Text(
              "Medical Staff Contacts:",
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Staff List with Rating Button
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final staff = staffList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff["name"] ?? "",
                        style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        staff["designation"] ?? "",
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Contact: ${staff["contact"]}",
                        style: const TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PatientRating(
                                  staffName: staff["name"]!,
                                  staffRole: staff["designation"]!,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.star, color: Colors.white),
                          label: const Text("Rate"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Rating Page
class PatientRating extends StatefulWidget {
  final String staffName;
  final String staffRole;

  const PatientRating({super.key, required this.staffName, required this.staffRole});

  @override
  State<PatientRating> createState() => _PatientRatingState();
}

class _PatientRatingState extends State<PatientRating> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rate ${widget.staffName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("How would you rate ${widget.staffName} (${widget.staffRole})?"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: "Feedback (optional)",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save rating to database (future implementation)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Thank you for your feedback!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Submit Rating"),
            ),
          ],
        ),
      ),
    );
  }
}
