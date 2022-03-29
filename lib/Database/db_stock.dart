import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Models/stock.dart';

import 'database_helper.dart';

class Database_Stock {
  static addStock({
    required int emp_Id,
    required String role,
    required String item_Id,
    required int packet,
    required int patti,
    required int box,
    required int minimum_Packet,
    required int order_Packet,
    required int last_Order_In_Packet,
    required String last_Order_Date,
  }) async {
    await DatabaseHelper.instance.addStock(Stock(
      emp_Id: emp_Id,
      role: role,
      item_Id: item_Id,
      packet: packet,
      patti: patti,
      box: box,
      minimum_Packet: minimum_Packet,
      order_Packet: order_Packet,
      last_Order_In_Packet: last_Order_In_Packet,
      last_Order_Date: last_Order_Date,
    ));
  }

  static addStockForAllItem(int emp_Id, String role) async {
    if (await Database_Item().get_Items()) {
      for (int i = 0; i < Database_Item.items.length; i++) {
        addStock(
            emp_Id: emp_Id,
            role: role,
            item_Id: Database_Item.items[i].code!,
            packet: 0,
            patti: 0,
            box: 0,
            minimum_Packet: 0,
            order_Packet: role == "Dealer" ? 500 : 1000,
            last_Order_In_Packet: 0,
            last_Order_Date: "00-00-0000");
      }
      List<Stock> stocks = await DatabaseHelper.instance.getStockForAllEmp();
      for (int i = 0; i < stocks.length; i++) {
        print(stocks[i].toMap());
      }
    }
  }
}
