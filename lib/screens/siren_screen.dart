import 'package:flutter/material.dart';

class SirenScreen extends StatefulWidget {
  const SirenScreen({super.key});

  @override
  State<SirenScreen> createState() => _SirenScreenState();
}

class _SirenScreenState extends State<SirenScreen> with SingleTickerProviderStateMixin {
  bool _isActive = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSiren() {
    setState(() {
      _isActive = !_isActive;
      if (_isActive) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Emergency Siren', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: _isActive ? _colorAnimation.value?.withOpacity(0.5) : Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.campaign_rounded,
                  size: 120,
                  color: _isActive ? _colorAnimation.value : Colors.grey.shade800,
                ),
                const SizedBox(height: 40),
                Text(
                  _isActive ? 'SIREN ACTIVE' : 'SIREN OFF',
                  style: TextStyle(
                    color: _isActive ? Colors.white : Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: _toggleSiren,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isActive ? Colors.white : Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: (_isActive ? Colors.white : Colors.red).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _isActive ? 'STOP' : 'START',
                        style: TextStyle(
                          color: _isActive ? Colors.red : Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'This will play a loud alarm and flash your screen to attract attention.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
