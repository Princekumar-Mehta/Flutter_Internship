import 'database_helper.dart';
import 'employee.dart';

class Database_signUp {
  static addEmp({
    required String name,
    required String profile_pic,
    required String email,
    required String password,
    required String role,
    required String status,
  }) async {
    await DatabaseHelper.instance.addEmp(Employee(
        profile_pic: profile_pic,
        name: name,
        email: email,
        password: password,
        role: role,
        status: status));
  }

  static print_emps() async {
    final users = await DatabaseHelper.instance.getEmployees();
    print(users);
    for (int i = 0; i < users.length; i++) print(users[i].toMap());
  }

  static getEmp({required String email, required int id}) async {
    final emp = await DatabaseHelper.instance.getEmp(email: email, id: id);
    return emp;
  }

  static updateEmp(Employee emp) async {
    await DatabaseHelper.instance.update(Employee(
        profile_pic: emp.profile_pic,
        id: emp.id,
        name: emp.name,
        email: emp.email,
        password: emp.password,
        role: emp.role,
        status: emp.status));
  }
}
