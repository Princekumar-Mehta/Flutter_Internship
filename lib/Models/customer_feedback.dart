class Customer_Feedback {
  int salesperson_Code;
  String date;
  int month;
  int year;
  String branch_Code;
  String rating;
  String reason;

  Customer_Feedback({
    required this.salesperson_Code,
    required this.date,
    required this.month,
    required this.year,
    required this.branch_Code,
    required this.rating,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'salesperson_Code': this.salesperson_Code,
      'date': this.date,
      'month': this.month,
      'year': this.year,
      'branch_Code': this.branch_Code,
      'rating': this.rating,
      'reason': this.reason,
    };
  }

  factory Customer_Feedback.fromMap(Map<String, dynamic> map) {
    return Customer_Feedback(
      salesperson_Code: map['salesperson_Code'] as int,
      date: map['date'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      branch_Code: map['branch_Code'] as String,
      rating: map['rating'] as String,
      reason: map['reason'] as String,
    );
  }
}
