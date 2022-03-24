import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_customer_feedback.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

class ViewCustomerFeedbackScreen extends StatefulWidget {
  const ViewCustomerFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<ViewCustomerFeedbackScreen> createState() =>
      _ViewCustomerFeedbackScreenState();
}

class _ViewCustomerFeedbackScreenState
    extends State<ViewCustomerFeedbackScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.scarlet,
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("View Customer Feedback",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      drawer: MyDrawer(),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6),
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Average Rating is :" +
                      Database_Customer_Feedback.avgRating.toString(),
                  style: TextStyle(color: MyColors.pewterBlue)),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      Database_Customer_Feedback.customer_feedbacks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key) {
    return Column(children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: MyScreen.getScreenHeight(context) * (80 / 1063.6),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6),
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        Database_Customer_Feedback
                            .customer_feedbacks[key].branch_Code,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (20 / 1063.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        Database_Customer_Feedback.customer_feedbacks[key].date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (20 / 1063.6),
                        ),
                      ),
                      Text(
                        Database_Customer_Feedback
                            .customer_feedbacks[key].rating,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (20 / 1063.6),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Utility.showMessage(
                        context,
                        Database_Customer_Feedback
                            .customer_feedbacks[key].reason,
                        title: "Feedback",
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "View Feedback",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (15 / 1063.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
      ),
    ]);
  }
}
