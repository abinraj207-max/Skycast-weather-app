import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';
import 'package:flutter_application_4/home/theme/styles.dart';

class RainProgressRow extends StatelessWidget {
  final String time;
  final int percent;

  const RainProgressRow({super.key, required this.time, required this.percent});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.04,
          child: Text(time, style: AppTextStyles.smallcardTitle),
        ),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 15,

              backgroundColor: AppColors.chipUnselected,
              valueColor: const AlwaysStoppedAnimation(AppColors.chipSelected),
            ),
          ),
        ),

        SizedBox(width: size.width * 0.02),

        SizedBox(
          width: size.width * 0.1,
          child: Text(
            "$percent%",
            style: AppTextStyles.smallcardTitle,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
