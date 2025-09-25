import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Sample history data
  final List<Map<String, String>> historyItems = const [
    {
      "timestamp": "2025-09-01 09:21",
      "user": "Dr. Amina Patel",
      "action": "updated prescription #45622"
    },
    {
      "timestamp": "2025-09-01 08:10",
      "user": "Leo Nguyen",
      "action": "adjusted stock for Insulin (-3)"
    },
    {
      "timestamp": "2025-08-31 14:35",
      "user": "Dr. Amina Patel",
      "action": "added new prescription #45621"
    },
    {
      "timestamp": "2025-08-31 11:50",
      "user": "Inventory Bot",
      "action": "stock update: Paracetamol (+100)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  item['user']![0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                DateFormat('yyyy-MM-dd HH:mm').format(
                    DateTime.parse(item['timestamp']!)), // formatted timestamp
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${item['user']} ${item['action']}"),
            ),
          );
        },
      ),
    );
  }
}
