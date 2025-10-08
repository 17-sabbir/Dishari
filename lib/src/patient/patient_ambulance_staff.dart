import 'package:flutter/material.dart';

// ✅ Staff & Ambulance Page
class PatientAmbulanceStaff extends StatefulWidget {
  const PatientAmbulanceStaff({super.key});

  @override
  State<PatientAmbulanceStaff> createState() => _PatientAmbulanceStaffState();
}

class _PatientAmbulanceStaffState extends State<PatientAmbulanceStaff> {
  final Color kPrimaryColor = const Color(0xFF00796B); // Deep Teal

  // SRS Compliance: Simulated database for ambulance and staff info
  final String ambulanceContact1 = "+৮৮-০১৩৩৩১৯৯০৮৫ || +88-01333199085";
  final String ambulanceContact2 = "+৮৮-০১৭৭৬৫০৩৪৬৯ || +88-01776503469";

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
      "name": "Mr. Jahidur Rahman",
      "designation": "Chief Lab Technician",
      "contact": "+88-01755667788"
    },
    {
      "name": "Ms. Samira Khan",
      "designation": "Chief Dispenser",
      "contact": "+88-01812345678"
    },
  ];

  // SRS Compliance: Staff Rating Dialog
  void _showRateStaffDialog(String staffName, String staffRole) {
    showDialog(
      context: context,
      builder: (context) => RateStaffDialog(
        staffName: staffName,
        staffRole: staffRole,
        kPrimaryColor: kPrimaryColor,
      ),
    );
  }

  // Utility widget for Contact Info
  Widget _buildContactTile(IconData icon, String title, String subtitle, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        trailing: Icon(Icons.call, color: color),
        onTap: () {
          // Dummy Call Action
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Calling $title... (Dummy Action)")));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Ambulance & Staff Contact", style: TextStyle(color: Colors.blueAccent)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 1. Ambulance Contact Section
            Text(
              "🚨 Emergency Ambulance Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            const Divider(thickness: 2, color: Colors.red),

            _buildContactTile(
                Icons.local_hospital_outlined,
                "Ambulance Line 1",
                ambulanceContact1,
                Colors.red.shade700
            ),
            _buildContactTile(
                Icons.local_hospital_outlined,
                "Ambulance Line 2 (Backup)",
                ambulanceContact2,
                Colors.red.shade700
            ),

            const SizedBox(height: 30),

            // 2. Key Medical Staff Contact Section
            Text(
              "👨‍⚕️ Medical Staff",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Divider(thickness: 2, color: Colors.blueGrey),

            // Staff List
            ...staffList.map((staff) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: kPrimaryColor.withOpacity(0.1),
                    child: const Icon(Icons.person, color: Colors.blueGrey),
                  ),
                  title: Text(staff["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${staff["designation"]!}\nContact: ${staff["contact"]!}", style: const TextStyle(fontSize: 13, height: 1.5)),
                  trailing: IconButton(
                    icon: Icon(Icons.star_half_outlined, color: Colors.amber.shade700),
                    onPressed: () => _showRateStaffDialog(staff["name"]!, staff["designation"]!),
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // Dummy Call Action
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Calling ${staff["name"]}... (Dummy Action)")));
                  },
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Separate Widget for Rating Dialog (Improved UI)
class RateStaffDialog extends StatefulWidget {
  final String staffName;
  final String staffRole;
  final Color kPrimaryColor;

  const RateStaffDialog({
    super.key,
    required this.staffName,
    required this.staffRole,
    required this.kPrimaryColor,
  });

  @override
  State<RateStaffDialog> createState() => _RateStaffDialogState();
}

class _RateStaffDialogState extends State<RateStaffDialog> {
  double _rating = 3.0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text("Rate Staff Member", style: TextStyle(color: widget.kPrimaryColor, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("How would you rate ${widget.staffName} (${widget.staffRole})?"),
            const SizedBox(height: 20),

            // Star Rating (Visually improved)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star_rounded : Icons.star_border_rounded,
                    color: Colors.amber.shade700,
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
            Text("Rating: ${_rating.toStringAsFixed(1)} / 5.0", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            // Feedback Text Field
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                  labelText: "Feedback (optional)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: widget.kPrimaryColor, width: 2),
                  )
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // SRS Compliance: Save rating to database
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Thank you for your $_rating star rating for ${widget.staffName}!")),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.kPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 15)
                ),
                child: const Text("Submit Rating", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}