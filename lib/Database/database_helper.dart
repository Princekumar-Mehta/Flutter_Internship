import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'customer.dart';
import 'customer_branch.dart';
import 'employee.dart';

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
     password TEXT,
     role TEXT,
     status TEXT
     profile_pic TEXT
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
     city TEXT,
     state TEXT,
     country TEXT,
     post_Code INTEGER,
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
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await instance.database;
    var emps = await db.query('employees');
    List<Employee> employeesList =
        emps.isNotEmpty ? emps.map((c) => Employee.fromMap((c))).toList() : [];
    return employeesList;
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

  Future<int> addEmp(Employee emp) async {
    Database db = await instance.database;
    return await db.insert('employees', emp.toMap());
  }

  Future<int> update(Employee emp) async {
    Database db = await instance.database;
    return await db
        .update('employees', emp.toMap(), where: 'id = ?', whereArgs: [emp.id]);
  }

  Future<void> Temp_Query() async {
    Database db = await instance.database;
  }

  Future<int> addCustomer(Customer customer) async {
    Database db = await instance.database;
    return await db.insert('customers', customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    Database db = await instance.database;
    var customers = await db.query('customers');
    List<Customer> CustomersList = customers.isNotEmpty
        ? customers.map((c) => Customer.fromMap((c))).toList()
        : [];
    print(CustomersList.toString());
    return CustomersList;
  }

  Future<bool> isCustomerTableContainData() async {
    Database db = await instance.database;
    var customers = await db.query('customers');
    print(customers.isNotEmpty);
    return customers.isNotEmpty;
  }

  Future<Customer?> getCustomer(
      {required String email, required int id}) async {
    Database db = await instance.database;
    if (email != '') {
      var emp =
          await db.query('customers', where: 'email = ?', whereArgs: [email]);
      List<Customer> empList =
          emp.isNotEmpty ? emp.map((c) => Customer.fromMap((c))).toList() : [];
      if (empList.isEmpty) return null;
      return empList[0];
    } else {
      var emp = await db.query('customers', where: 'id = ?', whereArgs: [id]);
      List<Customer> empList =
          emp.isNotEmpty ? emp.map((c) => Customer.fromMap((c))).toList() : [];
      if (empList.isEmpty) return null;
      return empList[0];
    }
  }

  Future<bool> isCustomerBranchTableContainData() async {
    Database db = await instance.database;
    var customers = await db.query('customers_branches');
    return customers.isNotEmpty;
  }

  Future<int> addCustomerBranch(Customer_Branch customerBranch) async {
    Database db = await instance.database;
    return await db.insert('customers_branches', customerBranch.toMap());
  }

  Future<List<Customer_Branch>> getCustomerBranches(
      int branchType, String customer_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customers;
    if (branchType == 0) {
      customers = await db.rawQuery(
          "SELECT * FROM customers_branches where code = '$customer_code' and branch_Type = 'Bill To / Ship To' or branch_Type = 'Bill To' order by branch_code;");
    } else {
      customers = await db.rawQuery(
          "SELECT * FROM customers_branches where branch_Type = 'Bill To / Ship To' or branch_Type = 'Ship To' order by branch_code;");
    }
    List<Customer_Branch> Customer_BranchList = customers.isNotEmpty
        ? customers.map((c) => Customer_Branch.fromMap((c))).toList()
        : [];
    return Customer_BranchList;
  }

  Future<List<Customer_Branch>> getCustomerBranchContact(
      String branch_code) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customer_branch = await db.rawQuery(
        "SELECT * FROM customers_branches where branch_Code = '$branch_code'");
    List<Customer_Branch> Customer_BranchList = customer_branch.isNotEmpty
        ? customer_branch.map((c) => Customer_Branch.fromMap((c))).toList()
        : [];
    print("hello db class contant");
    print(Customer_BranchList);
    return Customer_BranchList;
  }

  Future<Customer_Branch?> getCustomerBranch(
      {required String email, required int id}) async {
    Database db = await instance.database;
    if (email != '') {
      var emp = await db
          .query('customers_branches', where: 'email = ?', whereArgs: [email]);
      List<Customer_Branch> empList = emp.isNotEmpty
          ? emp.map((c) => Customer_Branch.fromMap((c))).toList()
          : [];
      if (empList.isEmpty) return null;
      return empList[0];
    } else {
      var emp = await db
          .query('customers_branches', where: 'id = ?', whereArgs: [id]);
      List<Customer_Branch> empList = emp.isNotEmpty
          ? emp.map((c) => Customer_Branch.fromMap((c))).toList()
          : [];
      if (empList.isEmpty) return null;
      return empList[0];
    }
  }
}
