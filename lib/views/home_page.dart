import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expensetracker/controller/home_provider.dart';
import 'package:expensetracker/helpers/helpers.dart';
import 'package:expensetracker/views/utils/lists.dart';
import 'package:expensetracker/views/utils/utils.dart';
import 'package:expensetracker/views/widgets/add_dialogue.dart';
import 'package:expensetracker/views/widgets/category_list.dart';
import 'package:expensetracker/views/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(color: Color.fromARGB(255, 6, 18, 49)),
          child: Consumer<ExpenseProvider>(
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: size.height * 0.72,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.12,
                          ),
                          SizedBox(
                            height: size.height * 0.15,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CategoryList(
                                  categoryNames: CategoryItem.categoryNames,
                                  categoryIcons: CategoryItem.categoryIcons,
                                  size: size),
                            ),
                          ),
                          Expanded(
                            child: ExpenseList(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.62),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: size.height * 0.26,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.45),
                                  blurRadius: 10,
                                  offset: Offset(0, 6))
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: HelPers.cardLineGradient(),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(100)),
                                  color: Colors.blue.withOpacity(0.05),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 170,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(200)),
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 2),
                                    child: Container(
                                      height: 1.5,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: HelPers.cardGradient(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'E X P E N S E   C A R D',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.08,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(17.0),
                                      child: Text(
                                        '₹ ${AppUtils.calculateTotalAmount(value.expenses)}',
                                        style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AddDialogue(
                  categoryIcons: CategoryItem.categoryIcons,
                  categoryNames: CategoryItem.categoryNames);
            },
          );
        },
      ),
    );
  }
}
