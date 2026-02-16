// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'day_chip_widget.dart';

// class WeatherHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final int selectedDay;
//   final ValueChanged<int> onDayChanged;

//   WeatherHeaderDelegate({
//     required this.selectedDay,
//     required this.onDayChanged,
//   });

//   @override
//   double get maxExtent => 400;

//   @override
//   double get minExtent => 200;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

//     final tempFontSize = lerpDouble(90, 30, progress)!;
//     final topSpacing = lerpDouble(30, 12, progress)!;

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromARGB(133, 100, 66, 234),
//             Color.fromARGB(153, 192, 64, 238),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: topSpacing),

//           Row(
//             children: const [
//               Text(
//                 "Kharkiv, Ukraine",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Spacer(),
//               Icon(Icons.search, color: Colors.white),
//             ],
//           ),

//           const SizedBox(height: 8),

//           Row(
//             children: [
//               Text(
//                 "3°",
//                 style: TextStyle(
//                   fontSize: tempFontSize,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 4),
//               const Text(
//                 "Feels like -2°",
//                 style: TextStyle(fontSize: 12, color: Colors.white),
//               ),
//               const Spacer(),
//               const Text(
//                 "Cloudy°",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),

//           Row(
//             children: [
//               DayChip(
//                 text: "Today",
//                 selected: selectedDay == 0,
//                 onTap: () => onDayChanged(0),
//               ),
//               const Spacer(),
//               DayChip(
//                 text: "Tomorrow",
//                 selected: selectedDay == 1,
//                 onTap: () => onDayChanged(1),
//               ),
//               const Spacer(),
//               DayChip(
//                 text: "10 Days",
//                 selected: selectedDay == 2,
//                 onTap: () => onDayChanged(2),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   bool shouldRebuild(covariant WeatherHeaderDelegate oldDelegate) {
//     return oldDelegate.selectedDay != selectedDay;
//   }
// }
