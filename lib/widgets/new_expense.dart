import 'dart:io';

import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  final DateFormat _formatter = DateFormat.yMMMd();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showInvalidInputDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  void _showInvalidInputDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text(AppStrings.invalidInputTitle),
          content: const Text(AppStrings.invalidInputMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.okayButtonLabel),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) => CupertinoAlertDialog(
          title: const Text(AppStrings.invalidInputTitle),
          content: const Text(AppStrings.invalidInputMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.okayButtonLabel),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text(AppStrings.titleLabel)),
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: const InputDecoration(
        label: Text(AppStrings.amountLabel),
        prefixText: '\$',
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButton<Category>(
      value: _selectedCategory,
      items: Category.values.map<DropdownMenuItem<Category>>((
        Category category,
      ) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Text(category.name.toUpperCase()),
        );
      }).toList(),
      onChanged: (Category? value) {
        if (value == null) return;
        setState(() => _selectedCategory = value);
      },
    );
  }

  Widget _buildDatePickerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          _selectedDate == null
              ? AppStrings.noDateSelected
              : _formatter.format(_selectedDate!),
        ),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  Widget _buildButtonsRow(bool wide) {
    final TextButton cancelButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(AppStrings.cancelButtonLabel),
    );

    final ElevatedButton saveButton = ElevatedButton(
      onPressed: _submitExpenseData,
      child: const Text(AppStrings.saveExpenseButtonLabel),
    );

    if (wide) {
      return Row(children: <Widget>[const Spacer(), cancelButton, saveButton]);
    } else {
      return Row(
        children: <Widget>[
          Expanded(child: _buildCategoryDropdown()),
          const Spacer(),
          cancelButton,
          saveButton,
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                16.0,
                16.0,
                16.0 + keyboardSpace,
              ),
              child: Column(
                children: <Widget>[
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: _buildTitleField()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildAmountField()),
                      ],
                    )
                  else
                    _buildTitleField(),
                  const SizedBox(height: 8),
                  if (width >= 600)
                    Row(
                      children: <Widget>[
                        _buildCategoryDropdown(),
                        const SizedBox(width: 24),
                        Expanded(child: _buildDatePickerRow()),
                      ],
                    )
                  else
                    Row(
                      children: <Widget>[
                        Expanded(child: _buildAmountField()),
                        const SizedBox(width: 16),
                        Expanded(child: _buildDatePickerRow()),
                      ],
                    ),
                  const SizedBox(height: 16),
                  _buildButtonsRow(width >= 600),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
