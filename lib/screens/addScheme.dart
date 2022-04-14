import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
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
        title: Text("Select Items",
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
      body: Column(
        children: [
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
          ),
          Container(
            width: MyScreen.getScreenWidth(context) * (460 / 490.9),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
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
              noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No item found'),
              ),
            ),
          ),
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
          ),
          Container(
            height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
            width: MyScreen.getScreenWidth(context) * (460 / 490.9),
            color: MyDrawer.emp.darkTheme == 1
                ? MyColors.pewterBlue
                : MyColors.black,
          ),
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (15 / 1063.6),
          ),
          Text(
            "Long press on Items to remove from List",
            style: TextStyle(
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.pewterBlue
                  : MyColors.black,
            ),
          ),
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
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
          SizedBox(height: MyScreen.getScreenHeight(context) * (60 / 1063.6)),
          SizedBox(
            width: MyScreen.getScreenWidth(context) * (240 / 490.9),
            height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
            child: InkWell(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MyScreen.getScreenHeight(context) * (10 / 1063.6)),
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
                            fontSize: MyScreen.getScreenHeight(context) *
                                (17 / 1063.6),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SetSchemeDetails(items: selectedItems)));
              },
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
          width: MyScreen.getScreenWidth(context) * (460 / 490.9),
          height: MyScreen.getScreenHeight(context) * (40 / 1063.6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
          ),
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            selectedItems[key],
            style: TextStyle(
              fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
              color: MyColors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        height: MyScreen.getScreenHeight(context) * (15 / 1063.6),
      ),
    ]);
  }
}
