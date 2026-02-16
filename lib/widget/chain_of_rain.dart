import 'package:flutter/material.dart';

class RainProgressRow extends StatelessWidget {
  final String time;
  final int percent;
  

  const RainProgressRow({super.key, required this.time, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(time, style: const TextStyle(fontSize: 12)),
        ),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 15,
              // ignore: deprecated_member_use
              backgroundColor: Colors.white.withOpacity(0.6),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF8E24AA), 
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 35,
          child: Text(
            "$percent%",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
