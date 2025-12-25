import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../core/constants/app_colors.dart';
import 'attendance.dart';
import 'banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),

          BannerSlider(
            imageUrls: [
              "https://picsum.photos/id/1011/800/400",
              "https://picsum.photos/id/1015/800/400",
              "https://picsum.photos/id/1016/800/400",
            ],
          ),
          const SizedBox(height: 20),

          /// 🔥 Welcome Card
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     color: AppColors.primary,
          //     borderRadius: BorderRadius.circular(18),
          //   ),
          //   child: const Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Welcome 👋",
          //           style: TextStyle(color: Colors.white70)),
          //       SizedBox(height: 6),
          //       Text(
          //         "Aman Sharma",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 22,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),


          /// 🔥 Attendance Overview (IMAGE JAISE)
          const AttendanceOverviewExact(),


          const SizedBox(height: 20),

          /// 🔥 Quick Stats
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _statCard(Icons.calendar_month, "Attendance", "92%"),
              _statCard(Icons.payments, "Pending Fee", "₹ 3,500"),
              _statCard(Icons.menu_book, "Library Books", "4"),
              _statCard(Icons.notifications, "Notices", "2"),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔥 LEFT CARDS + RIGHT DONUT
  Widget _attendanceOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          /// LEFT SIDE CARDS
          Expanded(
            child: Column(
              children: [
                _smallCard(
                  title: "Attendance",
                  value: "73 / 76",
                  percent: "95%",
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                _smallCard(
                  title: "Assignment",
                  value: "73 / 76",
                  percent: "95%",
                  color: Colors.orange,
                ),
                const SizedBox(height: 12),
                _smallCard(
                  title: "Quiz",
                  value: "73 / 76",
                  percent: "95%",
                  color: Colors.purple,
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          /// RIGHT SIDE DONUT
          SizedBox(
            width: 140,
            height: 140,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 35,
                sections: [
                  PieChartSectionData(
                    value: 62.5,
                    color: Colors.green,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 15.4,
                    color: Colors.blue,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 9.4,
                    color: Colors.orange,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 12.5,
                    color: Colors.red,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 SMALL LEFT CARD
  Widget _smallCard({
    required String title,
    required String value,
    required String percent,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              percent,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const Spacer(),
          Text(title,
              style:
              const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
