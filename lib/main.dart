import 'package:flutter/material.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/screens/ViewFeedbackScreen.dart';
import 'package:project_v3/screens/addCustomer.dart';
import 'package:project_v3/screens/addEmployee.dart';
import 'package:project_v3/screens/addItem.dart';
import 'package:project_v3/screens/adminHome.dart';
import 'package:project_v3/screens/approveOrderScreen.dart';
import 'package:project_v3/screens/customerFeedbackScreen.dart';
import 'package:project_v3/screens/exploreAttendance.dart';
import 'package:project_v3/screens/forgotPasswordScreen1.dart';
import 'package:project_v3/screens/forgotPasswordScreen2.dart';
import 'package:project_v3/screens/fulfilledOrderScreen.dart';
import 'package:project_v3/screens/leaveRequestForm.dart';
import 'package:project_v3/screens/leaveRequestScreen.dart';
import 'package:project_v3/screens/loginScreen.dart';
import 'package:project_v3/screens/managerHome.dart';
import 'package:project_v3/screens/mapScreen.dart';
import 'package:project_v3/screens/myLeaveRequestSummary.dart';
import 'package:project_v3/screens/planRouteScreen1.dart';
import 'package:project_v3/screens/processingOrderScreen.dart';
import 'package:project_v3/screens/reportHome.dart';
import 'package:project_v3/screens/salesOrderScreen.dart';
import 'package:project_v3/screens/salespersonAttendance.dart';
import 'package:project_v3/screens/salespersonHome.dart';
import 'package:project_v3/screens/searchFunction.dart';
import 'package:project_v3/screens/splashScreen.dart';
import 'package:project_v3/screens/viewCustomer.dart';
import 'package:project_v3/screens/viewEmployeeScreen.dart';
import 'package:project_v3/screens/viewItems.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.MYSplashScreen,
      routes: {
        //  MyRoutes.MyTempScreen: (context) => DynamicForms(),
        MyRoutes.MYSplashScreen: (context) => SplashScreen(),
        MyRoutes.MyLogin: (context) => LoginScreen(),
        MyRoutes.MySignUpEmail: (context) => SignUpEmail(),
        MyRoutes.MySalesOrder: (context) => SalesOrderScreen(),
        MyRoutes.MyForgotPasswordScreen1: (context) => ForgotPasswordScreen1(),
        MyRoutes.MyForgotPasswordScreen2: (context) => ForgotPasswordScreen2(),
        MyRoutes.MyAdminHome: (context) => AdminHome(),
        MyRoutes.MyLeaveRequest: (context) => LeaveRequest(),
        MyRoutes.MyApproveOrder: (context) => ApproveOrder(),
        MyRoutes.MyLeaveRequestForm: (context) => LeaveRequestForm(),
        MyRoutes.MyEditEmployeeScreen: (context) => ViewEmployeeScreen(),
        MyRoutes.MyLeaveRequestSummary: (context) => myLeaveRequestSummary(),
        MyRoutes.MySalespersonHome: (context) => SalespersonHome(),
        MyRoutes.MyProcessingOrders: (context) => ProcessingOrder(),
        MyRoutes.MySalespersonAttendance: (context) => SalespersonAttendance(),
        MyRoutes.MyMapScreen: (context) => MapSample(),
        MyRoutes.MyAddItemScreen: (context) => AddItem(),
        MyRoutes.MyExploreAttendanceScreen: (context) => ExploreAttendance(),
        MyRoutes.MySearchFunction: (context) => SearchFunctions(),
        MyRoutes.MyFulfilledOrders: (context) => FulfilledOrder(),
        MyRoutes.MyReportHome: (context) => ReportHome(),
        MyRoutes.MyViewItems: (context) => ViewItems(),
        MyRoutes.MyManagerHome: (context) => ManagerHome(),
        MyRoutes.MyAddCustomerScreen: (context) => AddCustomer(),
        MyRoutes.MyViewCustomerScreen: (context) => ViewCustomerScreen(),
        MyRoutes.MyCustomerFeedbackScreen: (context) =>
            CustomerFeedbackScreen(),
        MyRoutes.MyViewCustomerFeedbackScreen: (context) =>
            ViewCustomerFeedbackScreen(),
        MyRoutes.MySetRouteMapScreen: (context) => PlanRouteScreen1(),
      },
    );
  }
}
