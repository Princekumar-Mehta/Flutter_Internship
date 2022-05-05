import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/size_config.dart';
import 'package:project_v3/screens/setSchemeDetails.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.white
                  : MyColors.scarlet,
              size: 3.5 * SizeConfig.heightMultiplier),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: 1 * SizeConfig.widthMultiplier,
          ),
        ),
        title: Text("Select Items",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: 2.4 * SizeConfig.textMultiplier)),
        centerTitle: true,
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: Column(
        children: [
          SizedBox(
            height: 2.35 * SizeConfig.heightMultiplier,
          ),
          Container(
            width: 93.9 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(1.5 * SizeConfig.heightMultiplier)),
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
            ),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  scrollPadding: const EdgeInsets.only(
                    bottom: 300,
                  ),
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: Icon(
                      Icons.search,
                      size: 2.8 * SizeConfig.heightMultiplier,
                      color: MyDrawer.emp.darkTheme == 1
                          ? MyColors.scarlet
                          : MyColors.white,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(
                        2.25 * SizeConfig.widthMultiplier,
                        1.5 * SizeConfig.heightMultiplier,
                        0,
                        0),
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
                    fontSize: 2.35 * SizeConfig.textMultiplier,
                  )),
              suggestionsCallback: (pattern) => itemList.where(
                  (item) => item.toLowerCase().contains(pattern.toLowerCase())),
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
              noItemsFoundBuilder: (context) => Padding(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                child: Text('No item found'),
              ),
            ),
          ),
          SizedBox(
            height: 2.35 * SizeConfig.heightMultiplier,
          ),
          Container(
            height: .18 * SizeConfig.heightMultiplier,
            width: 93.9 * SizeConfig.widthMultiplier,
            color: MyDrawer.emp.darkTheme == 1
                ? MyColors.pewterBlue
                : MyColors.black,
          ),
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier,
          ),
          Text(
            "Long press on Items to remove from List",
            style: TextStyle(
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.pewterBlue
                  : MyColors.black,
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          SizedBox(
            height: 2.35 * SizeConfig.heightMultiplier,
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: _row(index),
                  );
                }),
          ),
          // Button
          SizedBox(height: 7.5 * SizeConfig.heightMultiplier),
          InkWell(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SetSchemeDetails(items: selectedItems)));
            },
            child: SizedBox(
              width: 49 * SizeConfig.widthMultiplier,
              height: 5.6 * SizeConfig.heightMultiplier,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            1.1 * SizeConfig.heightMultiplier),
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.middleRed
                            : MyColors.scarlet,
                      ),
                    ),
                  ),
                  Center(
                    child: Text("Select Scheme Details",
                        style: TextStyle(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.richBlackFogra
                                : MyColors.white,
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ],
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
        child: Container(
          alignment: Alignment.centerLeft,
          width: 93.9 * SizeConfig.widthMultiplier,
          height: 3.8 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(1.2 * SizeConfig.heightMultiplier)),
            color: MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
          ),
          padding: EdgeInsets.fromLTRB(2 * SizeConfig.widthMultiplier, 0, 0, 0),
          child: Text(
            selectedItems[key],
            style: TextStyle(
              fontSize: 1.7 * SizeConfig.textMultiplier,
              color: MyColors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 1.5 * SizeConfig.heightMultiplier,
      ),
    ]);
  }
}
