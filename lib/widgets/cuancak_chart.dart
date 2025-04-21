import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CuancakChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const CuancakChart({
    super.key,
    required this.dataPoints,
  }); 

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            spots: const [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(2, 2),
              FlSpot(3, 5),
              FlSpot(4, 3.1),
              FlSpot(5, 4),
              FlSpot(6, 3),  
            ],
          ),
        ],
      ),
    );
  }
}
