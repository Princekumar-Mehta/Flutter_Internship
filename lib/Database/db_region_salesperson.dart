import 'package:project_v3/Models/region_salesperson.dart';

import 'database_helper.dart';

class Database_Region_Salesperson {
  static addRegionSalesperson({
    required String sub_Area,
    required String area,
    required int emp_Id,
  }) async {
    await DatabaseHelper.instance.addRegionSalesperson(
        Region_Salesperson(sub_Area: sub_Area, area: area, emp_Id: emp_Id));
  }

  Future<bool> isExistRegionSalesperson(int emp_Id) async {
    List<Region_Salesperson> region_salesperson =
        await DatabaseHelper.instance.getRegionsByEmpId(emp_Id);
    return region_salesperson.isNotEmpty;
  }

  updateRegionSalesperson(Region_Salesperson region_salesperson) async {
    await DatabaseHelper.instance.updateRegionSalesperson(region_salesperson);
  }

  Future<Region_Salesperson> getRegionSalesperson(int emp_Id) async {
    List<Region_Salesperson> region_salesperson =
        await DatabaseHelper.instance.getRegionsByEmpId(emp_Id);
    return region_salesperson[0];
  }
}
