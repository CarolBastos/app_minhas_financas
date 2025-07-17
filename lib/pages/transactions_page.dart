import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String name;
  final double amount;
  final DateTime dueDate;
  final int period; // 5 ou 16
  final String type; // 'Despesa' ou 'Receita'

  Transaction({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.period,
    required this.type,
  });
}

class TransactionsPage extends StatefulWidget {
  final void Function(Transaction) onAdd;
  const TransactionsPage({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  double _amount = 0.0;
  DateTime _dueDate = DateTime.now();
  int _period = 5;
  String _type = 'Despesa';

  void _addTransaction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final transaction = Transaction(
        name: _name,
        amount: _amount,
        dueDate: _dueDate,
        period: _period,
        type: _type,
      );
      widget.onAdd(transaction);
      _formKey.currentState!.reset();
      setState(() {
        _type = 'Despesa';
        _period = 5;
        _dueDate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Lançamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'Despesa', child: Text('Despesa')),
                  DropdownMenuItem(value: 'Receita', child: Text('Receita')),
                ],
                onChanged: (value) => setState(() => _type = value!),
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe o valor' : null,
                onSaved: (value) => _amount = double.parse(value!),
              ),
              InputDatePickerFormField(
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: _dueDate,
                fieldLabelText: 'Data de Vencimento',
                onDateSaved: (date) => _dueDate = date,
              ),
              DropdownButtonFormField<int>(
                value: _period,
                items: const [
                  DropdownMenuItem(value: 5, child: Text('Período 5')),
                  DropdownMenuItem(value: 16, child: Text('Período 16')),
                ],
                onChanged: (value) => setState(() => _period = value!),
                decoration: const InputDecoration(labelText: 'Período'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addTransaction,
                child: const Text('Adicionar Lançamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
