class FinalOrder {
  String customer_Code;
  String billing_Branch_Code;
  String shipping_Branch_Code;
  String manufacturing_Branch_Code;
  int order_Id;
  int total;
  String order_by_date;
  String status;
  FinalOrder({
    required this.customer_Code,
    required this.billing_Branch_Code,
    required this.shipping_Branch_Code,
    required this.manufacturing_Branch_Code,
    required this.order_Id,
    required this.total,
    required this.order_by_date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer_Code': this.customer_Code,
      'billing_Branch_Code': this.billing_Branch_Code,
      'shipping_Branch_Code': this.shipping_Branch_Code,
      'manufacturing_Branch_Code': this.manufacturing_Branch_Code,
      'order_Id': this.order_Id,
      'total': this.total,
      'order_by_date': this.order_by_date,
      'status': this.status,
    };
  }

  factory FinalOrder.fromMap(Map<String, dynamic> map) {
    return FinalOrder(
      customer_Code: map['customer_Code'] as String,
      billing_Branch_Code: map['billing_Branch_Code'] as String,
      shipping_Branch_Code: map['shipping_Branch_Code'] as String,
      manufacturing_Branch_Code: map['manufacturing_Branch_Code'] as String,
      order_Id: map['order_Id'] as int,
      total: map['total'] as int,
      order_by_date: map['order_by_date'] as String,
      status: map['status'] as String,
    );
  }
}
