import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/employee.dart';
import 'package:project_v3/Models/final_individual_order.dart';
import 'package:project_v3/Models/hourly_attendance.dart';
import 'package:project_v3/Models/leave_request.dart';
import 'package:project_v3/Models/region_salesperson.dart';
import 'package:project_v3/Models/route.dart';
import 'package:project_v3/Models/stock.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/customer.dart';
import '../Models/customer_branch.dart';
import '../Models/customer_feedback.dart';
import '../Models/daily_attendance.dart';
import '../Models/final_order.dart';
import '../Models/item.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'DIMS.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE employees(
     profile_pic TEXT,
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT,
     email TEXT,
     phone TEXT,
     password TEXT,
     role TEXT,
     managerid TEXT,
     status TEXT,
    darkTheme INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE customers(
     code TEXT PRIMARY KEY,
     party_Name TEXT,
     nick_Name TEXT,
     doc_Type TEXT,
     grp TEXT,
     sub_Group TEXT,
     map_Cn INTEGER,
     branch_Cn INTEGER,
     sub_Area TEXT,
     area TEXT,
     email TEXT,
     phone_1 TEXT,
     phone_2 TEXT,
     crd_Day INTEGER,
     crd_Amt INTEGER,
     gL_Acc INTEGER,
     active TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE customers_branches(
     code TEXT,
     branch_Code TEXT PRIMARY KEY,
     branch_Type TEXT,
     branch_Name TEXT,
     address1 TEXT,
     address2 TEXT,
     location TEXT,
     latitude TEXT,
     longitude TEXT,
     city TEXT,
     state TEXT,
     country TEXT,
     post_Code INTEGER,
     sub_Area TEXT,
     area TEXT,
     contact_Person TEXT,
     branch_Email TEXT,
     branch_Phone TEXT,
     gstin TEXT,
     pan TEXT,
     composite_Scheme TEXT,
     isDefault TEXT,
     active TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE items(
      code TEXT PRIMARY KEY,
   hsn_Code INTEGER,
   item_Name TEXT,
   grp TEXT, 
   sub_Group TEXT,
   item_Type TEXT,
   unit_Item INTEGER,
   barcode INTEGER,
   pur_Item TEXT,
   sell_Item TEXT,
   price INTEGER,
   net_Weight INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE final_order(
       order_Id INTEGER PRIMARY KEY AUTOINCREMENT,
       customer_Code TEXT,
       billing_Branch_Code TEXT,
       shipping_Branch_Code TEXT,
       manufacturing_Branch_Code TEXT,
       total INTEGER,
       order_by_date TEXT,
       status TEXT,
       file_Address TEXT,
       salesperson_Code INTEGER,
       chequePhotoPath TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE final_individual_order(
       individual_order_Id INTEGER PRIMARY KEY AUTOINCREMENT,
       order_Id INTEGER,
       packet INTEGER,
       patti INTEGER,
       box INTEGER,
       item_Code TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE leave_requests(
       request_Id INTEGER PRIMARY KEY AUTOINCREMENT,
       reason TEXT,
       reason_desc TEXT,
       fromdate TEXT,
       todate TEXT,
       emp_id INTEGER,
       status TEXT,
       days INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE hourly_attendance(
      hourly_attendace_p INTEGER PRIMARY KEY AUTOINCREMENT,
      emp_id INTEGER,
      date TEXT,
      time TEXT,
      latitude TEXT,
      longitude TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE daily_attendance(
      daily_attendance_p INTEGER PRIMARY KEY AUTOINCREMENT,
      emp_id INTEGER,
      date TEXT,
      hours TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE customer_feedback(
      customer_feedback_p INTEGER PRIMARY KEY AUTOINCREMENT,
      salesperson_Code INTEGER,
      date TEXT,
      month INTEGER,
      year INTEGER,
      branch_Code TEXT,
      rating TEXT,
      reason TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE stock(
      stock_p INTEGER PRIMARY KEY AUTOINCREMENT,
      emp_Id INTEGER,
      role TEXT,
      item_Id TEXT,
      packet INTEGER,
      patti INTEGER,
      box INTEGER,
      minimum_Packet INTEGER,
      order_Packet INTEGER,
      last_Order_In_Packet INTEGER,
      last_Order_Date TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE routes(
      route_p INTEGER PRIMARY KEY AUTOINCREMENT,
      salesperson_Id INTEGER,
      day TEXT,
      route TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE region_salesperson(
      region_salesperson_p INTEGER PRIMARY KEY AUTOINCREMENT,
      emp_Id INTEGER,
      sub_Area TEXT,
      area TEXT
    )
    ''');
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await instance.database;
    var emps = await db.query('employees');
    List<Employee> employeesList =
        emps.isNotEmpty ? emps.map((c) => Employee.fromMap((c))).toList() : [];
    return employeesList;
  }

  Future<List<Employee>> getSalespersons() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> salespersons = await db.rawQuery(
        "SELECT * FROM employees where role = 'Salesperson'"); //where role = 'Salesperson'
    List<Employee> SalespersonList = salespersons.isNotEmpty
        ? salespersons.map((c) => Employee.fromMap((c))).toList()
        : [];
    return SalespersonList;
  }

  Future<Employee?> getEmp({required String email, required int id}) async {
    Database db = await instance.database;
    if (email != '') {
      var emp =
          await db.query('employees', where: 'email = ?', whereArgs: [email]);
      List<Employee> empList =
          emp.isNotEmpty ? emp.map((c) => Employee.fromMap((c))).toList() : [];
      if (empList.isEmpty) return null;
      return empList[0];
    } else {
      var emp = await db.query('employees', where: 'id = ?', whereArgs: [id]);
      ;
      List<Employee> empList =
          emp.isNotEmpty ? emp.map((c) => Employee.fromMap((c))).toList() : [];
      if (empList.isEmpty) return null;
      return empList[0];
    }
  }

  Future<List<Employee>?> getAllEmp() async {
    Database db = await instance.database;
    var emp = await db.query('employees');
    ;
    List<Employee> empList =
        emp.isNotEmpty ? emp.map((c) => Employee.fromMap((c))).toList() : [];
    if (empList.isEmpty) return null;
    return empList;
  }

  Future<int> addEmp(Employee emp) async {
    Database db = await instance.database;
    return await db.insert('employees', emp.toMap());
  }

  Future<int> update(Employee emp) async {
    Database db = await instance.database;
    return await db
        .update('employees', emp.toMap(), where: 'id = ?', whereArgs: [emp.id]);
  }

  Future<void> insertAdminIfNot() async {
    Database db = await instance.database;
    if (await Utility.isNotExist("1")) await Utility.insert_Admin();
  }

  Future<void> Temp_Query() async {
    Database db = await instance.database;
    await db.rawQuery("DELETE FROM routes");
  }

  Future<int> addCustomer(Customer customer) async {
    Database db = await instance.database;
    return await db.insert('customers', customer.toMap());
  }

  Future<int> updateCustomer(Customer customer) async {
    Database db = await instance.database;
    print("in databs file update : " + customer.code!);
    return await db.update('customers', customer.toMap(),
        where: 'code = ?', whereArgs: [customer.code]);
  }

  Future<List<Customer>> getCustomers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customers =
        await db.rawQuery("SELECT * FROM customers order by code ASC");
    List<Customer> CustomersList = customers.isNotEmpty
        ? customers.map((c) => Customer.fromMap((c))).toList()
        : [];
    return CustomersList;
  }

  Future<List<Customer>> getCustomersBySubArea(String sub_Area) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customers = await db.rawQuery(
        "SELECT * FROM customers where sub_Area = '$sub_Area' order by code ASC");
    List<Customer> CustomersList = customers.isNotEmpty
        ? customers.map((c) => Customer.fromMap((c))).toList()
        : [];
    return CustomersList;
  }

  Future<List<Customer>> getCustomer(String customer_Code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer = await db
        .rawQuery("SELECT * FROM customers where code = '$customer_Code'");
    List<Customer> CustomerList = customer.isNotEmpty
        ? customer.map((c) => Customer.fromMap((c))).toList()
        : [];
    return CustomerList;
  }

  Future<List<Customer>> getCustomerByPartyName(
      String customer_party_Name) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer = await db.rawQuery(
        "SELECT * FROM customers where party_Name = '$customer_party_Name'");
    List<Customer> CustomerList = customer.isNotEmpty
        ? customer.map((c) => Customer.fromMap((c))).toList()
        : [];
    return CustomerList;
  }

  Future<bool> isCustomerTableContainData() async {
    Database db = await instance.database;
    var customers = await db.query('customers');
    return customers.isNotEmpty;
  }

  Future<bool> isCustomerBranchTableContainData() async {
    Database db = await instance.database;
    var customers = await db.query('customers_branches');
    return customers.isNotEmpty;
  }

  Future<int> addCustomerBranch(Map<String, dynamic> customerBranch) async {
    Database db = await instance.database;
    return await db.insert('customers_branches', customerBranch);
  }

  Future<List<CustomerBranch>> getCustomerBranches(
      int branchType, String customer_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer_branches;

    if (branchType == 0) {
      customer_branches = await db.rawQuery(
          "SELECT * FROM customers_branches where code = '$customer_code' and (branch_Type = 'Bill To / Ship To' or branch_Type = 'Bill To') order by branch_code;");
    } else {
      customer_branches = await db.rawQuery(
          "SELECT * FROM customers_branches where code = '$customer_code' and (branch_Type = 'Bill To / Ship To' or branch_Type = 'Ship To') order by branch_code;");
    }
    List<CustomerBranch> Customer_BranchList = customer_branches.isNotEmpty
        ? customer_branches.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return Customer_BranchList;
  }

  Future<List<CustomerBranch>> getAllCustomerBranches() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customerBranch = await db
        .rawQuery("SELECT * FROM customers_branches order by branch_Code");
    List<CustomerBranch> CustomerBranchList = customerBranch.isNotEmpty
        ? customerBranch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return CustomerBranchList;
  }

  Future<List<CustomerBranch>> getAllCustomerBranchesByCode(
      String customer_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customerBranch = await db.rawQuery(
        "SELECT * FROM customers_branches where code = '$customer_code' order by branch_Code");
    List<CustomerBranch> CustomerBranchList = customerBranch.isNotEmpty
        ? customerBranch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return CustomerBranchList;
  }

  Future<List<CustomerBranch>> getAllCustomerBranchesBysubArea(
      String sub_Area) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customerBranch = await db.rawQuery(
        "SELECT * FROM customers_branches where sub_Area = '$sub_Area' and (branch_Type = 'Bill To / Ship To' or branch_Type = 'Ship To')");
    List<CustomerBranch> CustomerBranchList = customerBranch.isNotEmpty
        ? customerBranch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return CustomerBranchList;
  }

  Future<List<CustomerBranch>> getCustomerBranch(String branch_Code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customerBranch = await db.rawQuery(
        "SELECT * FROM customers_branches where branch_Code = '$branch_Code'");
    List<CustomerBranch> CustomerBranchList = customerBranch.isNotEmpty
        ? customerBranch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return CustomerBranchList;
  }

  Future<List<CustomerBranch>> getCustomerBranchByBranchName(
      String branch_Name) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customerBranch = await db.rawQuery(
        "SELECT * FROM customers_branches where branch_Name = '$branch_Name'");
    List<CustomerBranch> CustomerBranchList = customerBranch.isNotEmpty
        ? customerBranch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return CustomerBranchList;
  }

  Future<List<CustomerBranch>> getCustomerBranchContact(
      String branch_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer_branch = await db.rawQuery(
        "SELECT * FROM customers_branches where branch_Code = '$branch_code'");
    List<CustomerBranch> Customer_BranchList = customer_branch.isNotEmpty
        ? customer_branch.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return Customer_BranchList;
  }

  Future<int> addItem(Item item) async {
    Database db = await instance.database;
    return await db.insert('items', item.toMap());
  }

  Future<int> updateItem(Item item) async {
    Database db = await instance.database;
    return await db.update('items', item.toMap(),
        where: 'code = ?', whereArgs: [item.code]);
  }

  Future<List<Item>> getItems() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> items =
        await db.rawQuery("SELECT * FROM items order by code ASC");
    List<Item> ItemList =
        items.isNotEmpty ? items.map((c) => Item.fromMap((c))).toList() : [];
    return ItemList;
  }

  Future<List<Item>> getItem(String item_Name, int net_Weight) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> items = await db.rawQuery(
        "SELECT * FROM items where (item_Name = '$item_Name' and net_Weight = '$net_Weight')");
    List<Item> ItemList =
        items.isNotEmpty ? items.map((c) => Item.fromMap((c))).toList() : [];
    return ItemList;
  }

  Future<List<Item>> getItemByItemId(String item_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> items =
        await db.rawQuery("SELECT * FROM items where code = '$item_Id'");
    List<Item> ItemList =
        items.isNotEmpty ? items.map((c) => Item.fromMap((c))).toList() : [];
    return ItemList;
  }

  Future<bool> isItemTableContainData() async {
    Database db = await instance.database;
    var customers = await db.query('items');
    return customers.isNotEmpty;
  }

  Future<int> addFinalOrder(FinalOrder final_order) async {
    Database db = await instance.database;
    return await db.insert('final_order', final_order.toMap());
  }

  Future<List<FinalOrder>> getFinalOrder() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_orders =
        await db.rawQuery("SELECT * FROM final_order");
    List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
        ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    return FinalOrderList;
  }

  Future<List<FinalOrder>> getFinalOrderLastId() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_orders =
        await db.rawQuery("SELECT * FROM final_order order by order_Id DESC");
    List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
        ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    return FinalOrderList;
  }

  Future<int> addFinalIndividualOrder(
      FinalIndividualOrder final_individual_order) async {
    Database db = await instance.database;
    return await db.insert(
        'final_individual_order', final_individual_order.toMap());
  }

  Future<List<FinalIndividualOrder>> getFinalIndividualOrderByItemId(
      String item_Code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> orders = await db.rawQuery(
        "SELECT * FROM final_individual_order where item_Code = '$item_Code'");
    List<FinalIndividualOrder> OrderList = orders.isNotEmpty
        ? orders.map((c) => FinalIndividualOrder.fromMap((c))).toList()
        : [];
    return OrderList;
  }

  Future<List<FinalOrder>> getFinalOrderBySalespersonId(
      String salesperson_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> orders = await db.rawQuery(
        "SELECT * FROM final_order where salesperson_Code = '$salesperson_code'");
    List<FinalOrder> OrderList = orders.isNotEmpty
        ? orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    return OrderList;
  }

  Future<List<FinalOrder>> getPendingOrders() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_orders = await db
        .rawQuery("SELECT * FROM final_order where status = 'Pending_Admin'");
    List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
        ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    // print(FinalOrderList);
    return FinalOrderList;
  }

  Future<List<FinalOrder>> getFulfilledOrders() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_orders = await db.rawQuery(
        "SELECT * FROM final_order where (status = 'Fulfilled' or status = 'Rejected')");
    List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
        ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    //print(FinalOrderList);
    return FinalOrderList;
  }

  Future<List<FinalOrder>> getProcessingOrders(
      int emp_id, String emp_role) async {
    Database db = await instance.database;
    if (emp_role == "Admin") {
      List<Map<String, dynamic>> final_orders = await db
          .rawQuery("SELECT * FROM final_order where status = 'Processing'");
      List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
          ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
          : [];
      // print(FinalOrderList);
      return FinalOrderList;
    } else {
      List<Map<String, dynamic>> final_orders = await db.rawQuery(
          "SELECT * FROM final_order where status = 'Processing' and salesperson_Code = $emp_id order by order_by_date asc");
      List<Map<String, dynamic>> fulfilled_orders = await db.rawQuery(
          "SELECT * FROM final_order where (status = 'Fulfilled' or status = 'Rejected') and salesperson_Code = $emp_id order by order_by_date desc");
      List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
          ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
          : [];
      List<FinalOrder> FulfilledOrderList = fulfilled_orders.isNotEmpty
          ? fulfilled_orders.map((c) => FinalOrder.fromMap((c))).toList()
          : [];
      for (int i = 0; i < FulfilledOrderList.length; i++) {
        FinalOrderList.add(FulfilledOrderList[i]);
      }
      // print(FinalOrderList);
      return FinalOrderList;
    }
  }

  Future<List<FinalIndividualOrder>> getFinalIndividualOrder() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_individual_orders =
        await db.rawQuery("SELECT * FROM final_individual_order");
    List<FinalIndividualOrder> FinalIndividualOrderList =
        final_individual_orders.isNotEmpty
            ? final_individual_orders
                .map((c) => FinalIndividualOrder.fromMap((c)))
                .toList()
            : [];
    return FinalIndividualOrderList;
  }

  Future<List<FinalIndividualOrder>> getFinalIndividualOrderByOrderId(
      int order_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_individual_orders = await db.rawQuery(
        "SELECT * FROM final_individual_order where order_Id = $order_Id");
    List<FinalIndividualOrder> FinalIndividualOrderList =
        final_individual_orders.isNotEmpty
            ? final_individual_orders
                .map((c) => FinalIndividualOrder.fromMap((c)))
                .toList()
            : [];
    return FinalIndividualOrderList;
  }

  Future<int> updateOrder(FinalOrder finalOrder) async {
    Database db = await instance.database;
    return await db.update('final_order', finalOrder.toMap(),
        where: 'order_Id = ?', whereArgs: [finalOrder.order_Id]);
  }

  updateOrderChequePhoto(int order_Id, String path) async {
    Database db = await instance.database;
    print("in database helper : " + path);
    await db.rawQuery(
        "UPDATE final_order SET chequePhotoPath = '${path}' where order_Id = ${order_Id}");
  }

  Future<int> addRequest(LeaveRequest request) async {
    Database db = await instance.database;
    return await db.insert('leave_requests', request.toMap());
  }

  Future<List<LeaveRequest>> getAllLeaveRequest() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> leave_request = await db
        .rawQuery("SELECT * FROM leave_requests where status = 'Pending'");
    List<LeaveRequest> LeaveRequestList = leave_request.isNotEmpty
        ? leave_request.map((c) => LeaveRequest.fromMap((c))).toList()
        : [];
    // print(LeaveRequestList);
    return LeaveRequestList;
  }

  Future<String> getLastLeaveRequest(int emp_id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> leave_request = await db.rawQuery(
        "SELECT * FROM leave_requests where status = 'Accepted' and emp_id = emp_id order by todate DESC");
    List<LeaveRequest> LeaveRequestList = leave_request.isNotEmpty
        ? leave_request.map((c) => LeaveRequest.fromMap((c))).toList()
        : [];
    if (LeaveRequestList.isEmpty)
      return "";
    else {
      return LeaveRequestList[0].todate!;
    }
  }

  Future<List<LeaveRequest>> getTotalAcceptedLeaveRequest(int emp_id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> leave_request = await db.rawQuery(
        "SELECT * FROM leave_requests where status = 'Accepted' and emp_id = emp_id");
    List<LeaveRequest> LeaveRequestList = leave_request.isNotEmpty
        ? leave_request.map((c) => LeaveRequest.fromMap((c))).toList()
        : [];
    // print(LeaveRequestList);
    return LeaveRequestList;
  }

  Future<List<LeaveRequest>> getTotalLeaveRequest(int emp_id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> leave_request =
        await db.rawQuery("SELECT * FROM leave_requests where emp_id = emp_id");
    List<LeaveRequest> LeaveRequestList = leave_request.isNotEmpty
        ? leave_request.map((c) => LeaveRequest.fromMap((c))).toList()
        : [];
    // print(LeaveRequestList);
    return LeaveRequestList;
  }

  updateLeaveRequest(LeaveRequest leaveRequest) async {
    Database db = await instance.database;
    await db.rawQuery(
        "UPDATE leave_requests SET status = '${leaveRequest.status}' where request_Id = ${leaveRequest.request_Id}");
  }

  Future<int> addHourlyAttendance(Hourly_Attendance hourly_attendance) async {
    Database db = await instance.database;
    return await db.insert('hourly_attendance', hourly_attendance.toMap());
  }

  Future<List<Hourly_Attendance>> getHourlyAttendance(
      int emp_id, String date) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> hourly_attendance = await db.rawQuery(
        "SELECT * FROM hourly_attendance where (emp_id = $emp_id and date = '$date')");
    List<Hourly_Attendance> HourlyAttendanceList = hourly_attendance.isNotEmpty
        ? hourly_attendance.map((c) => Hourly_Attendance.fromMap((c))).toList()
        : [];
    return HourlyAttendanceList;
  }

  Future<int> addDailyAttendance(Daily_Attendance daily_attendance) async {
    Database db = await instance.database;
    return await db.insert('daily_attendance', daily_attendance.toMap());
  }

  updateDailyAttendance(Daily_Attendance daily_attendance) async {
    Database db = await instance.database;
    await db.rawQuery(
        "UPDATE daily_attendance SET hours = '${daily_attendance.hours}' where date = ${daily_attendance.date}");
  }

  Future<List<Daily_Attendance>> getDailyAttendance(
      int emp_id, String date) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> daily_attendance = await db.rawQuery(
        "SELECT * FROM daily_attendance where (emp_id = $emp_id and date = '$date')");
    List<Daily_Attendance> DailyAttendanceList = daily_attendance.isNotEmpty
        ? daily_attendance.map((c) => Daily_Attendance.fromMap((c))).toList()
        : [];
    return DailyAttendanceList;
  }

  Future<int> getAvgAttendanceBySalespersonId(String emp_id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> hours = await db.rawQuery(
        "SELECT AVG(hours) FROM daily_attendance where emp_id = '$emp_id'");
    print(hours);
    if (hours[0]['AVG(hours)'] == null) return 0;
    return hours[0]['AVG(hours)'].toInt();
  }

  Future<int> addCustomerFeedback(Customer_Feedback customer_feedback) async {
    Database db = await instance.database;
    return await db.insert('customer_feedback', customer_feedback.toMap());
  }

  Future<List<Customer_Feedback>> getCustomerFeedbackBySalespersonCode(
      int salesperson_Code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> existing_customer_feedbacks = await db.rawQuery(
        "SELECT * FROM customer_feedback where salesperson_Code = '$salesperson_Code' order by customer_feedback_p DESC"); //where role = 'Salesperson'
    List<Customer_Feedback> CustomerFeedbackList =
        existing_customer_feedbacks.isNotEmpty
            ? existing_customer_feedbacks
                .map((c) => Customer_Feedback.fromMap((c)))
                .toList()
            : [];
    return CustomerFeedbackList;
  }

  Future<List<Customer_Feedback>> getExistingBranchesCustomerFeedback(
      int salesperson_Code, int month, int year) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> existing_customer_feedbacks = await db.rawQuery(
        "SELECT * FROM customer_feedback where salesperson_Code = '$salesperson_Code' and month =  '$month' and year =  '$year' order by month DESC"); //where role = 'Salesperson'
    List<Customer_Feedback> CustomerFeedbackList =
        existing_customer_feedbacks.isNotEmpty
            ? existing_customer_feedbacks
                .map((c) => Customer_Feedback.fromMap((c)))
                .toList()
            : [];
    return CustomerFeedbackList;
  }

  Future<List<Customer_Feedback>> getCustomerFeedback(
      int salesperson_Code, String branch_Code, int month, int year) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer_feedbacks = await db.rawQuery(
        "SELECT * FROM customer_feedback where salesperson_Code = '$salesperson_Code' and branch_Code = '$branch_Code' and month =  '$month' and year =  '$year' order by month DESC"); //where role = 'Salesperson'
    List<Customer_Feedback> CustomerFeedbackList = customer_feedbacks.isNotEmpty
        ? customer_feedbacks.map((c) => Customer_Feedback.fromMap((c))).toList()
        : [];
    return CustomerFeedbackList;
  }

  Future<int> addStock(Stock stock) async {
    Database db = await instance.database;
    return await db.insert('stock', stock.toMap());
  }

  Future<List<Stock>> getStockForAllEmp() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> stocks =
        await db.rawQuery("SELECT * FROM stock");
    List<Stock> StockList =
        stocks.isNotEmpty ? stocks.map((c) => Stock.fromMap((c))).toList() : [];
    return StockList;
  }

  Future<Stock> getStock(int emp_Id, String item_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> stocks = await db.rawQuery(
        "SELECT * FROM stock where emp_Id = $emp_Id and item_Id = '$item_Id'");
    List<Stock> StockList =
        stocks.isNotEmpty ? stocks.map((c) => Stock.fromMap((c))).toList() : [];
    return StockList[0];
  }

  Future<List<Stock>> getStockByEmpId(int emp_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> stocks =
        await db.rawQuery("SELECT * FROM stock where emp_Id = $emp_Id");
    List<Stock> StockList =
        stocks.isNotEmpty ? stocks.map((c) => Stock.fromMap((c))).toList() : [];
    return StockList;
  }

  Future<int> updateStock(Stock stock) async {
    Database db = await instance.database;
    return await db.update('stock', stock.toMap(),
        where: 'emp_Id = ? and item_Id = ?',
        whereArgs: [stock.emp_Id, stock.item_Id]);
  }

  Future<int> addRoute(Route route) async {
    Database db = await instance.database;
    return await db.insert('routes', route.toMap());
  }

  Future<List<Route>> getAllRoutesBySalespersonId(int salesperson_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> routes = await db.rawQuery(
        "SELECT * FROM routes where salesperson_Id = $salesperson_Id");
    List<Route> RouteList =
        routes.isNotEmpty ? routes.map((c) => Route.fromMap((c))).toList() : [];
    return RouteList;
  }

  Future<List<Route>> getRoutesBySalespersonIdDay(
      int salesperson_Id, String day) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> routes = await db.rawQuery(
        "SELECT * FROM routes where salesperson_Id = $salesperson_Id and day ='$day'");
    List<Route> RouteList =
        routes.isNotEmpty ? routes.map((c) => Route.fromMap((c))).toList() : [];
    return RouteList;
  }

  Future<int> updateRoute(Route route) async {
    Database db = await instance.database;
    return await db.update('routes', route.toMap(),
        where: 'salesperson_id = ? and day = ?',
        whereArgs: [route.salesperson_Id, route.day]);
  }

  Future<int> addRegionSalesperson(
      Region_Salesperson region_salesperson) async {
    Database db = await instance.database;
    return await db.insert('region_salesperson', region_salesperson.toMap());
  }

  Future<int> updateRegionSalesperson(
      Region_Salesperson region_salesperson) async {
    Database db = await instance.database;
    return await db.update('region_salesperson', region_salesperson.toMap(),
        where: 'emp_Id = ?', whereArgs: [region_salesperson.emp_Id]);
  }

  Future<List<Region_Salesperson>> getRegionsByEmpId(int emp_Id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> region_salesperson = await db.rawQuery(
        "SELECT * FROM region_salesperson where emp_id = $emp_Id"); //where role = 'Salesperson'
    List<Region_Salesperson> RegionSalespersonList =
        region_salesperson.isNotEmpty
            ? region_salesperson
                .map((c) => Region_Salesperson.fromMap((c)))
                .toList()
            : [];
    return RegionSalespersonList;
  }
}
