import 'package:flutter/material.dart';
import 'package:sos_app/theme/app_theme.dart';

class SosLogo extends StatelessWidget {
  const SosLogo({super.key, this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.emergency,
            color: Colors.white,
            size: size * 0.55,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'SOS',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryDark,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}