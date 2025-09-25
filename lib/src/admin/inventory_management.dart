import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class InventoryManagement extends StatefulWidget {
  const InventoryManagement({super.key});

  @override
  State<InventoryManagement> createState() => _InventoryManagementState();
}

class _InventoryManagementState extends State<InventoryManagement> {
  // Expanded list of medicines with stock and expiry date
  List<Map<String, dynamic>> medicines = [
    {
      "name": "Oxygen",
      "stock": 15,
      "unit": "Tanks",
      "expiry": DateTime(2026, 6, 30)
    },
    {
      "name": "Amoxicillin",
      "stock": 120,
      "unit": "Boxes",
      "expiry": DateTime(2025, 12, 31)
    },
    {
      "name": "Insulin",
      "stock": 12,
      "unit": "Vials",
      "expiry": DateTime(2025, 11, 15)
    },
    {
      "name": "Paracetamol",
      "stock": 430,
      "unit": "Tablets",
      "expiry": DateTime(2026, 1, 10)
    },
  ];

  // Controllers for input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  DateTime? expiryDate;

  // Function to pick expiry date
  Future<void> _pickExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: expiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => expiryDate = picked);
  }

  // Add new medicine dialog
  void _addMedicine() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Medicine"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Medicine Name"),
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: "Stock Quantity"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: "Unit (Box/Vial/Tank)"),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Expiry Date: "),
                  Text(expiryDate != null
                      ? DateFormat('yyyy-MM-dd').format(expiryDate!)
                      : "Not selected"),
                  IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickExpiryDate)
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    stockController.text.isNotEmpty &&
                    unitController.text.isNotEmpty &&
                    expiryDate != null) {
                  setState(() {
                    medicines.add({
                      "name": nameController.text,
                      "stock": int.parse(stockController.text),
                      "unit": unitController.text,
                      "expiry": expiryDate
                    });
                  });
                  nameController.clear();
                  stockController.clear();
                  unitController.clear();
                  expiryDate = null;
                  Navigator.pop(context);
                }
              },
              child: const Text("Add")),
        ],
      ),
    );
  }

  // View medicine details
  void _viewMedicine(Map<String, dynamic> medicine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(medicine['name']),
        content: Text(
            "Stock: ${medicine['stock']} ${medicine['unit']}\nExpiry: ${DateFormat('yyyy-MM-dd').format(medicine['expiry'])}"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedicine,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade200,
                  child: Text(
                    medicine['name'][0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  medicine['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  "Stock: ${medicine['stock']} ${medicine['unit']}\nExpiry: ${DateFormat('yyyy-MM-dd').format(medicine['expiry'])}",
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: ElevatedButton(
                  onPressed: () => _viewMedicine(medicine),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "View",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
