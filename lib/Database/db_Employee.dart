import 'database_helper.dart';
import 'employee.dart';

class Database_signUp {
  static List<Employee> emps = [];
  static Employee manager = Employee();
  static addEmp({
    required String name,
    required String profile_pic,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String managerid,
    required String status,
    required int darkTheme,
  }) async {
    await DatabaseHelper.instance.addEmp(Employee(
        profile_pic: profile_pic,
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
        managerid: managerid,
        status: status,
        darkTheme: darkTheme));
  }

  static print_emps() async {
    final users = await DatabaseHelper.instance.getEmployees();
    // print(users);
    // for (int i = 0; i < users.length; i++) print(users[i].toMap());
  }

  static getEmp({required String email, required int id}) async {
    final emp = await DatabaseHelper.instance.getEmp(email: email, id: id);
    if (emp != null) {
      manager = (await DatabaseHelper.instance
          .getEmp(email: "", id: int.parse(emp.managerid!)))!;
    }
    return emp;
  }

  Future<bool> getAllEmp() async {
    emps = (await DatabaseHelper.instance.getAllEmp())!;
    return true;
  }

  Future<bool> updateEmp(Employee emp) async {
    await DatabaseHelper.instance.update(emp);
    if (await Database_signUp().getAllEmp()) return true;
    return false;
  }
}
