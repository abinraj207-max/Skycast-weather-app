import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String change;
  final bool down;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.change,
    this.down = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 190,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 155, 39, 176),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Row(
                children: [
                  Text(value),
                  const SizedBox(width: 6),
                  Icon(
                    down ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    size: 12,
                    color: down ? Colors.red : Colors.green,
                  ),
                  Text(change, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
