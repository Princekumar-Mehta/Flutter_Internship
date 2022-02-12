import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Extras/utility.dart';

import 'myColors.dart';
import 'myScreen.dart';

class MyTypeAhead extends StatefulWidget {
  List<String> itemList;
  String message;
  MyTypeAhead({required this.itemList, required this.message});
  @override
  _MyTypeAheadState createState() => _MyTypeAheadState();
  var isEmpty;
}

class _MyTypeAheadState extends State<MyTypeAhead> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.isEmpty = () {
      if (this._textEditingController.text.isEmpty) {
        Utility.showMessage(context, widget.message);
        return true;
      } else {
        return false;
      }
    };
    return Container(
      width: MyScreen.getScreenWidth(context) * (228 / 294),
      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
      color: MyColors.richBlackFogra,
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: _textEditingController,
            decoration: InputDecoration(
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
          print(val);
        },
        getImmediateSuggestions: true,
        hideOnEmpty: false,
        noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No item found'),
        ),
      ),
    );
  }
}
