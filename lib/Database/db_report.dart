import 'database_helper.dart';
import 'employee.dart';
import 'final_individual_order.dart';
import 'final_order.dart';
import 'item.dart';

class Database_Report {
  static List<Item> items = [];
  static List<int> sales_in_packet = [];
  static List<Employee> salespersons = [];
  static List<int> sales_salesperson_wise = [];
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

  Future<bool> getSalesperson_SalesReport() async {
    salespersons = [];
    sales_salesperson_wise = [];
    salespersons = await DatabaseHelper.instance.getSalespersons();
    for (int j = 0; j < salespersons.length; j++) {
      List<FinalOrder> orders = await DatabaseHelper.instance
          .getFinalOrderByItemId(salespersons[j].id.toString());
      int sales = 0;
      for (int i = 0; i < orders.length; i++) {
        sales = sales + orders[i].total;
      }
      sales_salesperson_wise.add(sales);
    }
    for (int i = 0; i < salespersons.length; i++) {
      print(salespersons[i].role.toString() +
          " :: " +
          sales_salesperson_wise[i].toString() +
          "\n");
    }
    return true;
  }
}
