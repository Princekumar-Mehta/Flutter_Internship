import 'package:project_v3/Database/db_customer.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Database/db_final_individual_order.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Models/customer.dart';
import 'package:project_v3/Models/final_individual_order.dart';
import 'package:project_v3/Models/final_order.dart';

import '../Models/customer_branch.dart';
import 'database_helper.dart';
import 'db_stock.dart';

class Database_ApproveOrders {
  static List<FinalOrder> pendingOrders = [];
  static List<FinalOrder> processingOrders = [];
  static List<FinalOrder> fulfilledOrders = [];
  static List<CustomerBranch> shipping_Branches = [];
  static List<Customer> customers = [];
  Future<bool> getPendingOrders() async {
    pendingOrders = await DatabaseHelper.instance.getPendingOrders();
    shipping_Branches = [];
    customers = [];
    if (pendingOrders.length != 0) {
      for (int i = 0; i < pendingOrders.length; i++) {
        shipping_Branches.add(await Database_customerBranch()
            .get_customerBranch(pendingOrders[i].shipping_Branch_Code));
        customers.add(await Database_customer()
            .get_customer(pendingOrders[i].customer_Code));
      }
    }
    return true;
  }

  Future<bool> getFulfilledOrders() async {
    fulfilledOrders = await DatabaseHelper.instance.getFulfilledOrders();
    shipping_Branches = [];
    customers = [];
    if (fulfilledOrders.length != 0) {
      for (int i = 0; i < fulfilledOrders.length; i++) {
        shipping_Branches.add(await Database_customerBranch()
            .get_customerBranch(fulfilledOrders[i].shipping_Branch_Code));
        customers.add(await Database_customer()
            .get_customer(fulfilledOrders[i].customer_Code));
      }
    }
    print(fulfilledOrders.length.toString());
    return true;
  }

  Future<bool> getProcessingOrders(int emp_id, String emp_role) async {
    processingOrders =
        await DatabaseHelper.instance.getProcessingOrders(emp_id, emp_role);
    shipping_Branches = [];
    customers = [];
    for (int i = 0; i < processingOrders.length; i++) {
      shipping_Branches.add(await Database_customerBranch()
          .get_customerBranch(processingOrders[i].shipping_Branch_Code));
      customers.add(await Database_customer()
          .get_customer(processingOrders[i].customer_Code));
      // print(processingOrders[i].shipping_Branch_Code +
      //     " Path is :" +
      //     processingOrders[i].chequePhotoPath);
    }
    return true;
  }

  Future<bool> FulfilledOrder(key, path) async {
    processingOrders[key].status = "Fulfilled";
    DatabaseHelper.instance.updateOrder(processingOrders[key]);
    //print("in side fulfil order: " + path);
    DatabaseHelper.instance
        .updateOrderChequePhoto(processingOrders[key].order_Id, path);
    return true;
  }

  Future<bool> RejectOrder(key) async {
    processingOrders[key].status = 'Rejected';
    DatabaseHelper.instance.updateOrder(processingOrders[key]);
    if (MyDrawer.emp.role == "Salesperson") {
      List<FinalIndividualOrder> individualOrders =
          await Database_Final_Individual_Order()
              .getFinalIndividualOrdersByOrderId(
                  processingOrders[key].order_Id);
      for (int i = 0; i < individualOrders.length; i++) {
        Database_Stock.increaseStock(
            1,
            individualOrders[i].item_Code,
            individualOrders[i].packet,
            individualOrders[i].patti,
            individualOrders[i].box);
      }
    }
    return true;
  }

  Future<bool> ApproveFinalOrder(key) async {
    pendingOrders[key].status = 'Processing';
    DatabaseHelper.instance.updateOrder(pendingOrders[key]);
    List<FinalIndividualOrder> individualOrders =
        await Database_Final_Individual_Order()
            .getFinalIndividualOrdersByOrderId(pendingOrders[key].order_Id);
    for (int i = 0; i < individualOrders.length; i++) {
      Database_Stock.reduceStock(
          1,
          individualOrders[i].item_Code,
          individualOrders[i].packet,
          individualOrders[i].patti,
          individualOrders[i].box);
    }
    return true;
  }

  Future<bool> CancelFinalOrder(key) async {
    pendingOrders[key].status = 'Rejected';
    DatabaseHelper.instance.updateOrder(pendingOrders[key]);
    return true;
  }
}
