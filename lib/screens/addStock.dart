import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Database/db_stock.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/item.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  late MyTypeAhead item_Name;

  final _formKey = GlobalKey<FormBuilderState>();
  addStock() async {
    print(item_Name.getValue());

    if (!Database_Item.item_names.contains((item_Name.getValue()))) {
      Utility.showMessage(context, "Please Select Item from Item List");
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Item item_details = await Database_Item().get_Item(
          item_Name.getValue().split(' - ')[0],
          int.parse(item_Name.getValue().split(' - ')[1].split('g')[0]));
      String packets = (_formKey.currentState?.value['no_packet'].toString())!;
      String patti = (_formKey.currentState?.value['no_patti'].toString())!;
      String box = (_formKey.currentState?.value['no_box'].toString())!;
      print(packets + " " + patti + " " + box);
      Database_Stock.increaseStock(1, item_details.code!, int.parse(packets),
          int.parse(patti), int.parse(box));
      showMessage(context, "Stock updated");
    }
  }

  static Future<void> showMessage(BuildContext context, String message,
      {String title: "Alert"}) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              child: const Text('Okay'),
              onPressed: () async {
                Navigator.pop(c, false);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  giveFormBuilderTextField(name) {
    return SizedBox(
      width: MyScreen.getScreenWidth(context) * (228 / 294),
      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
      child: FormBuilderTextField(
          name: name,
          initialValue: '0',
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.pewterBlue
                  : MyColors.black,
            )),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.middleRed
                  : MyColors.scarlet,
              fontSize: MyScreen.getScreenHeight(context) * (25 / 1063.6)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter $name";
            }
            return null;
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Database_Item.item_names.length);
    item_Name = (MyTypeAhead(
        itemList: Database_Item.item_names,
        message: "Please Enter Item Name",
        fontSize: MyScreen.getScreenHeight(context) * (25 / 1063.6),
        isEnabled: true));
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
        title: Text("Add Stock",
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                              MyScreen.getScreenWidth(context) * (70 / 640)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Select Item *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      item_Name,
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("No. of Packets *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      giveFormBuilderTextField("no_packet"),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("No. of Pattis *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      giveFormBuilderTextField("no_patti"),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("No. of Boxes *",
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      giveFormBuilderTextField("no_box"),
                      SizedBox(
                          height: MyScreen.getScreenHeight(context) *
                              (60 / 1063.6)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (85 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6),
                        child: InkWell(
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MyScreen.getScreenHeight(context) *
                                            (10 / 1063.6)),
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.middleRed
                                        : MyColors.scarlet,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text("Save Item",
                                    style: TextStyle(
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.richBlackFogra
                                            : MyColors.white,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (17 / 1063.6),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          onTap: () {
                            addStock();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
