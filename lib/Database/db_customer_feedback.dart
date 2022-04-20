import 'package:project_v3/Models/customer_branch.dart';
import 'package:project_v3/Models/customer_feedback.dart';

import 'database_helper.dart';
import 'db_customer_branch.dart';

class Database_Customer_Feedback {
  static List<Customer_Feedback> all_customer_feedbacks = [];
  static List<String> remaining_branches = [];
  static List<Customer_Feedback> customer_feedbacks = [];
  static List<CustomerBranch> customer_feedback_branches = [];
  static double avgRating = 0;
  static addCustomerFeedback({
    required salesperson_Code,
    required date,
    required month,
    required year,
    required branch_Code,
    required rating,
    required reason,
  }) async {
    await DatabaseHelper.instance.addCustomerFeedback(Customer_Feedback(
        salesperson_Code: salesperson_Code,
        date: date,
        month: month,
        year: year,
        branch_Code: branch_Code,
        rating: rating,
        reason: reason));
  }

  Future<bool> getRemainingBranchesBysubAreaCustomerFeedbacks(
      int salesperson_Code, int month, int year, String sub_Area) async {
    remaining_branches = [];
    List<CustomerBranch> allCustomerBranches =
        await DatabaseHelper.instance.getAllCustomerBranchesBysubArea(sub_Area);
    List<Customer_Feedback> existingCustomerFeedbacks = await DatabaseHelper
        .instance
        .getExistingBranchesCustomerFeedback(salesperson_Code, month, year);
    List<String> existingBranchCodes = [];
    for (int i = 0; i < existingCustomerFeedbacks.length; i++) {
      existingBranchCodes.add(existingCustomerFeedbacks[i].branch_Code);
    }
    allCustomerBranches.forEach((element) {
      if (!existingBranchCodes.contains(element.branch_Code)) {
        remaining_branches
            .add(element.branch_Code! + " : " + element.branch_Name!);
      }
    });
    return true;
  }

  Future<bool> getCustomerFeedbacksBySalespersonCode(
      int salesperson_Code) async {
    customer_feedbacks = [];
    customer_feedback_branches = [];
    avgRating = 0;
    customer_feedbacks = await DatabaseHelper.instance
        .getCustomerFeedbackBySalespersonCode(salesperson_Code);
    for (int i = 0; i < customer_feedbacks.length; i++) {
      customer_feedback_branches.add(await Database_customerBranch()
          .get_customerBranch(customer_feedbacks[i].branch_Code));
      avgRating += double.parse(customer_feedbacks[i].rating);
    }
    print(customer_feedback_branches.length);
    if (customer_feedbacks.isNotEmpty) {
      avgRating /= customer_feedbacks.length;
    }
    return true;
  }

  Future<bool> isCustomerFeedbackExist(
      int salesperson_Code, String branch_Code, int year, int month) async {
    List<Customer_Feedback> customerFeedback = await DatabaseHelper.instance
        .getCustomerFeedback(salesperson_Code, branch_Code, month, year);
    if (customerFeedback.isEmpty) {
      return false;
    }
    return true;
  }
}
