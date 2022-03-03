import 'package:project_v3/Database/db_Employee.dart';

import 'database_helper.dart';
import 'employee.dart';
import 'leave_request.dart';

class Database_leaveRequest {
  static List<LeaveRequest> leaveRequests = [];
  static List<Employee> empleave = [];
  static List<String> lastApprovedLeaveRequests = [];
  static List<int> totalApprovedLeaveRequests = [];
  static addRequest({
    required String reason,
    required String reason_desc,
    required String fromdate,
    required String todate,
    required int emp_id,
    required int days,
    required String status,
  }) async {
    await DatabaseHelper.instance.addRequest(LeaveRequest(
        reason: reason,
        reason_desc: reason_desc,
        fromdate: fromdate,
        todate: todate,
        days: days,
        emp_id: emp_id,
        status: status));
  }

  Future<bool> getAllRequest() async {
    leaveRequests = await DatabaseHelper.instance.getAllLeaveRequest();
    totalApprovedLeaveRequests = [];
    lastApprovedLeaveRequests = [];
    for (int i = 0; i < leaveRequests.length; i++) {
      empleave.add(await Database_signUp.getEmp(
          email: "", id: leaveRequests[i].emp_id!));
      lastApprovedLeaveRequests.add(await DatabaseHelper.instance
          .getLastLeaveRequest(leaveRequests[i].emp_id!));
      List<LeaveRequest> approvedLeaveRequest = await DatabaseHelper.instance
          .getTotalLeaveRequest(leaveRequests[i].emp_id!);
      int leaveDays = 0;

      for (int j = 0; j < approvedLeaveRequest.length; j++) {
        leaveDays = approvedLeaveRequest[j].days! + leaveDays;
      }
      print(
          leaveRequests[i].emp_id!.toString() + "#### " + leaveDays.toString());
      totalApprovedLeaveRequests.add(leaveDays);
    }
    return true;
  }

  Future<bool> ApproveLeaveRequest(key) async {
    leaveRequests[key].status = 'Accepted';
    DatabaseHelper.instance.updateLeaveRequest(leaveRequests[key]);
    if (await Database_leaveRequest().getAllRequest()) return true;
    return false;
  }

  Future<bool> CancelLeaveRequest(key) async {
    leaveRequests[key].status = 'Rejected';
    DatabaseHelper.instance.updateLeaveRequest(leaveRequests[key]);
    if (await Database_leaveRequest().getAllRequest()) return true;
    return false;
  }
}
