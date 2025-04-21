import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../widgets/goal_card.dart';
import 'edit_goal_screen.dart';
import '../constants/colors.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key}) : super(key: key);

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  List<SavingGoal> goals = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();
  final TextEditingController savedAmountController = TextEditingController();

  void addGoal() {
    setState(() {
      goals.add(
        SavingGoal(
          id: DateTime.now().toString(),
          title: titleController.text,
          targetAmount: double.tryParse(targetAmountController.text) ?? 0,
          savedAmount: double.tryParse(savedAmountController.text) ?? 0,
          currentAmount: 0,
        ),
      );
    });
    titleController.clear();
    targetAmountController.clear();
    savedAmountController.clear();
  }

  void _editGoal(SavingGoal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditGoalScreen(
              goal: goal,
              onSave: (updatedGoal) {
                setState(() {
                  int index = goals.indexWhere((g) => g.id == goal.id);
                  if (index != -1) {
                    goals[index] = updatedGoal;
                  }
                });
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Target & Tabungan")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul Goal'),
                ),
                TextField(
                  controller: targetAmountController,
                  decoration: const InputDecoration(labelText: 'Jumlah Target'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: savedAmountController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Tersimpan',
                  ),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: addGoal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CuancakColors.accentYellow,
                    foregroundColor: CuancakColors.textDark,
                  ),
                  child: const Text('Tambah Goal'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _editGoal(goals[index]),
                  child: GoalCard(goal: goals[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
