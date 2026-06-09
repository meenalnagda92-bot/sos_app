import 'package:flutter/material.dart';

class SafetyTimerScreen extends StatefulWidget {
  const SafetyTimerScreen({super.key});

  @override
  State<SafetyTimerScreen> createState() => _SafetyTimerScreenState();
}

class _SafetyTimerScreenState extends State<SafetyTimerScreen> {
  int _selectedMinutes = 30;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Safety Timer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildInfoCard(),
            const Spacer(),
            _buildTimerDisplay(),
            const Spacer(),
            if (!_isRunning) ...[
              const Text(
                'Adjust duration',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Slider(
                value: _selectedMinutes.toDouble(),
                min: 5,
                max: 120,
                divisions: 23,
                activeColor: Colors.purple,
                inactiveColor: Colors.purple.shade50,
                label: '$_selectedMinutes min',
                onChanged: (value) => setState(() => _selectedMinutes = value.toInt()),
              ),
            ],
            const SizedBox(height: 40),
            _buildActionButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.timer_outlined, color: Colors.purple.shade700, size: 32),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'If you don\'t check in before the timer expires, an SOS will be sent.',
              style: TextStyle(height: 1.4, color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 12,
            color: _isRunning ? Colors.purple : Colors.grey.shade100,
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          children: [
            Text(
              '$_selectedMinutes:00',
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
            const Text(
              'MINUTES',
              style: TextStyle(color: Colors.grey, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: () => setState(() => _isRunning = !_isRunning),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isRunning ? Colors.grey.shade200 : Colors.purple,
        foregroundColor: _isRunning ? Colors.black : Colors.white,
        minimumSize: const Size(double.infinity, 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        _isRunning ? 'STOP & CHECK-IN' : 'START SAFETY TIMER',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
