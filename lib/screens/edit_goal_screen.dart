import 'package:flutter/material.dart';
import '../models/goal.dart';

class EditGoalScreen extends StatefulWidget {
  final SavingGoal goal;
  final Function(SavingGoal) onSave;

  EditGoalScreen({Key? key, required this.goal, required this.onSave})
    : super(key: key);

  @override
  _EditGoalScreenState createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  late TextEditingController titleController;
  late TextEditingController targetController;
  late TextEditingController savedController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.goal.title);
    targetController = TextEditingController(
      text: widget.goal.targetAmount.toString(),
    );
    savedController = TextEditingController(
      text: widget.goal.savedAmount.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Goal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Goal Title"),
            ),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Target Amount"),
            ),
            TextField(
              controller: savedController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Saved Amount"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  SavingGoal(
                    id: widget.goal.id,
                    title: titleController.text,
                    targetAmount: double.tryParse(targetController.text) ?? 0.0,
                    savedAmount: double.tryParse(savedController.text) ?? 0.0,
                    currentAmount: double.tryParse(savedController.text) ?? 0.0,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
