import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/item.dart';
import 'package:project_v3/Models/scheme.dart';

import 'database_helper.dart';
import 'db_item.dart';

class Database_Scheme {
  List<Scheme> all_schemes = [];
  static List<Scheme> current_schemes = [];
  static List<Item> items = [];
  static List<double> discounts = [];
  addScheme(
    String item_Code,
    String discount,
    String fromdate,
    String todate,
  ) async {
    await DatabaseHelper.instance.addScheme(Scheme(
        item_Code: item_Code,
        discount: discount,
        fromdate: fromdate,
        todate: todate));
  }

  getSchemes() async {
    all_schemes = await DatabaseHelper.instance.getAllSchemes();
    for (int i = 0; i < all_schemes.length; i++) {
      print(all_schemes[i].toMap());
    }
    print(all_schemes.length);
  }

  Future<bool> isSchemeNotExist(
      String item_Code, String fromDate, String toDate) async {
    await getSchemes();
    if (all_schemes.length == 0) {
      return true;
    }
    discounts = [];
    for (int j = 0; j < all_schemes.length; j++) {
      if (all_schemes[j].item_Code == item_Code) {
        var oldFrom = Utility.formatDate(all_schemes[j].fromdate);
        int oldFromYr = int.parse(oldFrom[0]);
        int oldFromMth = int.parse(oldFrom[1]);
        int oldFromDt = int.parse(oldFrom[2]);
        var oldTo = Utility.formatDate(all_schemes[j].todate);
        int oldToYr = int.parse(oldTo[0]);
        int oldToMth = int.parse(oldTo[1]);
        int oldToDt = int.parse(oldTo[2]);
        //print(oldFromYr + " " + oldFromMth + " " + oldFromDt);
        //print(oldToYr + " " + oldToMth + " " + oldToDt);
        var newFrom = Utility.formatDate(fromDate);
        int newFromYr = int.parse(newFrom[0]);
        int newFromMth = int.parse(newFrom[1]);
        int newFromDt = int.parse(newFrom[2]);
        var newTo = Utility.formatDate(toDate);
        int newToYr = int.parse(newTo[0]);
        int newToMth = int.parse(newTo[1]);
        int newToDt = int.parse(newTo[2]);
        if (Utility.compare(newFromDt, newFromMth, newFromYr, oldFromDt,
                    oldFromMth, oldFromYr) !=
                -1 &&
            Utility.compare(newFromDt, newFromMth, newFromYr, oldToDt, oldToMth,
                    oldToYr) !=
                1) {
          discounts.add(0.0);
          return false;
        }
        if (Utility.compare(newToDt, newToMth, newToYr, oldFromDt, oldFromMth,
                    oldFromYr) !=
                -1 &&
            Utility.compare(
                    newToDt, newToMth, newToYr, oldToDt, oldToMth, oldToYr) !=
                1) {
          discounts.add(0.0);
          return false;
        }
        if (Utility.compare(newFromDt, newFromMth, newFromYr, oldFromDt,
                    oldFromMth, oldFromYr) ==
                -1 &&
            Utility.compare(
                    newToDt, newToMth, newToYr, oldToDt, oldToMth, oldToYr) ==
                1) {
          discounts.add(0.0);
          return false;
        }
      }
      discounts.add(double.parse(all_schemes[j].discount.toString()));
    }

    return true;
  }

  Future<bool> currentSchemes() async {
    await getSchemes();
    current_schemes = [];
    items = [];
    for (int j = 0; j < all_schemes.length; j++) {
      // compare to see if today's date and to date difference is -1 or 0
      var todayDate =
          Utility.formatDate(DateTime.now().toString().split(" ")[0]);
      int todayYr = int.parse(todayDate[0]);
      int todayMth = int.parse(todayDate[1]);
      int todayDt = int.parse(todayDate[2]);
      var oldTo = Utility.formatDate(all_schemes[j].todate);
      int oldToYr = int.parse(oldTo[0]);
      int oldToMth = int.parse(oldTo[1]);
      int oldToDt = int.parse(oldTo[2]);
      if (Utility.compare(
              todayDt, todayMth, todayYr, oldToDt, oldToMth, oldToYr) !=
          1) {
        items.add(
            await Database_Item().get_ItemByItemId(all_schemes[j].item_Code));
        current_schemes.add(all_schemes[j]);
      }
    }
    print(current_schemes.length);
    return true;
  }

  Future<bool> deleteScheme(Scheme oldScheme) async {
    print(oldScheme.toMap());
    await DatabaseHelper.instance.deleteScheme(oldScheme);
    return true;
  }

  updateScheme(Scheme oldScheme, Scheme newScheme) async {
    await DatabaseHelper.instance.deleteScheme(oldScheme);
    if (await isSchemeNotExist(
        newScheme.item_Code, newScheme.fromdate, newScheme.todate)) {
      addScheme(newScheme.item_Code, newScheme.discount, newScheme.fromdate,
          newScheme.todate);
      return true;
    } else {
      addScheme(oldScheme.item_Code, oldScheme.discount, oldScheme.fromdate,
          oldScheme.todate);
      return false;
    }
  }
}
