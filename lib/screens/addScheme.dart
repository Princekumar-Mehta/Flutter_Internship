import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Extras/myColors.dart';

class AddScheme extends StatefulWidget {
  List<String> itemList;
  AddScheme({required this.itemList});
  @override
  _AddSchemeState createState() => _AddSchemeState(itemList: itemList);
}

class _AddSchemeState extends State<AddScheme> {
  List<String> itemList;
  _AddSchemeState({required this.itemList});
  List<String> selectedItems = [];
  TextEditingController _textEditingController = TextEditingController();
  addItem(val) {
    int index = itemList.indexWhere((element) => element == val);
    itemList.removeAt(index);
    selectedItems.add(val);
  }

  removeItem(val) {
    int index = selectedItems.indexWhere((element) => element == val);
    selectedItems.removeAt(index);
    itemList.add(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Scheme"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    scrollPadding: EdgeInsets.only(bottom: 300),
                    enabled: true,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      focusColor: true ? MyColors.middleRed : MyColors.scarlet,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.pewterBlue)),
                    ),
                    style: TextStyle(color: MyColors.middleRed, fontSize: 14)),
                suggestionsCallback: (pattern) => itemList.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase())),
                itemBuilder: (_, String item) => ListTile(
                  title: Text(item),
                ),
                onSuggestionSelected: (String val) {
                  _textEditingController.text = "";
                  addItem(val);
                  setState(() {});
                  print(val);
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No item found'),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: _row(index),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key) {
    return Column(children: [
      InkWell(
        onLongPress: () {
          removeItem(selectedItems[key]);
          setState(() {});
        },
        child: Text(selectedItems[key]),
      ),
    ]);
  }
}
