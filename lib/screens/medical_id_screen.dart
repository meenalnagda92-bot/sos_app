import 'package:flutter/material.dart';

class MedicalIdScreen extends StatelessWidget {
  const MedicalIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Medical ID', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWarningBanner(),
            const SizedBox(height: 24),
            _buildInfoCard(
              'PERSONAL DETAILS',
              [
                _buildInfoRow('Blood Type', 'O Positive', Icons.bloodtype, Colors.red),
                _buildInfoRow('Date of Birth', 'May 12, 1990', Icons.calendar_today, Colors.blue),
                _buildInfoRow('Weight', '75 kg', Icons.monitor_weight_outlined, Colors.orange),
                _buildInfoRow('Height', '180 cm', Icons.height, Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              'MEDICAL CONDITIONS',
              [
                _buildTagSection(['Asthma', 'Mild Hypertension']),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              'ALLERGIES & REACTIONS',
              [
                _buildTagSection(['Peanuts', 'Penicillin', 'Dust']),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              'MEDICATIONS',
              [
                _buildInfoRow('Albuterol Inhaler', 'As needed', Icons.medication, Colors.purple),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('EDIT MEDICAL ID'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade800),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'This information will be available to emergency responders even when your phone is locked.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildTagSection(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(tag, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      )).toList(),
    );
  }
}
