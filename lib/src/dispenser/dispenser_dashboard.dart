import 'package:flutter/material.dart';
import 'dispenser_medicine_item.dart';
import 'dispenser_profile.dart';

class Prescription {
  final String id;
  final String patientName;
  final String patientId;
  final List<Medicine> medicines;

  Prescription({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.medicines,
  });
}

class DispenseLog {
  final String dispenserId;
  final DateTime time;
  final String prescriptionId;
  final List<Map<String, dynamic>> items;

  DispenseLog({
    required this.dispenserId,
    required this.time,
    required this.prescriptionId,
    required this.items,
  });
}

class DispenserDashboard extends StatefulWidget {
  const DispenserDashboard({super.key});

  @override
  State<DispenserDashboard> createState() => _DispenserDashboardState();
}

class _DispenserDashboardState extends State<DispenserDashboard> {
  final _idController = TextEditingController();
  Prescription? _prescription;
  bool loading = false;
  List<DispenseLog> logs = [];

  // =================================
  // DUMMY DATA & CORE LOGIC
  // =================================

  Future<void> _search() async {
    final id = _idController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter an ID')));
      return;
    }
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay

    if (id == 'P-45622') {
      _prescription = Prescription(
        id: id,
        patientName: 'Md Sabbir Ahamed',
        patientId: 'P2024001',
        medicines: [
          Medicine(
              id: 'm1',
              name: 'Paracetamol',
              dose: '500mg - 1+0+1',
              prescribedQty: 10,
              stock: 5, // Out of stock
              isOutOfStock: true),
          Medicine(
              id: 'm2',
              name: 'Cough Syrup',
              dose: '10ml at night',
              prescribedQty: 3,
              stock: 8),
          Medicine(
              id: 'm3',
              name: 'Antacid',
              dose: '1+1+1',
              prescribedQty: 20,
              stock: 15),
        ],
      );
    } else {
      _prescription = null;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prescription not found')));
    }

    setState(() => loading = false);
  }

  void _updateMedicine(Medicine updatedMed) {
    setState(() {
      if (_prescription != null) {
        final index = _prescription!.medicines
            .indexWhere((med) => med.id == updatedMed.id);
        if (index != -1) {
          _prescription!.medicines[index] = updatedMed;
        }
      }
    });
  }

  void _dispensePrescription() {
    if (_prescription == null) return;

    final dispensedItems = _prescription!.medicines
        .where((med) => med.dispenseQty > 0)
        .map((med) {
      return {
        'id': med.id,
        'name': med.name,
        'dispenseQty': med.dispenseQty,
        'alternative': med.selectedAlternative?.name ?? 'N/A',
      };
    }).toList();

    if (dispensedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No items selected for dispensing.')),
      );
      return;
    }

    final newLog = DispenseLog(
      dispenserId: 'D-101',
      time: DateTime.now(),
      prescriptionId: _prescription!.id,
      items: dispensedItems,
    );

    setState(() {
      logs.insert(0, newLog);
      _prescription = null; // Clear view after dispense
      _idController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Prescription ${_prescription!.id} dispensed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // =================================
  // UI BUILDERS
  // =================================

  Widget _buildPrescriptionView() {
    if (_prescription == null) return Container();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient Info
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prescription ID: ${_prescription!.id}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Patient: ${_prescription!.patientName} (${_prescription!.patientId})'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text('Items to Dispense',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // Medicine List
          ..._prescription!.medicines.map((med) {
            return MedicineItem(
              key: ValueKey(med.id),
              medicine: med,
              onChanged: _updateMedicine,
            );
          }).toList(),
          const SizedBox(height: 20),

          // Dispense Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _dispensePrescription,
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: const Text('Dispense Prescription',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogs() {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return ListTile(
          dense: true,
          title: Text(
            'ID: ${log.prescriptionId}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Time: ${log.time.hour}:${log.time.minute.toString().padLeft(2, '0')}\nItems: ${log.items.map((e) => e['name']).join(', ')}'),
          trailing: const Icon(Icons.medication_liquid, color: Colors.green),
        );
      },
    );
  }

  // =================================
  // WIDGET BUILD
  // =================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispenser Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DispenserProfile()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: const InputDecoration(
                          hintText: 'Prescription ID',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: loading ? null : _search,
                      child: loading
                          ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator())
                          : const Text('Search')),
                ],
              ),
            ),
          ),
          Expanded(
            child: _prescription == null
                ? Center(
              child: Text('Search a prescription to begin',
                  style: TextStyle(color: Colors.grey[600])),
            )
                : SingleChildScrollView(child: _buildPrescriptionView()),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 160,
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text('Dispensing logs',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Expanded(child: _buildLogs()),
            ],
          ),
        ),
      ),
    );
  }
}