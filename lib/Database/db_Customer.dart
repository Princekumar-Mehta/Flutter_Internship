import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Customer {
  String? code;
  String? party_Name;
  String? nick_Name;
  String? doc_Type;
  String? grp;
  String? sub_Group;
  int? map_Cn;
  int? branch_Cn;
  String? email;
  String? phone_1;
  String? phone_2;
  int? crd_Day;
  int? crd_Amt;
  int? gL_Acc;
  String? active;
  Customer(
      {this.code,
      this.party_Name,
      this.nick_Name,
      this.doc_Type,
      this.grp,
      this.sub_Group,
      this.map_Cn,
      this.branch_Cn,
      this.email,
      this.phone_1,
      this.phone_2,
      this.crd_Amt,
      this.crd_Day,
      this.gL_Acc,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'party_Name': this.party_Name,
      'nick_Name': this.nick_Name,
      'doc_Type': this.doc_Type,
      'grp': this.grp,
      'sub_Group': this.sub_Group,
      'map_Cn': this.map_Cn,
      'branch_Cn': this.branch_Cn,
      'email': this.email,
      'phone_1': this.phone_1,
      'phone_2': this.phone_2,
      'crd_Day': this.crd_Day,
      'crd_Amt': this.crd_Amt,
      'gL_Acc': this.gL_Acc,
      'active': this.active,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      code: map['code'] as String,
      party_Name: map['party_Name'] as String,
      nick_Name: map['nick_Name'] as String,
      doc_Type: map['doc_Type'] as String,
      grp: map['grp'] as String,
      sub_Group: map['sub_Group'] as String,
      map_Cn: map['map_Cn'] as int,
      branch_Cn: map['branch_Cn'] as int,
      email: map['email'] as String,
      phone_1: map['phone_1'] as String,
      phone_2: map['phone_2'] as String,
      crd_Day: map['crd_Day'] as int,
      crd_Amt: map['crd_Amt'] as int,
      gL_Acc: map['gL_Acc'] as int,
      active: map['active'] as String,
    );
  }
}

class Database_customer {
  static addEmp(Map<String, dynamic> customer) async {
    await DatabaseHelper.instance.addEmp(Customer.fromMap(customer));
  }

  static print_customer() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    print(customers);
    for (int i = 0; i < customers.length; i++) print(customers[i].toMap());
  }

  static List<String> codes = [];
  get_customerIds() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    customers.forEach((element) {
      codes.add(element.code!);
    });
    print(codes.runtimeType);
  }

  /*static getCustomer({required String email, required int id}) async {
    final emp = await DatabaseHelper.instance.getCustomer(email: email, id: id);
    return emp;
  }*/

  static runTempQuery() {
    DatabaseHelper.instance.Temp_Query();
  }
}

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
    CREATE TABLE customers(
     code TEXT,
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
  }

  Future<void> Temp_Query() async {
    Database db = await instance.database;
  }

  Future<int> addEmp(Customer customer) async {
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

  Future<List<Map<String, Object?>>> getCustomerCodes() async {
    Database db = await instance.database;

    var customerCodes = await db.rawQuery('SELECT code FROM customers');
    return (customerCodes);
  }

  Future<Customer?> getEmp({required String email, required int id}) async {
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
}
