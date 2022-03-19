import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Extras/utility.dart';

import 'myColors.dart';
import 'myScreen.dart';
import 'mydrawer.dart';

class MyTypeAhead extends StatefulWidget {
  List<String> itemList;
  String message;
  bool isEnabled;
  MyTypeAhead({
    required this.itemList,
    required this.message,
    required this.isEnabled,
  });
  @override
  _MyTypeAheadState createState() => _MyTypeAheadState();
  var isEmpty;
  var getValue;
  var setValue;
}

class _MyTypeAheadState extends State<MyTypeAhead> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isChanged = true;
  @override
  Widget build(BuildContext context) {
    widget.isEmpty = () {
      if (_textEditingController.text.isEmpty) {
        Utility.showMessage(context, widget.message);
        return true;
      } else {
        return false;
      }
    };
    widget.getValue = () {
      return _textEditingController.text.toString();
    };
    widget.setValue = (String newValue) {
      _textEditingController.text = newValue;
    };
    return Container(
      width: MyScreen.getScreenWidth(context) * (228 / 294),
      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
      color: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            scrollPadding: EdgeInsets.only(bottom: 300),
            enabled: widget.isEnabled,
            controller: _textEditingController,
            decoration: InputDecoration(
              focusColor: isChanged ? MyColors.middleRed : MyColors.scarlet,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.pewterBlue)),
            ),
            style: TextStyle(
                color: MyColors.middleRed,
                fontSize: MyScreen.getScreenHeight(context) * (25 / 1063.6))),
        suggestionsCallback: (pattern) => widget.itemList.where(
            (item) => item.toLowerCase().startsWith(pattern.toLowerCase())),
        itemBuilder: (_, String item) => ListTile(
          title: Text(item),
        ),
        onSuggestionSelected: (String val) {
          _textEditingController.text = val;
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {});
          });
        },
        getImmediateSuggestions: true,
        hideOnEmpty: false,
        noItemsFoundBuilder: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No item found'),
        ),
      ),
    );
  }
}
