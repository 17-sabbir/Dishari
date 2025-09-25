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

  Future<void> _search() async {
    final id = _idController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter Prescription ID')));
      return;
    }

    setState(() {
      loading = true;
      _prescription = null;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (id.toLowerCase() != '123') {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Not found (dummy)')));
      return;
    }

    final meds = [
      Medicine(
        id: 'm1',
        name: 'Amoxicillin',
        dose: '500mg',
        prescribedQty: 14,
        stock: 120,
      ),
      Medicine(
        id: 'm2',
        name: 'Cetirizine',
        dose: '10mg',
        prescribedQty: 7,
        stock: 0,
        isOutOfStock: true,
      ),
      Medicine(
        id: 'm3',
        name: 'Paracetamol',
        dose: '650mg',
        prescribedQty: 10,
        stock: 48,
      ),
    ];

    setState(() {
      _prescription = Prescription(
        id: '123',
        patientName: 'Ariana Fields',
        patientId: '123',
        medicines: meds,
      );
      loading = false;
    });
  }

  void _onMedicineChanged(Medicine m) {
    setState(() {});
  }

  void _dispense() {
    if (_prescription == null) return;

    // Prepare dispensed items
    final items = _prescription!.medicines.map((m) {
      return {
        'medicineId': m.selectedAlternative?.id ?? m.id,
        'name': m.selectedAlternative?.name ?? m.name,
        'dose': m.selectedAlternative?.dose ?? m.dose,
        'quantity': m.dispenseQty,
        'wasAlternative': m.selectedAlternative != null,
      };
    }).toList();

    // Create log
    final log = DispenseLog(
      dispenserId: 'disp-001', // Replace with real dispenser ID if needed
      time: DateTime.now(),
      prescriptionId: _prescription!.id,
      items: items,
    );

    // Update stock and logs
    setState(() {
      logs.insert(0, log);
      for (var m in _prescription!.medicines) {
        m.stock = (m.stock - m.dispenseQty).clamp(0, double.infinity).toInt();
      }
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Dispensed (dummy)')));
  }

  Widget _buildPrescriptionView() {
    final p = _prescription!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.all(12),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(p.patientName),
            subtitle: Text('ID: ${p.patientId}'),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DispenserProfile())),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Medicines',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        ...p.medicines
            .map((m) => MedicineItem(medicine: m, onChanged: _onMedicineChanged)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            onPressed: _dispense,
            icon: const Icon(Icons.local_pharmacy),
            label: const Text('Dispense'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(48)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLogs() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      itemCount: logs.length,
      itemBuilder: (_, i) {
        final l = logs[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dispenser: ${l.dispenserId}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Time: ${l.time.hour}:${l.time.minute.toString().padLeft(2, '0')}'),
                Text('Prescription: ${l.prescriptionId}'),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: l.items.map((item) {
                    return Text(
                        '${item['name']} ${item['dose']} - Qty: ${item['quantity']}'
                            '${item['wasAlternative'] ? " (Alternative)" : ""}');
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dispenser',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DispenserProfile())),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: const InputDecoration(
                          hintText: 'Prescription ID',
                          border: InputBorder.none),
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
          height: 160, // Make bigger to fit all log info
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
