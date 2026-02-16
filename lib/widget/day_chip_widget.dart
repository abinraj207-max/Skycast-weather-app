import 'package:flutter/material.dart';

class DayChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const DayChip({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          color: selected
              ? const Color.fromARGB(103, 155, 39, 176)
              : const Color.fromARGB(255, 252, 250, 250),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
