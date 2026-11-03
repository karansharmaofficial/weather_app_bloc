import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const Forecast({
    super.key,
    required this.temp,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10.0),

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(temp),
          ],
        ),
      ),
    );
  }
}
