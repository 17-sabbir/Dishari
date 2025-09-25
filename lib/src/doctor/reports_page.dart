import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  void removeReport(BuildContext context, String reportId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Report $reportId removed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reports",style: TextStyle(color: Colors.blueAccent),),
        automaticallyImplyLeading: false,
        centerTitle: true,),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
            title: const Text("Blood Test Report.pdf"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeReport(context, "BloodTest01"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.image, color: Colors.blue),
            title: const Text("X-Ray Report.jpg"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeReport(context, "XRay02"),
            ),
          ),
        ],
      ),
    );
  }
}
