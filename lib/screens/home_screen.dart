import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import 'add_transaction_screen.dart';
import 'package:intl/intl.dart';
import 'chart_screen.dart';
import 'goal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> transactions = [];

  double hitungSaldoTotal(
    List<Map<String, dynamic>> transactions,
    double saldoAwal,
  ) {
    double total = saldoAwal;
    for (var tx in transactions) {
      if (tx['isIncome']) {
        total += tx['amount'];
      } else {
        total -= tx['amount'];
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CuancakStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.savings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GoalScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saldo Total",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: CuancakColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A86FF), Color(0xFF4CC9F0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3A86FF).withOpacity(0.4),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rp ${NumberFormat('#,##0').format(hitungSaldoTotal(transactions, 5000000))}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text(
              CuancakStrings.keluarDuit + " & " + CuancakStrings.rejekiNomplok,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CuancakColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return ListTile(
                    leading: Icon(
                      tx['isIncome'] ? Icons.card_giftcard : Icons.fastfood,
                      color: CuancakColors.primaryBlue,
                    ),
                    title: Text(tx['description']),
                    subtitle: Text(tx['date']),
                    trailing: Text(
                      "${tx['isIncome'] ? '+' : '-'} Rp ${tx['amount']}",
                      style: TextStyle(
                        color: tx['isIncome'] ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ChartScreen(transactions: transactions),
                    ),
                  );
                },
                child: const Icon(
                  Icons.bar_chart,
                  size: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CuancakColors.primaryBlue,
                  foregroundColor: const Color.fromARGB(255, 252, 252, 252),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
          if (result != null) {
            setState(() {
              transactions.add({
                'description': result['description'],
                'amount': result['amount'],
                'isIncome': result['isIncome'],
                'date': DateTime.now().toLocal().toString().split(' ')[0],
              });
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
