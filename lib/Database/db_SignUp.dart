import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Employee{
  final String? profile_pic;
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final String? status;
  Employee({this.profile_pic,this.id, this.name,this.email,this.password,this.role,this.status});

  factory Employee.fromMap(Map<String,dynamic> json) => new Employee(
      profile_pic: json['profile_pic'],
      id: json['id'],
      name:json['name'],
      email: json['email'],
      password:json['password'],
      role: json['role'],
      status:json['status']
  );
  Map<String,dynamic> toMap(){
    return{
      'profile_pic':profile_pic,
      'id':id,
      'name':name,
      'email':email,
      'password':password,
      'role':role,
      'status':status
    };
  }
}
class Database_signUp{
  static addEmp({
    required String name,required String profile_pic,
    required String email,required String password,
    required String role, required String status,
  }) async {
    await DatabaseHelper.instance.addEmp(
        Employee(profile_pic:profile_pic,name: name ,email: email ,password: password,role: role,status:status));
  }
  static print_emps() async {
    final users = await DatabaseHelper.instance.getEmployees();
    print(users);
    for(int i=0;i<users.length;i++)
      print(users[i].toMap());

  }
  static getEmp({required String email,required int id}) async{
    final emp = await DatabaseHelper.instance.getEmp(email: email,id:id);
    return emp;
  }
}
class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database>  get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'DIMS.db');
    return await openDatabase(
      path,
      version:1,
      onCreate : _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE employees(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT,
     email TEXT,
     password TEXT,
     role TEXT,
     status TEXT
     profile_pic TEXT
    )
    ''');
  }
  Future<List<Employee>> getEmployees() async{
    Database db = await instance.database;
    var emps = await db.query('employees');
    List<Employee> employeesList = emps.isNotEmpty
        ? emps.map((c)=>Employee.fromMap((c))).toList():[];
    return employeesList;
  }
  Future<Employee?> getEmp({required String email,required int id}) async{
    Database db = await instance.database;
    if(email!=''){
      var emp=await db.query('employees', where: 'email = ?',whereArgs: [email]);;
      List<Employee> empList = emp.isNotEmpty
          ? emp.map((c)=>Employee.fromMap((c))).toList():[];
      if(empList.isEmpty)
        return null;
      return empList[0];
    }
    else{
      var emp=await db.query('employees', where: 'id = ?',whereArgs: [id]);;
      List<Employee> empList = emp.isNotEmpty
          ? emp.map((c)=>Employee.fromMap((c))).toList():[];
      if(empList.isEmpty)
        return null;
      return empList[0];
    }
  }

  Future<int> addEmp(Employee emp) async {
    Database db = await instance.database;
    return await db.insert('employees', emp.toMap());
  }

}
