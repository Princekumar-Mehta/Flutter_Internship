import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

enum ReasonSelected { self, family, vacation, leave, civil, other }

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  ReasonSelected? _reason = ReasonSelected.self;

  Future<void> showMessage(
    BuildContext context,
    String message,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
        ],
      ),
    );
  }

  applyLeave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String reasondesc = _formKey.currentState!.value['reason_desc'] == null
          ? "None"
          : _formKey.currentState!.value['reason_desc'].toString();
      String fromdate = _formKey.currentState!.value['date'].toString();
      String todate = _formKey.currentState!.value['dateto'].toString();
      print({_reason, reasondesc, fromdate, todate});
      var temp = _reason.toString().split('.');
      String reason = temp[1];
      int emp_id = MyDrawer.emp.id!;

      Database_leaveRequest.addRequest(
          reason: reason,
          reason_desc: reasondesc,
          fromdate: fromdate,
          todate: todate,
          emp_id: emp_id,
          status: "Pending");
      print(Database_leaveRequest().getAllRequest());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            shape: Border(
              bottom: BorderSide(
                color: MyColors.scarlet,
                width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
              ),
            ),
            title: Text("Leave Request Form",
                style: TextStyle(
                    color: MyColors.white,
                    fontSize:
                        MyScreen.getScreenHeight(context) * (20 / 1063.6))),
            centerTitle: true,
            backgroundColor: MyColors.richBlackFogra,
          ),
          drawer: MyDrawer(),
          backgroundColor: MyColors.richBlackFogra,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: Stack(children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                MyScreen.getScreenWidth(context) * (70 / 640)),
                        Padding(
                          padding: EdgeInsets.all(
                              MyScreen.getScreenWidth(context) * (15 / 490.9)),
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: MyColors.pewterBlue,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Reason",
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (22 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.pewterBlue,
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Sick - Self'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.self,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Sick - Family'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.family,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Vacation'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.vacation,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Leave of Absence'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.leave,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Civil/Jury Duty'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.civil,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Other'),
                                  textColor: MyColors.pewterBlue,
                                  leading: Radio<ReasonSelected>(
                                    value: ReasonSelected.other,
                                    groupValue: _reason,
                                    onChanged: (ReasonSelected? value) {
                                      setState(() {
                                        _reason = value;
                                        print(_reason);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text(
                              "Reason (Please specify if selected Other)",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height: MyScreen.getScreenHeight(context) *
                              (100 / 1063.6),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            name: 'reason_desc',
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                  MyScreen.getScreenHeight(context) *
                                      (8 / 1063.6)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                if (_reason == ReasonSelected.other) {
                                  return "Please enter a short description for selecting Other";
                                }
                                return null;
                              }
                            },
                          ),
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
                                  color: MyColors.pewterBlue,
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
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: MyColors.pewterBlue,
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
                                  color: MyColors.pewterBlue,
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
                            name: 'dateto',
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: MyColors.pewterBlue,
                                  size: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6)),
                              fillColor: MyColors.grullo,
                            ),
                            initialValue: DateTime.now(),
                          ),
                        ),
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
                                      color: MyColors.middleRed,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text("Apply for Leave",
                                      style: TextStyle(
                                          color: MyColors.richBlackFogra,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (17 / 1063.6),
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                            onTap: () => applyLeave(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
