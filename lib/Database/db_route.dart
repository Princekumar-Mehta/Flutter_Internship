import 'package:project_v3/Models/customer_branch.dart';
import 'package:project_v3/Models/route.dart';

import 'database_helper.dart';
import 'db_customer_branch.dart';

class Database_Route {
  static List<CustomerBranch> routeBranches = [];
  static List<CustomerBranch> allBranchesBySubArea = [];
  Future<bool> get_AllcustomerBranchesBySubArea(String sub_Area) async {
    allBranchesBySubArea = await DatabaseHelper.instance
        .getAllCustomerBranchesBysubArea(
            sub_Area); // 0 for bill type, 1 ship type
    return true;
  }

  addRoute({
    required int salesperson_Id,
    required List<String> days,
    required String route,
  }) async {
    for (int i = 0; i < days.length; i++) {
      print(days[i]);
      List<Route> current_routes =
          await getRoutesBySalespersonIdDay(salesperson_Id, days[i]);
      if (current_routes.isEmpty) {
        await DatabaseHelper.instance.addRoute(
            Route(salesperson_Id: salesperson_Id, day: days[i], route: route));
      } else {
        await DatabaseHelper.instance.updateRoute(
            Route(salesperson_Id: salesperson_Id, day: days[i], route: route));
      }
      current_routes = [];
    }
  }

  Future<bool> getRouteAllRoutesBySalespersonId(int salesperson_Id) async {
    List<Route> routes = await DatabaseHelper.instance
        .getAllRoutesBySalespersonId(salesperson_Id);
    for (int i = 0; i < routes.length; i++) {
      print(routes[i].toMap());
    }
    return true;
  }

  Future<List<Route>> getRoutesBySalespersonIdDay(
      int salesperson_Id, String day) async {
    List<Route> routes = await DatabaseHelper.instance
        .getRoutesBySalespersonIdDay(salesperson_Id, day);

    if (routes.isNotEmpty) {
      List<String> branch_Codes = (routes[0].route.split("-"));
      routeBranches = [];
      for (int i = 0; i < branch_Codes.length; i++) {
        routeBranches.add(await Database_customerBranch()
            .get_customerBranch(branch_Codes[i].trim()));
      }
    }
    return routes;
  }
}
