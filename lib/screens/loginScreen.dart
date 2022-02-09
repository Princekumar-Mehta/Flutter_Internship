import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_2/Database/db_SignUp.dart';
import 'package:project_2/Email/send_email.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:project_2/Extras/myScreen.dart';

import '../routes.dart';
import 'otpVerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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

  Future<void> showIdOtp(
    BuildContext context,
    String message,
    String email,
    int id,
    int otp,
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
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(
                          email: email, otp: otp, previous: "login")));
            },
          ),
        ],
      ),
    );
  }

  moveToHome(BuildContext context) async {
    await Database_signUp.print_emps();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RegExp _numeric = RegExp(r'^-?[0-9]+$');
      String? id = _formKey.currentState?.value['email_or_id'].toString();
      Employee? emp;
      if (_numeric.hasMatch(id!)) {
        emp = await Database_signUp.getEmp(email: '', id: int.parse(id));
      } else {
        emp = await Database_signUp.getEmp(
            email: _formKey.currentState?.value['email_or_id'], id: 0);
      }
      if (emp == null) {
        showMessage(context, 'No Entry with given Email/ID');
        return;
      }
      if (_formKey.currentState?.value['password'].toString() != emp.password) {
        showMessage(context, 'Wrong Password');
        return;
      }
      if (emp.status == 'Email Pending') {
        String? email = emp.email;
        print(email);
        int id = emp.id!;
        String otp_mail = (1000 + Random().nextInt(9999 - 1000)).toString();
        int otp = int.parse(otp_mail);
        Send_Mail.send_mail(email!, otp);
        showIdOtp(context, 'Email Verification Pending', email, id, otp);
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.MySalesOrder);
      _formKey.currentState!.reset();
    }
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: SizedBox(
            width: MyScreen.getScreenWidth(context),
            height: MyScreen.getScreenHeight(context),
            child: Stack(children: [
              Positioned(
                child: Container(
                  width: MyScreen.getScreenWidth(context),
                  height: MyScreen.getScreenHeight(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/Abstract_2.png"),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Positioned(
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: MyScreen.getScreenWidth(context),
                      height: MyScreen.getScreenHeight(context),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Center(
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      width: MyScreen.getScreenWidth(context) * (260 / 294),
                      height: MyScreen.getScreenHeight(context) * (290 / 553),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MyScreen.getScreenHeight(context) * (5 / 553))),
                        color: MyColors.richBlackFogra,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MyScreen.getScreenHeight(context) * 0.02,
                            left: MyScreen.getScreenWidth(context) * 0.05,
                            child: Text("Welcome!",
                                style: TextStyle(
                                    color: MyColors.pewterBlue,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (30 / 1063.6))),
                          ),
                          Positioned(
                            top: MyScreen.getScreenHeight(context) *
                                (140 / 1063.6),
                            left: MyScreen.getScreenWidth(context) * 0.05,
                            child: FormBuilder(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (30 / 1063.6),
                                    child: Text("Email/Employee ID *",
                                        style: TextStyle(
                                            color: MyColors.pewterBlue,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (20 / 1063.6))),
                                  ),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (50 / 1063.6),
                                    child: FormBuilderTextField(
                                        name: 'email_or_id',
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: MyColors.pewterBlue)),
                                        ),
                                        style: TextStyle(
                                            color: MyColors.middleRed,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (25 / 1063.6)),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter Email or Employee ID";
                                          }
                                          return null;
                                        }),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (6 / 553)),
                                  SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (228 / 294),
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (30 / 1063.6),
                                      child: Row(
                                        children: [
                                          Text("Password *",
                                              style: TextStyle(
                                                  color: MyColors.pewterBlue,
                                                  fontSize:
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (20 / 1063.6))),
                                        ],
                                      )),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (50 / 1063.6),
                                    child: FormBuilderTextField(
                                        name: 'password',
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: MyColors.pewterBlue)),
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            icon: Icon(
                                                _isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: MyColors.pewterBlue,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    (22 / 1063.6)),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                          ),
                                        ),
                                        style: TextStyle(
                                            color: MyColors.middleRed,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (25 / 1063.6)),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter Password";
                                          }
                                          return null;
                                        }),
                                  ),
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (233 / 294),
                                    alignment: Alignment.centerRight,
                                    height: MyScreen.getScreenHeight(context) *
                                        (30 / 683.4285714285714),
                                    child: TextButton(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            color: MyColors.middleRed,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (17 / 1063.6)),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context,
                                          MyRoutes.MyForgotPasswordScreen1),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (27 / 1063.6)),
                                  SizedBox(
                                    width: MyScreen.getScreenWidth(context) *
                                        (228 / 294),
                                    height: MyScreen.getScreenHeight(context) *
                                        (45 / 1063.6),
                                    child: InkWell(
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: 0.7,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(MyScreen
                                                            .getScreenHeight(
                                                                context) *
                                                        (15 / 553)),
                                                color: MyColors.scarlet,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text("Login",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MyScreen
                                                            .getScreenHeight(
                                                                context) *
                                                        (11 / 553))),
                                          )
                                        ],
                                      ),
                                      onTap: () => moveToHome(context),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6)),
                                  Text(
                                    'or',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (20 / 1063.6),
                                      color: MyColors.pewterBlue,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6)),
                                  SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6)),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (228 / 294),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (45 / 1063.6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    (5 / 553)),
                                            color: MyColors.pewterBlue,
                                          ),
                                          child: InkWell(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: MyScreen
                                                            .getScreenHeight(
                                                                context) *
                                                        (45 / 1063.6),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.account_circle,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (35 / 490.9),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            (130 / 490.9),
                                                  ),
                                                  Center(
                                                    child: Text("Sign Up",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MyScreen
                                                                    .getScreenHeight(
                                                                        context) *
                                                                (11 / 553))),
                                                  ),
                                                ],
                                              ),
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  MyRoutes.MySignUpEmail))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
