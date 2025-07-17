import 'package:flutter/material.dart';
import 'pages/transactions_page.dart';
import 'pages/list_transactions_page.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatefulWidget {
  const FinanceApp({Key? key}) : super(key: key);

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {
  final List<Transaction> _transactions = [];

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lançamentos Financeiros',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/list',
      routes: {
        '/list': (context) => ListPage(
          transactions: _transactions,
          onAdd: (transaction) => _addTransaction(transaction),
        ),
        '/add': (context) => TransactionsPage(
          onAdd: (transaction) {
            _addTransaction(transaction);
            Navigator.of(context).pop();
          },
        ),
      },
    );
  }
}

class ListPage extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction) onAdd;
  const ListPage({Key? key, required this.transactions, required this.onAdd})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lançamentos Financeiros')),
      body: ListTransactionsPage(transactions: transactions),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add');
        },
        child: const Icon(Icons.add),
        tooltip: 'Adicionar Lançamento',
      ),
    );
  }
}
