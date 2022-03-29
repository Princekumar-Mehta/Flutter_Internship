class Stock {
  int emp_Id;

  /// dealer or distributer
  String role;
  String item_Id;
  int packet;
  int patti;
  int box;
  int minimum_Packet;
  int order_Packet;
  int last_Order_In_Packet;
  String last_Order_Date;

  Stock({
    required this.emp_Id,
    required this.role,
    required this.item_Id,
    required this.packet,
    required this.patti,
    required this.box,
    required this.minimum_Packet,
    required this.order_Packet,
    required this.last_Order_In_Packet,
    required this.last_Order_Date,
  });

  Map<String, dynamic> toMap() {
    return {
      'emp_Id': this.emp_Id,
      'role': this.role,
      'item_Id': this.item_Id,
      'packet': this.packet,
      'patti': this.patti,
      'box': this.box,
      'minimum_Packet': this.minimum_Packet,
      'order_Packet': this.order_Packet,
      'last_Order_In_Packet': this.last_Order_In_Packet,
      'last_Order_Date': this.last_Order_Date,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      emp_Id: map['emp_Id'] as int,
      role: map['role'] as String,
      item_Id: map['item_Id'] as String,
      packet: map['packet'] as int,
      patti: map['patti'] as int,
      box: map['box'] as int,
      minimum_Packet: map['minimum_Packet'] as int,
      order_Packet: map['order_Packet'] as int,
      last_Order_In_Packet: map['last_Order_In_Packet'] as int,
      last_Order_Date: map['last_Order_Date'] as String,
    );
  }
}
