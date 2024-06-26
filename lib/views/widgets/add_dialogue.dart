import 'package:expensetracker/controller/home_provider.dart';
import 'package:expensetracker/model/expense_model.dart';
import 'package:expensetracker/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDialogue extends StatelessWidget {
  AddDialogue({
    super.key,
    required this.categoryIcons,
    required this.categoryNames,
  });
  final List<IconData> categoryIcons;
  final List<String> categoryNames;
  final style = GoogleFonts.raleway();

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedCategory;
  final uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ExpenseProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Add Expense',
              style: GoogleFonts.raleway(color: Color.fromARGB(255, 6, 43, 66)),
            ),
            actions: [
              TextWidget(
                style: GoogleFonts.montserrat(),
                controller: amountController,
                hintText: 'Amount',
                type: TextInputType.number,
              ),
              SizedBox(height: 15),
              TextWidget(
                style: style,
                controller: dateController,
                hintText: 'Date',
                icon: Icons.date_range,
                onTap: () {
                  value.selctDate(context,dateController);
                },
                type: TextInputType.phone,
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
                value: selectedCategory,
                onChanged: (newValue) {
                  selectedCategory = newValue;
                },
                items: List.generate(categoryIcons.length, (index) {
                  return DropdownMenuItem<String>(
                    value: categoryNames[index],
                    child: Row(
                      children: [
                        Icon(categoryIcons[index]),
                        SizedBox(width: 10),
                        Text(
                          categoryNames[index],
                          style: style,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 15),
              TextWidget(
                style: style,
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await value.addExpenses(
                        ExpenseModel(
                          id: uuid.v4(),
                          amount: int.parse(amountController.text),
                          date: DateFormat('dd/MM/yyyy')
                              .parse(dateController.text),
                          category: selectedCategory!,
                          description: descriptionController.text,
                        ),
                      );
                      amountController.clear();
                      descriptionController.clear();
                      dateController.clear();
                      Navigator.of(context).pop();
                      value.loadData();
                    },
                    child: Text(
                      'Add',
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
