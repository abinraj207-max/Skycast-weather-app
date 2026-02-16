import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';

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
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.04,
        width: size.width * 0.28,
        decoration: BoxDecoration(
          color: selected ? AppColors.chipSelected : AppColors.chipUnselected,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? AppColors.whiteText : AppColors.darkText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
