import 'package:flutter/material.dart';

class StaffRostering extends StatefulWidget {
  const StaffRostering({super.key});

  @override
  State<StaffRostering> createState() => _StaffRosteringState();
}

class _StaffRosteringState extends State<StaffRostering> {
  // Dummy data: Weekly Roster
  final List<Map<String, String>> roster = [
    {"day": "Monday", "duty": "Dr. Patel - OPD AM\nLeo - Pharmacy"},
    {"day": "Tuesday", "duty": "Dr. Kim - ER\nSara - Lab"},
    {"day": "Wednesday", "duty": "Dr. Roy - OPD PM\nNina - Reception"},
    {"day": "Thursday", "duty": "Dr. Chen - Surgery\nArjun - Lab"},
    {"day": "Friday", "duty": "Dr. Ahmed - ER\nMaya - Pharmacy"},
  ];

  // Dummy Requests (Normally from DB)
  final List<Map<String, String>> requests = [
    {"name": "Dr. Kim", "reason": "Family Emergency", "day": "Tuesday"},
    {"name": "Sara", "reason": "Medical Leave", "day": "Tuesday"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Doctor & Staff Rostering",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Weekly Roster
            ...roster.map((r) =>
                Card(
                  child: ListTile(
                    title: Text(r["day"]!),
                    subtitle: Text(r["duty"]!),
                  ),
                )),

            const Divider(height: 30, thickness: 1),

            const Text(
              "Leave/Change Requests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Requests Section
            if (requests.isEmpty)
              const Text("No requests pending",
                  style: TextStyle(color: Colors.grey))
            else
              ...requests.map((req) =>
                  Card(
                    child: ListTile(
                      leading: const Icon(
                          Icons.request_page, color: Colors.orange),
                      title: Text("${req['name']} requested leave"),
                      subtitle: Text(
                          "Day: ${req['day']}\nReason: ${req['reason']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                                Icons.check_circle, color: Colors.green),
                            onPressed: () {
                              _handleRequest(req, true);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              _handleRequest(req, false);
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
          ],
        ),);}

  void _handleRequest(Map<String, String> req, bool approve) {
    setState(() {
      requests.remove(req);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "${req['name']} request for ${req['day']} has been ${approve
                ? 'approved'
                : 'rejected'}"),
        backgroundColor: approve ? Colors.green : Colors.red,
      ),
    );
  }
}
