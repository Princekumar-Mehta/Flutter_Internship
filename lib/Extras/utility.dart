import 'package:project_2/Database/db_SignUp.dart';

class Utility {
  static Future<Employee> getEmployee(String email, int id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    if (email == '' && _numeric.hasMatch(id.toString())) {
      emp = await Database_signUp.getEmp(email: '', id: id);
    } else {
      emp = await Database_signUp.getEmp(email: email, id: 0);
    }
    return emp!;
  }

  static Future<bool> isExist(String email, int id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    if (email == '' && _numeric.hasMatch(id.toString())) {
      emp = await Database_signUp.getEmp(email: '', id: id);
    } else {
      emp = await Database_signUp.getEmp(email: email, id: 0);
    }
    print(emp);
    return !(emp == null);
  }
}
