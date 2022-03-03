class LeaveRequest {
  String? reason;
  String? reason_desc;
  String? fromdate;
  String? todate;
  int? emp_id;
  String? status;
  LeaveRequest(
      {this.reason,
      this.reason_desc,
      this.fromdate,
      this.todate,
      this.emp_id,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      'reason': this.reason,
      'reason_desc': this.reason_desc,
      'fromdate': this.fromdate,
      'todate': this.todate,
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
      emp_id: map['emp_id'] as int,
      status: map['status'] as String,
    );
  }
}
