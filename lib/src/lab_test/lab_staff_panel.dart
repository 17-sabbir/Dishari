import 'package:flutter/material.dart';

class LabStaffPanel extends StatefulWidget {
  const LabStaffPanel({super.key});

  @override
  State<LabStaffPanel> createState() => _LabStaffPanelState();
}

class _LabStaffPanelState extends State<LabStaffPanel> {
  final List<Map<String, dynamic>> bookedTests = [
    {"patient": "Rafi", "test": "Lab Test 1", "status": "Sample Pending"},
    {"patient": "Maya", "test": "Lab Test 2", "status": "In Progress"},
    {"patient": "Barsha", "test": "Lab Test 5", "status": "Completed"},
  ];

  void _updateStatus(int index, String newStatus) {
    setState(() => bookedTests[index]["status"] = newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
          "Status for ${bookedTests[index]['test']} updated to $newStatus")),
    );
  }

  void _uploadResult(int index) {
    setState(() => bookedTests[index]["status"] = "Result Uploaded");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
          "Result uploaded for ${bookedTests[index]['patient']}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab Staff - Manage Tests",style: TextStyle(color: Colors.blueAccent),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookedTests.length,
        itemBuilder: (context, index) {
          final test = bookedTests[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.science, color: Colors.blue),
              title: Text("${test["test"]}"),
              subtitle: Text("Patient: ${test["patient"]}\nStatus: ${test["status"]}"),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Sample Collected") {
                    _updateStatus(index, "In Progress");
                  } else if (value == "Complete Test") {
                    _updateStatus(index, "Completed");
                  } else if (value == "Upload Result") {
                    _uploadResult(index);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Sample Collected",
                    child: Text("Mark Sample Collected"),
                  ),
                  const PopupMenuItem(
                    value: "Complete Test",
                    child: Text("Mark Test Completed"),
                  ),
                  const PopupMenuItem(
                    value: "Upload Result",
                    child: Text("Upload Result"),
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
