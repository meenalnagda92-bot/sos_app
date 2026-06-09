import 'package:flutter/material.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tips = [
      {
        'title': 'During a Fire',
        'icon': Icons.local_fire_department_rounded,
        'color': Colors.orange,
        'steps': [
          'Stay low to the ground to avoid smoke.',
          'Check doors for heat before opening.',
          'Use stairs, never the elevator.',
          'Once out, stay out.'
        ]
      },
      {
        'title': 'First Aid: Bleeding',
        'icon': Icons.medical_services_rounded,
        'color': Colors.red,
        'steps': [
          'Apply direct pressure with a clean cloth.',
          'Maintain pressure until bleeding stops.',
          'Do not remove the cloth if soaked; add more on top.',
          'Elevate the wound if possible.'
        ]
      },
      {
        'title': 'Earthquake Safety',
        'icon': Icons.terrain_rounded,
        'color': Colors.brown,
        'steps': [
          'Drop, Cover, and Hold On.',
          'Stay away from glass and heavy furniture.',
          'Do not run outside until shaking stops.',
          'If in bed, stay there and cover your head.'
        ]
      },
      {
        'title': 'Personal Safety',
        'icon': Icons.security_rounded,
        'color': Colors.blue,
        'steps': [
          'Be aware of your surroundings.',
          'Trust your instincts.',
          'Keep your phone charged and accessible.',
          'Share your live location with trusted friends.'
        ]
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Safety Tips & Guides', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (tip['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(tip['icon'], color: tip['color']),
                ),
                title: Text(tip['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(72, 0, 24, 20),
                    child: Column(
                      children: (tip['steps'] as List<String>).map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            Expanded(child: Text(step, style: const TextStyle(color: Colors.black87, height: 1.4))),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
