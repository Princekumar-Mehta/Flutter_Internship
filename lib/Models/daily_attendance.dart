class Daily_Attendance {
  int emp_id;
  String date;
  String hours;

  Daily_Attendance({
    required this.emp_id,
    required this.date,
    required this.hours,
  });

  Map<String, dynamic> toMap() {
    return {
      'emp_id': this.emp_id,
      'date': this.date,
      'hours': this.hours,
    };
  }

  factory Daily_Attendance.fromMap(Map<String, dynamic> map) {
    return Daily_Attendance(
      emp_id: map['emp_id'] as int,
      date: map['date'] as String,
      hours: map['hours'] as String,
    );
  }
}
