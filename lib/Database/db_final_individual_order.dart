import 'package:project_v3/Models/final_individual_order.dart';

import 'database_helper.dart';

class Database_Final_Individual_Order {
  static addFinalIndividualOrder({
    required int order_Id,
    required int packet,
    required int patti,
    required int box,
    required String item_Code,
  }) async {
    await DatabaseHelper.instance.addFinalIndividualOrder(FinalIndividualOrder(
        order_Id: order_Id,
        packet: packet,
        patti: patti,
        box: box,
        item_Code: item_Code));
  }

  void getFinalIndividualOrders() async {
    final finalIndividualOrders =
        await DatabaseHelper.instance.getFinalIndividualOrder();
    for (int i = 0; i < finalIndividualOrders.length; i++) {
      print(finalIndividualOrders[i].toMap());
      print("\n");
    }
  }
}
