import 'database_helper.dart';
import 'leave_request.dart';

class Database_leaveRequest {
  List<LeaveRequest> leaveRequests = [];

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
    return true;
  }
}
