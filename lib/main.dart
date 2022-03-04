import 'package:flutter/material.dart';
import 'package:project_v3/routes.dart';
import 'package:project_v3/screens/adminHome.dart';
import 'package:project_v3/screens/approveOrderScreen.dart';
import 'package:project_v3/screens/forgotPasswordScreen1.dart';
import 'package:project_v3/screens/forgotPasswordScreen2.dart';
import 'package:project_v3/screens/leaveRequestForm.dart';
import 'package:project_v3/screens/leaveRequestScreen.dart';
import 'package:project_v3/screens/loginScreen.dart';
import 'package:project_v3/screens/myLeaveRequestSummary.dart';
import 'package:project_v3/screens/processingOrderScreen.dart';
import 'package:project_v3/screens/salesOrderScreen.dart';
import 'package:project_v3/screens/salespersonHome.dart';
import 'package:project_v3/screens/signUp_Email.dart';
import 'package:project_v3/screens/splashScreen.dart';
import 'package:project_v3/screens/viewEmployeeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.MyLogin,
      routes: {
        //  MyRoutes.MyTempScreen: (context) => DynamicForms(),
        MyRoutes.MYSplashScreen: (context) => SplashScreen(),
        MyRoutes.MyLogin: (context) => LoginScreen(),
        MyRoutes.MySignUpEmail: (context) => SignUpEmail(),
        MyRoutes.MySalesOrder: (context) => SalesOrderScreen(),
        MyRoutes.MyForgotPasswordScreen1: (context) => ForgotPasswordScreen1(),
        MyRoutes.MyForgotPasswordScreen2: (context) => ForgotPasswordScreen2(),
        MyRoutes.MyAdminHome: (context) => adminHome(),
        MyRoutes.MyLeaveRequest: (context) => LeaveRequest(),
        MyRoutes.MyApproveOrder: (context) => ApproveOrder(),
        MyRoutes.MyLeaveRequestForm: (context) => LeaveRequestForm(),
        MyRoutes.MyEditEmployeeScreen: (context) => ViewEmployeeScreen(),
        MyRoutes.MyLeaveRequestSummary: (context) => myLeaveRequestSummary(),
        MyRoutes.MySalespersonHome: (context) => SalespersonHome(),
        MyRoutes.MyProcessingOrders: (context) => ProcessingOrder(),
      },
    );
  }
}
