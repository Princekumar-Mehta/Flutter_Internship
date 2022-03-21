import 'database_helper.dart';
import 'employee.dart';
import 'final_individual_order.dart';
import 'final_order.dart';
import 'item.dart';

class Database_Report {
  static List<Item> items = [];
  static List<int> sales_in_packet = [];
  static List<int> sales_in_revenue = [];
  static List<Employee> salespersons = [];
  static List<int> sales_salesperson_wise = [];
  static List<int> hours_salesperson_wise = [];
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
    return true;
  }

  Future<bool> getItemWiseRevenueReport() async {
    items = [];
    sales_in_revenue = [];
    items = await DatabaseHelper.instance.getItems();
    print(items.length);
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
      sales_in_revenue.add(no_of_packet * items[j].price!);
    }
    return true;
  }

  Future<bool> getSalesperson_SalesReport() async {
    salespersons = [];
    sales_salesperson_wise = [];
    salespersons = await DatabaseHelper.instance.getSalespersons();
    for (int j = 0; j < salespersons.length; j++) {
      print(salespersons[j].name! + "\n");
      List<FinalOrder> orders = await DatabaseHelper.instance
          .getFinalOrderBySalespersonId(salespersons[j].id.toString());
      int sales = 0;
      for (int i = 0; i < orders.length; i++) {
        print(orders[i].total.toString() + "\n");
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

  Future<bool> getSalesperson_HoursReport() async {
    salespersons = [];
    hours_salesperson_wise = [];
    salespersons = await DatabaseHelper.instance.getSalespersons();
    for (int j = 0; j < salespersons.length; j++) {
      print(salespersons[j].name! + "\n");
      int hours = await DatabaseHelper.instance
          .getAvgAttendanceBySalespersonId(salespersons[j].id.toString());
      hours_salesperson_wise.add(hours);
    }
    return true;
  }
}
