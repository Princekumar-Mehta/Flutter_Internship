import 'package:project_v3/Models/hourly_attendance.dart';

import '../Models/hourly_attendance.dart';
import 'database_helper.dart';

class Database_Hourly_Attendance {
  static List<Hourly_Attendance> hourly_attendance = [];
  static addHourlyAttendance({
    required int emp_id,
    required String date,
    required String time,
    required String latitude,
    required String longitude,
  }) async {
    await DatabaseHelper.instance.addHourlyAttendance(Hourly_Attendance(
        emp_id: emp_id,
        date: date,
        time: time,
        latitude: latitude,
        longitude: longitude));
  }

  Future<bool> getHourlyAttendance(int emp_id, String date) async {
    hourly_attendance =
        await DatabaseHelper.instance.getHourlyAttendance(emp_id, date);
    //print(hourly_attendance);
    return true;
  }
}
