import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Database/db_approveOrders.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import '../Extras/routes.dart';

class SearchFunctions extends StatefulWidget {
  const SearchFunctions({Key? key}) : super(key: key);

  @override
  _SearchFunctionsState createState() => _SearchFunctionsState();
}

class _SearchFunctionsState extends State<SearchFunctions> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isChanged = true;
  var itemList = MyDrawer.emp.role! == "Admin"
      ? [
          "Processing Orders",
          "Add Employee",
          "Pending Orders",
          "Fulfilled Orders",
          "Leave Request Form",
          "My Leave Request Summary",
          "Leave Requests",
          "Edit Profile",
          "View Employees",
          "Explore Attendance",
          "Add Item",
          "Analytic Report"
        ]
      : [
          "My Orders",
          "Edit Profile",
          "Salesperson Attendance",
          "Leave Request Form",
          "My Leave Request Summary",
        ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.white
                  : MyColors.scarlet,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Quick Search",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: MyScreen.getScreenHeight(context) * (10 / 1063.6),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(12)),
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.grey,
              ),
              child: TypeAheadField(
                suggestionsCallback: (pattern) => itemList.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase())),
                textFieldConfiguration: TextFieldConfiguration(
                    scrollPadding: const EdgeInsets.only(
                      bottom: 300,
                    ),
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        size: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.scarlet
                            : MyColors.white,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 13, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.richBlackFogra
                                  : MyColors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.richBlackFogra
                                  : MyColors.white)),
                    ),
                    style: TextStyle(
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.middleRed
                            : MyColors.scarlet,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (25 / 1063.6))),
                itemBuilder: (_, String item) => ListTile(
                  title: Text(item),
                ),
                onSuggestionSelected: (String val) {
                  _textEditingController.text = val;
                  Future.delayed(Duration(milliseconds: 500), () async {
                    if (val == "Processing Orders") {
                      var _pendingOrders = Database_ApproveOrders();
                      if (await _pendingOrders.getProcessingOrders(
                          MyDrawer.emp.id!, MyDrawer.emp.role!)) {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, MyRoutes.MyProcessingOrders);
                      }
                    } else if (val == "Add Employee") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MyRoutes.MySignUpEmail);
                    }
                  });
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No item found'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
