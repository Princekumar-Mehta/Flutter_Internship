import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Database/db_ApproveOrders.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import '../routes.dart';

class SearchFunctions extends StatefulWidget {
  const SearchFunctions({Key? key}) : super(key: key);

  @override
  _SearchFunctionsState createState() => _SearchFunctionsState();
}

class _SearchFunctionsState extends State<SearchFunctions> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isChanged = true;
  var itemList = ["Processing orders", "Add Employee"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                scrollPadding: EdgeInsets.only(bottom: 300),
                controller: _textEditingController,
                decoration: InputDecoration(
                  focusColor: isChanged ? MyColors.middleRed : MyColors.scarlet,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.pewterBlue)),
                ),
                style: TextStyle(
                    color: MyColors.middleRed,
                    fontSize:
                        MyScreen.getScreenHeight(context) * (25 / 1063.6))),
            suggestionsCallback: (pattern) => itemList.where(
                (item) => item.toLowerCase().startsWith(pattern.toLowerCase())),
            itemBuilder: (_, String item) => ListTile(
              title: Text(item),
            ),
            onSuggestionSelected: (String val) {
              _textEditingController.text = val;
              Future.delayed(Duration(milliseconds: 500), () async {
                if (val == "Processing orders") {
                  var _pendingOrders = Database_ApproveOrders();
                  if (await _pendingOrders.getProcessingOrders(
                      MyDrawer.emp.id!, MyDrawer.emp.role!)) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, MyRoutes.MyProcessingOrders);
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
        ],
      ),
    );
  }
}
