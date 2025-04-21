import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class ChartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> transactions;

  const ChartScreen({super.key, required this.transactions});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<FlSpot> getChartData() {
    List<FlSpot> dataPoints = [];
    double currentAmount = 5000000.0;

    for (int i = 0; i < widget.transactions.length; i++) {
      final tx = widget.transactions[i];
      if (tx['isIncome']) {
        currentAmount += tx['amount'];
      } else {
        currentAmount -= tx['amount'];
      }
      dataPoints.add(FlSpot(i.toDouble(), currentAmount));
    }

    return dataPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Keuangan'),
        backgroundColor: CuancakColors.primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          String formattedValue = NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp ',
                          ).format(value);

                          return Text(
                            formattedValue,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: getChartData(),
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
