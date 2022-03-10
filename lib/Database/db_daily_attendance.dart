import 'daily_attendance.dart';
import 'database_helper.dart';

class Database_Daily_Attendance {
  static List<Daily_Attendance> daily_emp_attendance = [];
  updateDailyAttendance({
    required int emp_id,
    required String date,
    required String hours,
  }) async {
    if (await getEmpDailyAttendance(emp_id, date)) {
      if (daily_emp_attendance.length == 0) {
        await DatabaseHelper.instance.addDailyAttendance(
            Daily_Attendance(emp_id: emp_id, date: date, hours: hours));
      } else {
        await DatabaseHelper.instance.updateDailyAttendance(
            Daily_Attendance(emp_id: emp_id, date: date, hours: hours));
      }
    }
  }

  Future<bool> getEmpDailyAttendance(int emp_id, String date) async {
    daily_emp_attendance =
        await DatabaseHelper.instance.getDailyAttendance(emp_id, date);
    print(daily_emp_attendance);
    return true;
  }
}
