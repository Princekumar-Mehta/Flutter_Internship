import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_scheme.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

class SetSchemeDetails extends StatefulWidget {
  final List<String> items;
  @override
  SetSchemeDetails({required this.items});

  @override
  _SetSchemeDetailsState createState() => _SetSchemeDetailsState();
}

class _SetSchemeDetailsState extends State<SetSchemeDetails> {
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
        title: Text("Set Scheme Details",
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
                              MyScreen.getScreenWidth(context) * (50 / 640)),
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
                              } else if (int.parse(value) == 0 ||
                                  int.parse(value) == 100) {
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
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (85 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6),
                        child: InkWell(
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
                              double percentage = double.parse(_formKey
                                      .currentState!.value['discount']) /
                                  100;
                              for (var i = 0; i < widget.items.length; i++) {
                                if (await Database_Scheme().isSchemeNotExist(
                                    widget.items[i].split(" - ")[0],
                                    fromdate,
                                    todate)) {
                                  Database_Scheme().addScheme(
                                      widget.items[i].split(" - ")[0],
                                      percentage.toString(),
                                      fromdate,
                                      todate);
                                } else {
                                  Utility.showMessage(context,
                                      "Scheme Already Exist For ${widget.items[i].split(" - ")[0]}");
                                  return;
                                }
                              }
                            }
                            Database_Scheme().getSchemes();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
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
}
