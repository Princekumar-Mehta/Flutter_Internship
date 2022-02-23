import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_SignUp.dart';
import 'package:project_v3/Database/employee.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/utility.dart';

import '../routes.dart';

class ForgotPasswordScreen2 extends StatefulWidget {
  final email;
  const ForgotPasswordScreen2({Key? key, this.email}) : super(key: key);
  @override
  _ForgotPasswordScreen2State createState() =>
      _ForgotPasswordScreen2State(email: email);
}

class _ForgotPasswordScreen2State extends State<ForgotPasswordScreen2> {
  final _formKey = GlobalKey<FormState>();
  final email;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  _ForgotPasswordScreen2State({this.email});
  final password1 = TextEditingController();
  final password2 = TextEditingController();
  void showMessage(BuildContext context, String message) {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: MyColors.scarlet, size: 30),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (80 / 1063.6),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Password *",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: TextFormField(
                            controller: password1,
                            obscureText: _isObscure1,
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              } else if (!regex.hasMatch(value)) {
                                showMessage(context,
                                    "Password Error\n\nPassword Length must be at least 8 characters\nIt must contain atleast:\n1 Capital Letter\n1 Lower Letter\n1 Digit\n1 Special Character");
                                return "Enter Proper Password";
                                //return "Password Length must be at least 8 characters\nIt must contain atleast:\n1 Capital Letter\n1 Lower Letter\n1 Digit\n1 Special Character";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                icon: Icon(
                                    _isObscure1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyColors.pewterBlue,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MyScreen.getScreenHeight(context) * (6 / 553)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Confirm Password *",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: TextFormField(
                            controller: password2,
                            obscureText: _isObscure2,
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Confirm Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                icon: Icon(
                                    _isObscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyColors.pewterBlue,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MyScreen.getScreenHeight(context) *
                              (580 / 1063.6),
                        ),
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
                                    width: MyScreen.getScreenWidth(context) *
                                        (85 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (60 / 1063.6),
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
                                  child: Text("Submit",
                                      style: TextStyle(
                                          color: MyColors.richBlackFogra,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (17 / 1063.6),
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                final pwd1 = password1.text.toString();
                                final pwd2 = password2.text.toString();
                                print(pwd1);
                                print(pwd2);
                                if (pwd1 != pwd2) {
                                  showMessage(
                                      context, "Both Password Should Match");
                                  return;
                                }
                                Employee emp = await Utility.getEmployee(email);
                                emp.password = pwd1;
                                Database_signUp.updateEmp(emp);
                                print(email);
                                Send_Mail.send_mail(
                                    email,
                                    "Password Reset Successful",
                                    "Your password is changed, IF it was not you, then click on forgot password and reset it");
                                Navigator.pop(context);
                                Navigator.pushNamed(context, MyRoutes.MyLogin);
                              }
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
      ),
    );
  }
}
