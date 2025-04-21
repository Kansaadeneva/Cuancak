import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../constants/colors.dart';

class GoalCard extends StatelessWidget {
  final SavingGoal goal;
  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    double progress = goal.savedAmount / goal.targetAmount;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: CuancakColors.primaryBlue,
            ),
            const SizedBox(height: 8),
            Text("Terkumpul: Rp ${goal.savedAmount} / Rp ${goal.targetAmount}"),
          ],
        ),
      ),
    );
  }
}
