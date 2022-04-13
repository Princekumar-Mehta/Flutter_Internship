class Scheme {
  String item_Code;
  String discount;
  String fromdate;
  String todate;
  Scheme({
    required this.item_Code,
    required this.discount,
    required this.fromdate,
    required this.todate,
  });
  Map<String, dynamic> toMap() {
    return {
      'item_Code': this.item_Code,
      'discount': this.discount,
      'fromdate': this.fromdate,
      'todate': this.todate,
    };
  }

  factory Scheme.fromMap(Map<String, dynamic> map) {
    return Scheme(
      item_Code: map['item_Code'] as String,
      discount: map['discount'] as String,
      fromdate: map['fromdate'] as String,
      todate: map['todate'] as String,
    );
  }
}
