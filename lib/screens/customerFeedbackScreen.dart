import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_customer_feedback.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/Extras/utility.dart';

class CustomerFeedbackScreen extends StatefulWidget {
  const CustomerFeedbackScreen({Key? key}) : super(key: key);

  @override
  _CustomerFeedbackScreenState createState() => _CustomerFeedbackScreenState();
}

class _CustomerFeedbackScreenState extends State<CustomerFeedbackScreen> {
  late MyTypeAhead customerBranch;
  double _ratingValue = 0;
  var _feedback = TextEditingController(text: "");
  addCustomerFeedback(context) async {
    print(MyDrawer.emp.name);
    print(_ratingValue);
    print(_feedback.text);
    if (!Database_Customer_Feedback.remaining_branches
        .contains(customerBranch.getValue())) {
      Utility.showMessage(context, "Please select branch from options");
      return;
    }
    final df = DateFormat('dd-MM-yyyy');
    var date = (df.format(new DateTime.now()));
    bool isExist = await Database_Customer_Feedback().isCustomerFeedbackExist(
        MyDrawer.emp.id!,
        customerBranch.getValue().split(' ')[0],
        int.parse(date.split('-')[2]),
        int.parse(date.split('-')[1]));
    if (!isExist) {
      Database_Customer_Feedback.addCustomerFeedback(
          salesperson_Code: MyDrawer.emp.id,
          date: date,
          month: int.parse(date.split('-')[1]),
          year: int.parse(date.split('-')[2]),
          branch_Code: customerBranch.getValue().split(' ')[0],
          rating: _ratingValue.toString(),
          reason: _feedback.text);
      Utility.showMessage(context, "This month's feedback successfully added");
      await Future.delayed(Duration(seconds: 2), () {});
      Navigator.popUntil(
          context, ModalRoute.withName(MyRoutes.MySalespersonHome));
      return;
    } else {
      Utility.showMessage(context, "This month's feedback is already given");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    customerBranch = MyTypeAhead(
      itemList: Database_Customer_Feedback.remaining_branches,
      message: "Please Enter Customer ID",
      isEnabled: true,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.white
                  : MyColors.scarlet,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Customer Feedback Form",
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
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: MyScreen.getScreenHeight(context) * (25 / 553)),
              SizedBox(
                width: MyScreen.getScreenWidth(context) * (228 / 294),
                height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                child: Text("Customer *",
                    style: TextStyle(
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.pewterBlue
                            : MyColors.black,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (20 / 1063.6))),
              ),
              customerBranch,
              SizedBox(height: MyScreen.getScreenHeight(context) * (25 / 553)),
              RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      )),
                  onRatingUpdate: (value) {
                    setState(() {
                      _ratingValue = value;
                      print(_ratingValue);
                    });
                  }),
              SizedBox(height: MyScreen.getScreenHeight(context) * (25 / 553)),
              SizedBox(
                width: MyScreen.getScreenWidth(context) * (228 / 294),
                height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                child: Text("Reason ",
                    style: TextStyle(
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.pewterBlue
                            : MyColors.black,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (20 / 1063.6))),
              ),
              SizedBox(
                width: MyScreen.getScreenWidth(context) * (228 / 294),
                height: MyScreen.getScreenHeight(context) * (100 / 1063.6),
                child: FormBuilderTextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: _feedback,
                  name: 'feedback_desc',
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(
                        MyScreen.getScreenHeight(context) * (8 / 1063.6)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: MyDrawer.emp.darkTheme == 1
                          ? MyColors.pewterBlue
                          : MyColors.black,
                    )),
                  ),
                  style: TextStyle(
                      color: MyDrawer.emp.darkTheme == 1
                          ? MyColors.middleRed
                          : MyColors.scarlet,
                      fontSize:
                          MyScreen.getScreenHeight(context) * (25 / 1063.6)),
                  validator: (value) {},
                ),
              ),
              SizedBox(height: MyScreen.getScreenHeight(context) * (25 / 553)),
              SizedBox(
                width: MyScreen.getScreenWidth(context) * (85 / 294),
                height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
                child: InkWell(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (10 / 1063.6)),
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.middleRed
                              : MyColors.scarlet,
                        ),
                      ),
                      Center(
                        child: Text("Customer Feedback",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.richBlackFogra
                                    : MyColors.white,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (17 / 1063.6),
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  onTap: () => addCustomerFeedback(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
