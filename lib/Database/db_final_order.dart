import 'package:project_v3/Database/final_order.dart';

import 'database_helper.dart';

class Database_Final_Order {
  static addFinalOrder({
    required String customer_Code,
    required String billing_Branch_Code,
    required String shipping_Branch_Code,
    required String manufacturing_Branch_Code,
    required int order_Id,
    required int total,
    required String order_by_date,
  }) async {
    await DatabaseHelper.instance.addFinalOrder(FinalOrder(
        customer_Code: customer_Code,
        billing_Branch_Code: billing_Branch_Code,
        shipping_Branch_Code: shipping_Branch_Code,
        manufacturing_Branch_Code: manufacturing_Branch_Code,
        order_Id: order_Id,
        total: total,
        order_by_date: order_by_date,
        status: "Pending_Admin"));
  }

  void getFinalOrders() async {
    final finalOrders = await DatabaseHelper.instance.getFinalOrder();
    for (int i = 0; i < finalOrders.length; i++) {
      print(finalOrders[i].toMap());
      print("\n");
    }
  }

  Future<int> getFinalOrdersLastId() async {
    final finalOrders = await DatabaseHelper.instance.getFinalOrderLastId();
    if (finalOrders == null)
      return 1;
    else
      return finalOrders.order_Id;
  }
}
