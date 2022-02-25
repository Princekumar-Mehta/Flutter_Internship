class FinalIndividualOrder {
  int order_Id;
  int packet;
  int patti;
  int box;
  String item_Code;

  FinalIndividualOrder({
    required this.order_Id,
    required this.packet,
    required this.patti,
    required this.box,
    required this.item_Code,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_Id': this.order_Id,
      'packet': this.packet,
      'patti': this.patti,
      'box': this.box,
      'item_Code': this.item_Code,
    };
  }

  factory FinalIndividualOrder.fromMap(Map<String, dynamic> map) {
    return FinalIndividualOrder(
      order_Id: map['order_Id'] as int,
      packet: map['packet'] as int,
      patti: map['patti'] as int,
      box: map['box'] as int,
      item_Code: map['item_Code'] as String,
    );
  }
}
