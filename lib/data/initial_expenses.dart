import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/models/expense.dart';

final List<Expense> initialExpenses = <Expense>[
  Expense(
    title: AppStrings.sampleTitleFlutterCourse,
    amount: 19.99,
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: Category.work,
  ),
  Expense(
    title: AppStrings.sampleTitleCinema,
    amount: 15.69,
    date: DateTime.now().subtract(const Duration(days: 3)),
    category: Category.leisure,
  ),
  Expense(
    title: AppStrings.sampleTitlePizza,
    amount: 12.50,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: Category.food,
  ),
  Expense(
    title: AppStrings.sampleTitleBerlinFlight,
    amount: 200.00,
    date: DateTime.now().subtract(const Duration(days: 7)),
    category: Category.travel,
  ),
];
