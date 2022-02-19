import 'package:project_v3/Extras/myTypeAhead.dart';

class Order {
  List<MyTypeAhead>? item_name;
  List<String>? packet;
  List<String>? patti;
  List<String>? box;
  List<String>? price;
  List<String>? total;
  List<String>? tax;
  int? counter;

  Order() {
    counter = 0;
    item_name = [];
    packet = [];
    patti = [];
    box = [];
    price = [];
    total = [];
    tax = [];
  }
  print_order() {
    List<Map<String, dynamic>> my_order = [];
    for (int i = 0; i < counter!; i++) {
      Map<String, dynamic> json = {
        'item_name': item_name![i],
        'packet': packet![i],
        'patti': patti![i],
        'box': box![i],
        'price': price![i],
        'total': total![i],
        'tax': tax![i],
      };
      my_order.add({
        'item_no': i,
        "order": json,
      });
    }
    print(my_order);
  }
}
