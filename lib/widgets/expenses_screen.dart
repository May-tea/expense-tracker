import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/data/initial_expenses.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_item/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = initialExpenses;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() => _registeredExpenses.add(expense));
  }

  void _removeExpense(Expense expense) {
    final int index = _registeredExpenses.indexOf(expense);
    setState(() => _registeredExpenses.removeAt(index));
    _showUndoSnackBar(expense, index);
  }

  void _showUndoSnackBar(Expense expense, int index) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(AppStrings.expenseDeletedMessage),
        action: SnackBarAction(
          label: AppStrings.undoDeletedExpenseLabel,
          onPressed: () => setState(() {
            _registeredExpenses.insert(index, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isWideScreen = width >= 500;

    final Widget expensesBody = _registeredExpenses.isEmpty
        ? const Center(child: Text(AppStrings.emptyListMessage))
        : ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarTitle),
        actions: <Widget>[
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isWideScreen
          ? Row(
              children: <Widget>[
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: expensesBody),
              ],
            )
          : Column(
              children: <Widget>[
                Chart(expenses: _registeredExpenses),
                Expanded(child: expensesBody),
              ],
            ),
    );
  }
}
