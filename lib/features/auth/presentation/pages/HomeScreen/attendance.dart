import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:schooldemoapp/core/constants/app_colors.dart';

class AttendanceOverviewExact extends StatelessWidget {
  const AttendanceOverviewExact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// LEFT SIDE (3 CARDS)
          Column(
            children: const [
              _LeftCard(
                title: "Attendance",
                value: "73 / 76",
                percent: "95%",
                bg: Color(0xffE6FAF1),
                pill: Color(0xff2ECC71),
              ),
              SizedBox(height: 8),
              _LeftCard(
                title: "Assignment",
                value: "73 / 76",
                percent: "95%",
                bg: Color(0xffFFF3E3),
                pill: Color(0xffF5A623),
              ),
              SizedBox(height: 8),
              _LeftCard(
                title: "Quiz",
                value: "73 / 76",
                percent: "95%",
                bg: Color(0xffECEBFF),
                pill: Color(0xff6C63FF),
              ),
            ],
          ),

          const SizedBox(width: 10),

          /// RIGHT SIDE
          Expanded(
            child: Card(
              color:Color(0xffE6FAF1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Column(
                  children: [

                    /// TITLE (EXACT BREAK)
                    const Text(
                      "Attendance of Current\nAcademic Year",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// DONUT
                    SizedBox(
                      height: 130,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 2,
                              centerSpaceRadius: 35,
                              sections: [
                                _section(62.5, Color(0xff2ECC71)),
                                _section(15.4, Color(0xff6C63FF)),
                                _section(9.4, Color(0xffF5A623)),
                                _section(12.5, Color(0xffFF5C5C)),
                              ],
                            ),
                          ),
                          // const Column(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     Text(
                          //       "62.5%",
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     SizedBox(height: 2),
                          //     Text(
                          //       "Present",
                          //       style: TextStyle(
                          //         fontSize: 10,
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// LEGEND (EXACT ORDER)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _Legend(color: Color(0xff2ECC71), text: "Present (11)"),
                          _Legend(color: Color(0xffFF5C5C), text: "Late (2)"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _Legend(color: Color(0xffF5A623), text: "Illness (9)"),
                          _Legend(color: Color(0xff6C63FF), text: "Absent (3)"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static PieChartSectionData _section(double value, Color color) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: 35,
      showTitle: true,
      title: '$value%',
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white, fontSize: 10
      )
    );
  }
}

class _LeftCard extends StatelessWidget {
  final String title, value, percent;
  final Color bg, pill;

  const _LeftCard({
    required this.title,
    required this.value,
    required this.percent,
    required this.bg,
    required this.pill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: pill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  percent,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 10.5),
        ),
      ],
    );
  }
}
