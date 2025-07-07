import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_item/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry cardMargin =
        Theme.of(context).cardTheme.margin ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext ctx, int index) {
        final Expense expense = expenses[index];

        return Dismissible(
          key: ValueKey<Expense>(expense),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).colorScheme.error.withAlpha(179),
            margin: EdgeInsets.symmetric(horizontal: cardMargin.horizontal),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (DismissDirection _) => onRemoveExpense(expense),
          child: ExpensesItem(expense),
        );
      },
    );
  }
}
