import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/employee.dart';
import 'package:project_v3/Database/final_individual_order.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:sqflite/sqflite.dart';

import 'customer.dart';
import 'customer_branch.dart';
import 'employee.dart';
import 'final_order.dart';
import 'item.dart';

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
       status TEXT
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

  Future<void> insertAdminIfNot() async {
    Database db = await instance.database;
    if (await Utility.isNotExist("1")) await Utility.insert_Admin();
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
          "SELECT * FROM customers_branches where code = '$customer_code' and branch_Type = 'Bill To / Ship To' or branch_Type = 'Bill To' order by branch_code;");
    } else {
      customer_branches = await db.rawQuery(
          "SELECT * FROM customers_branches where code = '$customer_code' and branch_Type = 'Bill To / Ship To' or branch_Type = 'Ship To' order by branch_code;");
    }
    List<CustomerBranch> Customer_BranchList = customer_branches.isNotEmpty
        ? customer_branches.map((c) => CustomerBranch.fromMap((c))).toList()
        : [];
    return Customer_BranchList;
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

  Future<List<Item>> getItems() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> items = await db.rawQuery("SELECT * FROM items");
    List<Item> ItemList =
        items.isNotEmpty ? items.map((c) => Item.fromMap((c))).toList() : [];
    return ItemList;
  }

  Future<List<Item>> getItem(String item_Name) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> items =
        await db.rawQuery("SELECT * FROM items where item_Name = '$item_Name'");
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

  Future<FinalOrder> getFinalOrderLastId() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> final_orders =
        await db.rawQuery("SELECT * FROM final_order order by order_Id DESC");
    List<FinalOrder> FinalOrderList = final_orders.isNotEmpty
        ? final_orders.map((c) => FinalOrder.fromMap((c))).toList()
        : [];
    return FinalOrderList[0];
  }

  Future<int> addFinalIndividualOrder(
      FinalIndividualOrder final_individual_order) async {
    Database db = await instance.database;
    return await db.insert(
        'final_individual_order', final_individual_order.toMap());
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
}
