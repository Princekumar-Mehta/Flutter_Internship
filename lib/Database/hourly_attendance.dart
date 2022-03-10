class Hourly_Attendance {
  int emp_id;
  String date;
  String time;
  String latitude;
  String longitude;

  Hourly_Attendance({
    required this.emp_id,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'emp_id': this.emp_id,
      'date': this.date,
      'time': this.time,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory Hourly_Attendance.fromMap(Map<String, dynamic> map) {
    return Hourly_Attendance(
      emp_id: map['emp_id'] as int,
      date: map['date'] as String,
      time: map['time'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }
}
