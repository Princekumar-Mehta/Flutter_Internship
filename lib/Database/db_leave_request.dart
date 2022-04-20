import 'package:project_v3/Database/db_employee.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/utility.dart';

import '../Models/employee.dart';
import '../Models/leave_request.dart';
import 'database_helper.dart';

class Database_leaveRequest {
  static List<LeaveRequest> leaveRequests = [];
  static List<Employee> empleave = [];
  static List<String> lastApprovedLeaveRequests = [];
  static List<int> totalApprovedLeaveRequests = [];

  static List<LeaveRequest> leaveRequestsForEmp = [];
  static int totalPendingLeaveRequestsForEmp = 0;
  static int totalApprovedLeaveRequestsForEmp = 0;
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
    empleave = [];
    print(leaveRequests.length.toString());
    for (int i = 0; i < leaveRequests.length; i++) {
      empleave.add(await Database_signUp.getEmp(
          email: "", id: leaveRequests[i].emp_id!));
      lastApprovedLeaveRequests.add(await DatabaseHelper.instance
          .getLastLeaveRequest(leaveRequests[i].emp_id!));
      List<LeaveRequest> approvedLeaveRequest = await DatabaseHelper.instance
          .getTotalAcceptedLeaveRequest(leaveRequests[i].emp_id!);
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

  Future<bool> getAllRequestForEmp(int emp_id) async {
    leaveRequestsForEmp =
        await DatabaseHelper.instance.getTotalLeaveRequest(emp_id);
    totalApprovedLeaveRequestsForEmp = 0;
    totalPendingLeaveRequestsForEmp = 0;
    for (int i = 0; i < leaveRequestsForEmp.length; i++) {
      List<LeaveRequest> approvedLeaveRequestForEmp = await DatabaseHelper
          .instance
          .getTotalAcceptedLeaveRequest(leaveRequestsForEmp[i].emp_id!);

      int pendingLeaveDaysForEmp = 0;
      for (int j = 0; j < leaveRequestsForEmp.length; j++) {
        if (leaveRequestsForEmp[j].status == 'Pending') {
          pendingLeaveDaysForEmp =
              leaveRequestsForEmp[j].days! + pendingLeaveDaysForEmp;
        }
      }
      totalPendingLeaveRequestsForEmp = (pendingLeaveDaysForEmp);

      int approvedLeaveDaysForEmp = 0;
      for (int j = 0; j < approvedLeaveRequestForEmp.length; j++) {
        approvedLeaveDaysForEmp =
            approvedLeaveRequestForEmp[j].days! + approvedLeaveDaysForEmp;
      }
      totalApprovedLeaveRequestsForEmp = (approvedLeaveDaysForEmp);
    }
    return true;
  }

  Future<bool> isLeaveRequestNotExist(
      int emp_Id, String fromDate, String toDate) async {
    bool broken = false;
    var existingLeaveRequest =
        await DatabaseHelper.instance.getTotalLeaveRequest(emp_Id);
    if (existingLeaveRequest.length == 0) {
      return true;
    }
    for (int j = 0; j < existingLeaveRequest.length; j++) {
      if (existingLeaveRequest[j].status != 'Rejected') {
        var oldFrom = Utility.formatDate(existingLeaveRequest[j].fromdate!);
        int oldFromYr = int.parse(oldFrom[0]);
        int oldFromMth = int.parse(oldFrom[1]);
        int oldFromDt = int.parse(oldFrom[2]);
        var oldTo = Utility.formatDate(existingLeaveRequest[j].todate!);
        int oldToYr = int.parse(oldTo[0]);
        int oldToMth = int.parse(oldTo[1]);
        int oldToDt = int.parse(oldTo[2]);
        //print(oldFromYr + " " + oldFromMth + " " + oldFromDt);
        //print(oldToYr + " " + oldToMth + " " + oldToDt);
        var newFrom = Utility.formatDate(fromDate);
        int newFromYr = int.parse(newFrom[0]);
        int newFromMth = int.parse(newFrom[1]);
        int newFromDt = int.parse(newFrom[2]);
        var newTo = Utility.formatDate(toDate);
        int newToYr = int.parse(newTo[0]);
        int newToMth = int.parse(newTo[1]);
        int newToDt = int.parse(newTo[2]);
        broken = false;
        if (Utility.compare(newFromDt, newFromMth, newFromYr, oldFromDt,
                    oldFromMth, oldFromYr) !=
                -1 &&
            Utility.compare(newFromDt, newFromMth, newFromYr, oldToDt, oldToMth,
                    oldToYr) !=
                1) {
          return false;
        }
        if (Utility.compare(newToDt, newToMth, newToYr, oldFromDt, oldFromMth,
                    oldFromYr) !=
                -1 &&
            Utility.compare(
                    newToDt, newToMth, newToYr, oldToDt, oldToMth, oldToYr) !=
                1) {
          return false;
        }
        if (Utility.compare(newFromDt, newFromMth, newFromYr, oldFromDt,
                    oldFromMth, oldFromYr) ==
                -1 &&
            Utility.compare(
                    newToDt, newToMth, newToYr, oldToDt, oldToMth, oldToYr) ==
                1) {
          return false;
        }
      }
    }
    return true;
  }

  Future<bool> ApproveLeaveRequest(key, message) async {
    leaveRequests[key].status = 'Accepted';
    DatabaseHelper.instance.updateLeaveRequest(leaveRequests[key]);
    print(Database_leaveRequest.empleave[key].email!);
    Send_Mail.send_mail(Database_leaveRequest.empleave[key].email!,
        "Leave Confirmed", message + "approved.");
    if (await Database_leaveRequest().getAllRequest()) return true;
    return false;
  }

  Future<bool> CancelLeaveRequest(key, message) async {
    leaveRequests[key].status = 'Rejected';
    DatabaseHelper.instance.updateLeaveRequest(leaveRequests[key]);
    print(Database_leaveRequest.empleave[key].email!);
    Send_Mail.send_mail(Database_leaveRequest.empleave[key].email!,
        "Leave Cancelled", message + "cancelled.");
    if (await Database_leaveRequest().getAllRequest()) return true;
    return false;
  }
}
