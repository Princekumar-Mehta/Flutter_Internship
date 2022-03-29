import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Database/db_stock.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
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
    }
  }

  giveFormBuilderTextField(name) {
    return SizedBox(
      width: MyScreen.getScreenWidth(context) * (228 / 294),
      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
      child: FormBuilderTextField(
          name: name,
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
    item_Name = (MyTypeAhead(
        itemList: Database_Item.item_names,
        message: "Please Enter Item Name",
        fontSize: MyScreen.getScreenHeight(context) * (19 / 1063.6),
        isEnabled: true));
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Stock"),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Text("Select Item"),
            item_Name,
            Text("No of packet"),
            giveFormBuilderTextField("no_packet"),
            Text("No of Patti"),
            giveFormBuilderTextField("no_patti"),
            Text("No of box"),
            giveFormBuilderTextField("no_box"),
            InkWell(
                child: Text("Add stock"),
                onTap: () {
                  addStock();
                }),
          ],
        ),
      ),
    );
  }
}
