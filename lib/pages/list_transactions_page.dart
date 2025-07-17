import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transactions_page.dart';

class ListTransactionsPage extends StatelessWidget {
  final List<Transaction> transactions;
  const ListTransactionsPage({Key? key, required this.transactions})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Todos'),
              Tab(text: 'Despesas'),
              Tab(text: 'Receitas'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildList(context, transactions, 'Todos'),
                _buildList(
                  context,
                  transactions.where((t) => t.type == 'Despesa').toList(),
                  'Despesas',
                ),
                _buildList(
                  context,
                  transactions.where((t) => t.type == 'Receita').toList(),
                  'Receitas',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Transaction> list,
    String label,
  ) {
    if (list.isEmpty) {
      return Center(child: Text('Nenhum lançamento encontrado.'));
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final t = list[index];
        return ListTile(
          title: Text('${t.type}: ${t.name}'),
          subtitle: Text(
            'Valor: R\$ ${t.amount.toStringAsFixed(2)} | Vencimento: ${DateFormat('dd/MM/yyyy').format(t.dueDate)} | Período: ${t.period}',
          ),
        );
      },
    );
  }
}
