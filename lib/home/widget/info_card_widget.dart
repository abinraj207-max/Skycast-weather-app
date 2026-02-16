import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';

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
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      width: 190,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.chipSelected,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: size.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Row(
                children: [
                  Text(value),
                  SizedBox(width: size.width * 0.02),
                  Icon(
                    down ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    size: 12,
                    color: down ? AppColors.infocardred : AppColors.infocardred,
                  ),
                  Text(change, style: AppTextStyles.smallcardTitle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
