import 'package:flutter/material.dart';

class HelplineScreen extends StatelessWidget {
  const HelplineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> helplines = [
      {'name': 'Police', 'number': '100', 'desc': 'Emergency Police Assistance'},
      {'name': 'Ambulance', 'number': '102', 'desc': 'Emergency Medical Services'},
      {'name': 'Fire Brigade', 'number': '101', 'desc': 'Fire and Rescue Services'},
      {'name': 'Women Helpline', 'number': '1091', 'desc': 'Women Safety & Domestic Abuse'},
      {'name': 'Child Helpline', 'number': '1098', 'desc': 'Child Protection Services'},
      {'name': 'Disaster Management', 'number': '108', 'desc': 'Emergency Response Service'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Emergency Helplines', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: helplines.length,
        itemBuilder: (context, index) {
          final helpline = helplines[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.phone_in_talk_rounded, color: Colors.red.shade700),
              ),
              title: Text(
                helpline['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(helpline['desc']!),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    helpline['number']!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text('CALL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                ],
              ),
              onTap: () {
                // Call logic here
              },
            ),
          );
        },
      ),
    );
  }
}
