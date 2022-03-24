class LeaveRequest {
  int? request_Id;
  String? reason;
  String? reason_desc;
  String? fromdate;
  String? todate;
  int? days;
  int? emp_id;
  String? status;
  LeaveRequest(
      {this.reason,
      this.reason_desc,
      this.fromdate,
      this.todate,
      this.days,
      this.emp_id,
      this.status,
      this.request_Id});

  Map<String, dynamic> toMap() {
    return {
      'request_Id': this.request_Id,
      'reason': this.reason,
      'reason_desc': this.reason_desc,
      'fromdate': this.fromdate,
      'todate': this.todate,
      'days': this.days,
      'emp_id': this.emp_id,
      'status': this.status,
    };
  }

  factory LeaveRequest.fromMap(Map<String, dynamic> map) {
    return LeaveRequest(
      reason: map['reason'] as String,
      reason_desc: map['reason_desc'] as String,
      fromdate: map['fromdate'] as String,
      todate: map['todate'] as String,
      days: map['days'] as int,
      emp_id: map['emp_id'] as int,
      status: map['status'] as String,
      request_Id: map['request_Id'] as int,
    );
  }
}
