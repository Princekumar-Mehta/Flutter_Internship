import 'package:project_v3/Database/db_Customer_branch.dart';
import 'package:project_v3/Database/final_order.dart';

import 'customer_branch.dart';
import 'database_helper.dart';

class Database_ApproveOrders {
  static List<FinalOrder> pendingOrders = [];
  static List<CustomerBranch> shipping_Branches = [];
  Future<bool> getPendingOrders() async {
    pendingOrders = await DatabaseHelper.instance.getPendingOrders();
    for (int i = 0; i < pendingOrders.length; i++) {
      shipping_Branches.add(await Database_customerBranch()
          .get_customerBranch(pendingOrders[i].shipping_Branch_Code));
      print(shipping_Branches[i].branch_Name);
    }
    return true;
  }
}
