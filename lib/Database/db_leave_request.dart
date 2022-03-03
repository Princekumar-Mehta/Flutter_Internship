import 'package:project_v3/Database/db_Employee.dart';

import 'database_helper.dart';
import 'employee.dart';
import 'leave_request.dart';

class Database_leaveRequest {
  static List<LeaveRequest> leaveRequests = [];
  static List<Employee> empleave = [];
  static List<String> lastApprovedLeaveRequests = [];
  static addRequest({
    required String reason,
    required String reason_desc,
    required String fromdate,
    required String todate,
    required int emp_id,
    required String status,
  }) async {
    await DatabaseHelper.instance.addRequest(LeaveRequest(
        reason: reason,
        reason_desc: reason_desc,
        fromdate: fromdate,
        todate: todate,
        emp_id: emp_id,
        status: status));
  }

  Future<bool> getAllRequest() async {
    leaveRequests = await DatabaseHelper.instance.getAllLeaveRequest();
    for (int i = 0; i < leaveRequests.length; i++) {
      empleave.add(await Database_signUp.getEmp(
          email: "", id: leaveRequests[i].emp_id!));
      lastApprovedLeaveRequests.add(await DatabaseHelper.instance
          .getLastLeaveRequest(leaveRequests[i].emp_id!));
    }
    return true;
  }
}
