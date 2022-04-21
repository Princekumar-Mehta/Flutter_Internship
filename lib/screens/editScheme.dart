import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_scheme.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/scheme.dart';

class EditScheme extends StatefulWidget {
  Scheme scheme;
  EditScheme({required this.scheme});

  @override
  _EditSchemeState createState() => _EditSchemeState();
}

class _EditSchemeState extends State<EditScheme> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    //DatabaseHelper.instance.Temp_Query();
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
        title: Text("Edit Scheme Details",
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
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                              MyScreen.getScreenWidth(context) * (30 / 640)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Item Code : ${widget.scheme.item_Code}",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenWidth(context) * (10 / 640)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Percentage Discount *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'discount',
                            initialValue:
                                (double.parse(widget.scheme.discount) * 100)
                                    .toString(),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.pewterBlue
                                          : MyColors.black)),
                            ),
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Discount Percentage";
                              } else if (double.parse(value) <= 0 ||
                                  double.parse(value) >= 100) {
                                return "Discount Percentage can't be 0 or 100";
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("From *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderDateTimePicker(
                          inputType: InputType.date,
                          initialDate: (DateTime.parse(widget.scheme.fromdate)),
                          format: DateFormat('dd-MM-yyyy'),
                          firstDate: DateTime.now(),
                          name: 'date',
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                            suffixIcon: Icon(Icons.calendar_today,
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                size: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6)),
                            fillColor: MyColors.grullo,
                          ),
                          initialValue: DateTime.now(),
                        ),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("To *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderDateTimePicker(
                          inputType: InputType.date,
                          initialDate: (DateTime.parse(widget.scheme.todate)),
                          format: DateFormat('dd-MM-yyyy'),
                          firstDate: DateTime.now(),
                          initialValue: DateTime.now(),
                          name: 'dateto',
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                            suffixIcon: Icon(Icons.calendar_today,
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                size: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6)),
                            fillColor: MyColors.grullo,
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Button
                      SizedBox(
                          height: MyScreen.getScreenHeight(context) *
                              (60 / 1063.6)),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            String fromdate = _formKey
                                .currentState!.value['date']
                                .toString()
                                .split(" ")[0];
                            String todate = _formKey
                                .currentState!.value['dateto']
                                .toString()
                                .split(" ")[0];
                            double percentage = double.parse(
                                    _formKey.currentState!.value['discount']) /
                                100;
                            Scheme newScheme = Scheme(
                              item_Code: widget.scheme.item_Code,
                              discount: percentage.toString(),
                              fromdate: fromdate,
                              todate: todate,
                            );
                            if (await Database_Scheme()
                                .updateScheme(widget.scheme, newScheme)) {
                              showMessage(context, "Scheme Updated");
                              return;
                            } else {
                              Utility.showMessage(context,
                                  "Scheme Already Exist For ${newScheme.item_Code}");
                              return;
                            }
                          }
                          Database_Scheme().getSchemes();
                        },
                        child: SizedBox(
                          width: MyScreen.getScreenWidth(context) * (85 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (60 / 1063.6),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Container(
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
                              ),
                              Center(
                                child: Text("Add Scheme",
                                    style: TextStyle(
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.richBlackFogra
                                            : MyColors.white,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (17 / 1063.6),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showMessage(BuildContext context, String message,
      {String title: "Alert"}) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
              Navigator.pop(context);
              Navigator.pop(context);
              if (await Database_Scheme().currentSchemes()) {
                print(Database_Scheme.current_schemes);
                Navigator.pushNamed(context, MyRoutes.MyViewSchemes);
              }
            },
          ),
        ],
      ),
    );
  }
}
