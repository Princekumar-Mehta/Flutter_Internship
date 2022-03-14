import 'database_helper.dart';
import 'final_individual_order.dart';
import 'item.dart';

class Database_Report {
  static List<Item> items = [];
  static List<int> sales_in_packet = [];
  Future<bool> getItemWiseReport() async {
    items = [];
    sales_in_packet = [];
    items = await DatabaseHelper.instance.getItems();
    for (int j = 0; j < items.length; j++) {
      List<FinalIndividualOrder> orders = await DatabaseHelper.instance
          .getFinalIndividualOrderByItemId(items[j].code!);
      int no_of_packet = 0;
      for (int i = 0; i < orders.length; i++) {
        no_of_packet = no_of_packet +
            int.parse(orders[i].packet.toString()) +
            (int.parse(orders[i].patti.toString()) * 3) +
            (int.parse(orders[i].box.toString()) * 15);
      }
      sales_in_packet.add(no_of_packet);
    }
    for (int i = 0; i < items.length; i++) {
      print(items[i].item_Name.toString() +
          " :: " +
          sales_in_packet[i].toString() +
          "\n");
    }
    return true;
  }
}
