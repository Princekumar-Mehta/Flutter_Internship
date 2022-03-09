import 'package:project_v3/Database/customer.dart';
import 'package:project_v3/Database/db_Customer.dart';
import 'package:project_v3/Database/db_Customer_branch.dart';
import 'package:project_v3/Database/final_order.dart';

import 'customer_branch.dart';
import 'database_helper.dart';

class Database_ApproveOrders {
  static List<FinalOrder> pendingOrders = [];
  static List<FinalOrder> processingOrders = [];
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
    }
    return true;
  }

  Future<bool> FulfilledOrder(key) async {
    processingOrders[key].status = 'Fulfilled';
    DatabaseHelper.instance.updateOrder(processingOrders[key]);
    return true;
  }

  Future<bool> RejectOrder(key) async {
    processingOrders[key].status = 'Rejected';
    DatabaseHelper.instance.updateOrder(processingOrders[key]);
    return true;
  }

  Future<bool> ApproveFinalOrder(key) async {
    pendingOrders[key].status = 'Processing';
    DatabaseHelper.instance.updateOrder(pendingOrders[key]);
    return true;
  }

  Future<bool> CancelFinalOrder(key) async {
    pendingOrders[key].status = 'Rejected';
    DatabaseHelper.instance.updateOrder(pendingOrders[key]);
    return true;
  }
}
