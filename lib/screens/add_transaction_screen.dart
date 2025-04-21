import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catat Duit Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Keterangan Duit"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Nominal (Rp)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text(
                _isIncome
                    ? CuancakStrings.rejekiNomplok
                    : CuancakStrings.keluarDuit,
              ),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final desc = _descController.text.trim();
                final amount = int.tryParse(_amountController.text) ?? 0;
                final isIncome = _isIncome;

                if (desc.isEmpty || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Isi keterangan dan nominal dengan benar!"),
                    ),
                  );
                  return;
                }

                Navigator.pop(context, {
                  'description': desc,
                  'amount': amount,
                  'isIncome': isIncome,
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: CuancakColors.accentYellow,
                foregroundColor: CuancakColors.textDark,
              ),
              child: const Text("Simpan Catatan"),
            ),
          ],
        ),
      ),
    );
  }
}
