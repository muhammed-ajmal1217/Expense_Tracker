import 'package:expensetracker/controller/home_provider.dart';
import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditDialogue extends StatefulWidget {
  EditDialogue({
    super.key,
    required this.categoryIcons,
    required this.categoryNames,
    required this.expense,
  });
  ExpenseModel expense;
  final List<IconData> categoryIcons;
  final List<String> categoryNames;

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  final style = GoogleFonts.raleway();
  @override
  void initState() {
    final pro = Provider.of<ExpenseProvider>(context, listen: false);
    super.initState();
    pro.amountController =
        TextEditingController(text: widget.expense.amount.toString());
    pro.descriptionController =
        TextEditingController(text: widget.expense.description);
    pro.dateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(widget.expense.date!));
    pro.selectedCategory = widget.expense.category;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ExpenseProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Edit Expense',
              style: GoogleFonts.raleway(color: Color.fromARGB(255, 6, 43, 66)),
            ),
            actions: [
              TextFormField(
                style: GoogleFonts.montserrat(),
                controller: value.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  hintStyle: style,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: style,
                      controller: value.dateController,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        hintStyle: style,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        suffixIcon: InkWell(
                            onTap: () {
                              value.selectDate(context);
                            },
                            child: Icon(Icons.date_range)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                style: GoogleFonts.raleway(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Category',
                  hintStyle: style,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: value.selectedCategory,
                onChanged: (newValue) {
                  value.selectedCategory = newValue;
                },
                items: List.generate(widget.categoryIcons.length, (index) {
                  return DropdownMenuItem<String>(
                    value: widget.categoryNames[index],
                    child: Row(
                      children: [
                        Icon(widget.categoryIcons[index]),
                        SizedBox(width: 10),
                        Text(
                          widget.categoryNames[index],
                          style: style,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: value.descriptionController,
                style: style,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: style,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await value.updateExpense(widget.expense);
                      Navigator.of(context).pop();
                      value.loadData();
                    },
                    child: Text(
                      'Save',
                      style: style,
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: style,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
