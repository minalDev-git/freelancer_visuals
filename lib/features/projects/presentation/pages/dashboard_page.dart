import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/individual_bar.dart';

class DashboardPage extends StatefulWidget {
  final List<double> monthlySummary; // full historical list (could be >12)
  final int startMonth; // index of the first month (0 = Jan)
  const DashboardPage({
    super.key,
    required this.monthlySummary,
    required this.startMonth,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<IndividualBar> barData = [];

  /// Returns only the most recent 12 months
  List<double> get latest12Months {
    if (widget.monthlySummary.length <= 12) return widget.monthlySummary;
    return widget.monthlySummary.sublist(widget.monthlySummary.length - 12);
  }

  void initializeBarData() {
    barData = List.generate(
      latest12Months.length,
      (index) => IndividualBar(x: index, y: latest12Months[index]),
    );
  }

  double calculateMax() {
    final highest = latest12Months.reduce((a, b) => a > b ? a : b);
    final max = highest * 1.2;
    return max < 500 ? 500 : max;
  }

  @override
  Widget build(BuildContext context) {
    initializeBarData();

    double barWidth = 20;
    double spaceBetweenBars = 15;
    final maxY = calculateMax();

    // --- Financial calculations ---
    // Financial summary
    double totalEarnings = widget.monthlySummary.fold(0, (a, b) => a + b);
    double averageEarnings = totalEarnings / widget.monthlySummary.length;
    double highestEarning = widget.monthlySummary.reduce(
      (a, b) => a > b ? a : b,
    );
    int bestMonthIndex = widget.monthlySummary.indexOf(highestEarning);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Earnings Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // --- Bar Chart ---
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width:
                    barWidth * barData.length +
                    spaceBetweenBars * (barData.length - 1),
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: maxY,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomTiles,
                          reservedSize: 24,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          getTitlesWidget: getLeftTiles,
                        ),
                      ),
                    ),
                    barGroups: barData
                        .map(
                          (data) => BarChartGroupData(
                            x: data.x,
                            barRods: [
                              BarChartRodData(
                                toY: data.y,
                                width: barWidth,
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.indigoAccent.shade400,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: maxY,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    alignment: BarChartAlignment.center,
                    groupsSpace: spaceBetweenBars,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- Financial Summary Section ---
              const Text(
                "Financial Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryTile(
                      icon: Icons.account_balance_wallet_rounded,
                      label: "Total",
                      value: "₨${totalEarnings.toStringAsFixed(0)}",
                      color: Colors.indigoAccent,
                    ),
                    _buildSummaryTile(
                      icon: Icons.trending_up_rounded,
                      label: "Average",
                      value: "₨${averageEarnings.toStringAsFixed(0)}",
                      color: Colors.teal,
                    ),
                    _buildSummaryTile(
                      icon: Icons.star_rounded,
                      label: "Best Month",
                      value: getMonthName(bestMonthIndex),
                      color: Colors.amber.shade800,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getMonthName(int index) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[index % 12];
  }

  Widget _buildSummaryTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color.withValues(),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  final textStyle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt() % 12) {
    case 0:
      text = 'J';
      break;
    case 1:
      text = 'F';
      break;
    case 2:
      text = 'M';
      break;
    case 3:
      text = 'A';
      break;
    case 4:
      text = 'M';
      break;
    case 5:
      text = 'J';
      break;
    case 6:
      text = 'J';
      break;
    case 7:
      text = 'A';
      break;
    case 8:
      text = 'S';
      break;
    case 9:
      text = 'O';
      break;
    case 10:
      text = 'N';
      break;
    case 11:
      text = 'D';
      break;
    default:
      text = '';
  }
  return SideTitleWidget(
    meta: meta,
    child: Text(text, style: textStyle),
  );
}

Widget getLeftTiles(double value, TitleMeta meta) {
  final textStyle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text = '\$0';
  if (value % 200 != 0) {
    text = '\$ ${value.toInt()}';
  }
  return SideTitleWidget(
    meta: meta,
    child: Text(text, style: textStyle),
  );
}
