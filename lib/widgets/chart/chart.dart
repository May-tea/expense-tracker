import 'package:expense_tracker/constants/category_icon.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets => <ExpenseBucket>[
    ExpenseBucket.forCategory(expenses, Category.food),
    ExpenseBucket.forCategory(expenses, Category.leisure),
    ExpenseBucket.forCategory(expenses, Category.travel),
    ExpenseBucket.forCategory(expenses, Category.work),
  ];

  double get maxTotalExpense => buckets.fold(
    0.0,
    (double max, ExpenseBucket bucket) =>
        bucket.totalExpenses > max ? bucket.totalExpenses : max,
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final List<ExpenseBucket> buckets = this.buckets;
    final double maxTotal = maxTotalExpense;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: <Color>[
            colorScheme.primary.withAlpha(77),
            colorScheme.primary.withAlpha(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                for (final ExpenseBucket bucket in buckets)
                  ChartBar(
                    fill: maxTotal == 0 ? 0 : bucket.totalExpenses / maxTotal,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map<Expanded>(
                  (ExpenseBucket bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? colorScheme.secondary
                            : colorScheme.primary.withAlpha(179),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
