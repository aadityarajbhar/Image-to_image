// // // import 'package:flutter/material.dart';
// // // import 'package:fl_chart/fl_chart.dart';

// // // class BookingRequestsScreen extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'Booking Requests',
// // //           style: TextStyle(
// // //             color: Colors.black,
// // //             fontSize: 20,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.language, color: Colors.black),
// // //             onPressed: () {},
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Income Summary Card
// // //             Card(
// // //               elevation: 0,
// // //               color: Colors.white,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(16),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     const Text(
// // //                       'INCOME SUMMARY',
// // //                       style: TextStyle(
// // //                         color: Colors.grey,
// // //                         fontSize: 12,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8),
// // //                     Row(
// // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                       children: [
// // //                         const Text(
// // //                           '₹ 5000',
// // //                           style: TextStyle(
// // //                             fontSize: 24,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                         Container(
// // //                           padding: const EdgeInsets.symmetric(
// // //                             horizontal: 8,
// // //                             vertical: 4,
// // //                           ),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.green.withOpacity(0.1),
// // //                             borderRadius: BorderRadius.circular(4),
// // //                           ),
// // //                           child: const Row(
// // //                             children: [
// // //                               Text(
// // //                                 '+36%',
// // //                                 style: TextStyle(
// // //                                   color: Colors.green,
// // //                                   fontSize: 12,
// // //                                 ),
// // //                               ),
// // //                               Icon(
// // //                                 Icons.arrow_upward,
// // //                                 color: Colors.green,
// // //                                 size: 12,
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),

// // // const SizedBox(height: 16),

// // // // Upcoming Service Section
// // // const Text(
// // //   'UPCOMING SERVICE',
// // //   style: TextStyle(
// // //     color: Colors.grey,
// // //     fontSize: 12,
// // //   ),
// // // ),
// // // const SizedBox(height: 8),
// // // Row(
// // //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //   children: [
// // //     const Text(
// // //       'Direct',
// // //       style: TextStyle(
// // //         fontSize: 16,
// // //         fontWeight: FontWeight.w500,
// // //       ),
// // //     ),
// // //     Text(
// // //       '200',
// // //       style: TextStyle(
// // //         fontSize: 16,
// // //         color: Colors.grey[600],
// // //       ),
// // //     ),
// // //   ],
// // // ),
// // // const SizedBox(height: 8),
// // // LinearProgressIndicator(
// // //   value: 0.7,
// // //   backgroundColor: Colors.blue.withOpacity(0.1),
// // //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
// // //   minHeight: 8,
// // //   borderRadius: BorderRadius.circular(4),
// // // ),

// // //             const SizedBox(height: 24),

// // //             // Sales Report Section
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 const Text(
// // //                   'Sales Report',
// // //                   style: TextStyle(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 TextButton.icon(
// // //                   onPressed: () {},
// // //                   icon: const Icon(Icons.download, size: 18),
// // //                   label: const Text('Export PDF'),
// // //                   style: TextButton.styleFrom(
// // //                     foregroundColor: Colors.blue,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             const SizedBox(height: 16),

// // //             // Time Period Selector
// // // SingleChildScrollView(
// // //   scrollDirection: Axis.horizontal,
// // //   child: Row(
// // //     children: [
// // //       _buildTimeButton('12 Months', true),
// // //       _buildTimeButton('6 Months', false),
// // //       _buildTimeButton('30 Days', false),
// // //       _buildTimeButton('7 Days', false),
// // //     ],
// // //   ),
// // // ),

// // //             const SizedBox(height: 24),

// // //             // Graph
// // //             SizedBox(
// // //               height: 200,
// // //               child: LineChart(
// // //                 LineChartData(
// // //                   gridData: FlGridData(show: false),
// // //                   titlesData: FlTitlesData(
// // //                     bottomTitles: AxisTitles(
// // //                       sideTitles: SideTitles(
// // //                         showTitles: true,
// // //                         getTitlesWidget: (value, meta) {
// // //                           const months = ['Apr', 'May', 'Jun', 'Jul'];
// // //                           if (value.toInt() < months.length) {
// // //                             return Text(months[value.toInt()]);
// // //                           }
// // //                           return const Text('');
// // //                         },
// // //                       ),
// // //                     ),
// // //                     leftTitles: AxisTitles(
// // //                       sideTitles: SideTitles(showTitles: false),
// // //                     ),
// // //                     topTitles: AxisTitles(
// // //                       sideTitles: SideTitles(showTitles: false),
// // //                     ),
// // //                     rightTitles: AxisTitles(
// // //                       sideTitles: SideTitles(showTitles: false),
// // //                     ),
// // //                   ),
// // //                   borderData: FlBorderData(show: false),
// // //                   lineBarsData: [
// // //                     LineChartBarData(
// // //                       spots: const [
// // //                         FlSpot(0, 1),
// // //                         FlSpot(1, 1.5),
// // //                         FlSpot(2, 1.4),
// // //                         FlSpot(3, 3.4),
// // //                       ],
// // //                       isCurved: true,
// // //                       color: Colors.blue,
// // //                       barWidth: 3,
// // //                       dotData: FlDotData(show: false),
// // //                       belowBarData: BarAreaData(
// // //                         show: true,
// // //                         color: Colors.blue.withOpacity(0.1),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // // Widget _buildTimeButton(String text, bool isSelected) {
// // //   return Container(
// // //     margin: const EdgeInsets.only(right: 8),
// // //     child: TextButton(
// // //       onPressed: () {},
// // //       style: TextButton.styleFrom(
// // //         backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
// // //         foregroundColor: isSelected ? Colors.white : Colors.grey[600],
// // //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //       ),
// // //       child: Text(text),
// // //     ),
// // //   );
// // // }
// // // }

// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class BookingRequestsScreen extends StatefulWidget {
// //   BookingRequestsScreen({super.key});

// //   @override
// //   State<BookingRequestsScreen> createState() => _BookingRequestsScreenState();
// // }

// // class _BookingRequestsScreenState extends State<BookingRequestsScreen> {
// //   int selectedIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Booking Request"),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             SizedBox(
// //               height: 21.h,
// //             ),
// //             Container(
// //               width: double.infinity,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10.r),
// //                 border: Border.all(color: Colors.black.withOpacity(0.5)),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Income Summary",
// //                       style: TextStyle(
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 11.h,
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           "₹ 5000 ",
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 21.sp,
// //                           ),
// //                         ),
// //                         Text(
// //                           "+ 36%",
// //                           style: TextStyle(
// //                             color: Colors.green,
// //                             fontSize: 16.sp,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 15.h,
// //             ),
// //             Container(
// //               width: double.infinity,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10.r),
// //                 border: Border.all(color: Colors.black.withOpacity(0.5)),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       'UPCOMING SERVICE',
// //                       style: TextStyle(
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         const Text(
// //                           'Direct',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         Text(
// //                           '200',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             color: Colors.grey[600],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     LinearProgressIndicator(
// //                       value: 0.7,
// //                       backgroundColor: Colors.blue.withOpacity(0.1),
// //                       valueColor:
// //                           const AlwaysStoppedAnimation<Color>(Colors.blue),
// //                       minHeight: 8,
// //                       borderRadius: BorderRadius.circular(4),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 15.h,
// //             ),
// //             Container(
// //               width: double.infinity,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10.r),
// //                 border: Border.all(color: Colors.black.withOpacity(0.5)),
// //               ),
// //               child: Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           "Sales Report",
// //                           style: TextStyle(
// //                             fontSize: 16.sp,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         FilledButton.icon(
// //                           style: FilledButton.styleFrom(
// //                             backgroundColor: Colors.transparent,
// //                             shape: RoundedRectangleBorder(
// //                               side: BorderSide(color: Colors.black),
// //                               borderRadius: BorderRadius.circular(5.r),
// //                             ),
// //                           ),
// //                           onPressed: () {},
// //                           label: Text(
// //                             "Export PDF",
// //                             style: TextStyle(
// //                               fontSize: 16.sp,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                           icon: Icon(
// //                             Icons.add_chart,
// //                             color: Colors.black,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(
// //                       height: 25.h,
// //                     ),
// //                     SingleChildScrollView(
// //                       scrollDirection: Axis.horizontal,
// //                       child: Row(
// //                         children: List.generate(
// //                           monthsList.length,
// //                           (index) {
// //                             return GestureDetector(
// //                               onTap: () {
// //                                 setState(() {
// //                                   selectedIndex = index;
// //                                 });
// //                               },
// //                               child: Container(
// //                                 margin: const EdgeInsets.only(right: 8),
// //                                 padding: const EdgeInsets.symmetric(
// //                                   horizontal: 16,
// //                                   vertical: 8,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   border: Border.all(
// //                                     color: selectedIndex == index
// //                                         ? Colors.black
// //                                         : Colors.transparent,
// //                                   ),
// //                                   borderRadius: BorderRadius.circular(5),
// //                                 ),
// //                                 child: Text(
// //                                   monthsList[index],
// //                                   style: TextStyle(
// //                                     fontWeight: selectedIndex == index
// //                                         ? FontWeight.bold
// //                                         : FontWeight.normal,
// //                                     color: selectedIndex == index
// //                                         ? Colors.black
// //                                         : Colors.grey[600],
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 15.h,
// //                     ),
// //                     SizedBox(
// //                       height: 200,
// //                       child: LineChart(
// //                         LineChartData(
// //                           gridData: FlGridData(show: false), // Hide grid lines
// //                           titlesData: FlTitlesData(
// //                             bottomTitles: AxisTitles(
// //                               sideTitles: SideTitles(
// //                                 showTitles: true,
// //                                 getTitlesWidget: (value, meta) {
// //                                   const months = ['Apr', 'May', 'Jun', 'Jul'];
// //                                   if (value.toInt() < months.length) {
// //                                     return Text(
// //                                       months[value.toInt()],
// //                                       style: const TextStyle(
// //                                         fontSize: 12,
// //                                         color: Colors.grey,
// //                                       ),
// //                                     );
// //                                   }
// //                                   return const Text('');
// //                                 },
// //                               ),
// //                             ),
// //                             leftTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: false),
// //                             ),
// //                             topTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: false),
// //                             ),
// //                             rightTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: false),
// //                             ),
// //                           ),
// //                           borderData: FlBorderData(show: false), // Hide border
// //                           lineBarsData: [
// //                             LineChartBarData(
// //                               spots: const [
// //                                 FlSpot(0, 1),
// //                                 FlSpot(1, 1.5),
// //                                 FlSpot(2, 1.4),
// //                                 FlSpot(3, 3.4),
// //                               ],
// //                               isCurved: true,
// //                               color: Colors.blue,
// //                               barWidth: 3,
// //                               isStrokeCapRound: true,
// //                               dotData: FlDotData(
// //                                 show: true,
// //                               ),
// //                               belowBarData: BarAreaData(
// //                                 show: true,
// //                                 color: Colors.blue.withOpacity(0.1),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   List<String> monthsList = [
// //     "12 Months",
// //     "6 Months",
// //     "30 Months",
// //     "7 Months",
// //   ];
// // }

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class BookingRequestsScreen extends StatefulWidget {
//   BookingRequestsScreen({super.key});

//   @override
//   State<BookingRequestsScreen> createState() => _BookingRequestsScreenState();
// }

// class _BookingRequestsScreenState extends State<BookingRequestsScreen> {
//   int selectedIndex = 0;
//   final ScreenshotController screenshotController = ScreenshotController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Request"),
//       ),
//       body: Screenshot(
//         controller: screenshotController,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 21.h),
//               _incomeSummaryCard(),
//               SizedBox(height: 15.h),
//               _upcomingServiceCard(),
//               SizedBox(height: 15.h),
//               _salesReportSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _incomeSummaryCard() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: Colors.black.withOpacity(0.5)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Income Summary",
//               style: TextStyle(color: Colors.black87),
//             ),
//             SizedBox(height: 11.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "₹ 5000 ",
//                   style: TextStyle(color: Colors.black, fontSize: 21.sp),
//                 ),
//                 Text(
//                   "+ 36%",
//                   style: TextStyle(color: Colors.green, fontSize: 16.sp),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _upcomingServiceCard() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: Colors.black.withOpacity(0.5)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('UPCOMING SERVICE',
//                 style: TextStyle(color: Colors.black87)),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Direct',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   '200',
//                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             LinearProgressIndicator(
//               value: 0.7,
//               backgroundColor: Colors.blue.withOpacity(0.1),
//               valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//               minHeight: 8,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _salesReportSection() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(color: Colors.black.withOpacity(0.5)),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Sales Report",
//                   style:
//                       TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//                 ),
//                 FilledButton.icon(
//                   style: FilledButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       side: const BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(5.r),
//                     ),
//                   ),
//                   onPressed: _captureAndExportPDF,
//                   label: Text(
//                     "Export PDF",
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   icon: const Icon(Icons.add_chart, color: Colors.black),
//                 ),
//               ],
//             ),
//             SizedBox(height: 25.h),
//             _timeFilterButtons(),
//             SizedBox(height: 15.h),
//             _lineChartWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _timeFilterButtons() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           monthsList.length,
//           (index) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 8),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: selectedIndex == index
//                         ? Colors.black
//                         : Colors.transparent,
//                   ),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   monthsList[index],
//                   style: TextStyle(
//                     fontWeight: selectedIndex == index
//                         ? FontWeight.bold
//                         : FontWeight.normal,
//                     color: selectedIndex == index
//                         ? Colors.black
//                         : Colors.grey[600],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _lineChartWidget() {
//     return SizedBox(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   const months = ['Apr', 'May', 'Jun', 'Jul'];
//                   if (value.toInt() < months.length) {
//                     return Text(
//                       months[value.toInt()],
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     );
//                   }
//                   return const Text('');
//                 },
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: const [
//                 FlSpot(0, 1),
//                 FlSpot(1, 1.5),
//                 FlSpot(2, 1.4),
//                 FlSpot(3, 3.4),
//               ],
//               isCurved: true,
//               color: Colors.blue,
//               barWidth: 3,
//               belowBarData: BarAreaData(
//                 show: true,
//                 color: Colors.blue.withOpacity(0.1),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _captureAndExportPDF() async {
//     try {
//       final directory = Directory("/storage/emulated/0/Download");
//       final capturedImage = await screenshotController.capture();
//       if (capturedImage == null) return;

//       final pdf = pw.Document();
//       final image = pw.MemoryImage(capturedImage);

//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) => pw.Center(
//             child: pw.Image(image),
//           ),
//         ),
//       );

//       final file = File('${directory.path}/BookingRequestsReport.pdf');
//       await file.writeAsBytes(await pdf.save());

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('PDF successfully exported!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to export PDF: $e')),
//       );
//     }
//   }

//   final List<String> monthsList = [
//     "12 Months",
//     "6 Months",
//     "30 Months",
//     "7 Months",
//   ];
// }
