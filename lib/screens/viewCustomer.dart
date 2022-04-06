import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_customer.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/screens/viewCustomerDetail.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCustomerScreen extends StatefulWidget {
  const ViewCustomerScreen({Key? key}) : super(key: key);

  @override
  State<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends State<ViewCustomerScreen> {
  @override
  initState() {
    super.initState();
  }

  var phone;
  var email;
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
        title: Text("Edit Customer",
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6),
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Database_customer.customersBySubArea.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key) {
    return Column(children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: MyScreen.getScreenHeight(context) * (100 / 1063.6),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6),
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        Database_customer.customersBySubArea[key].party_Name! +
                            " - " +
                            Database_customer
                                .customersBySubArea[key].sub_Group!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (20 / 1063.6),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          email =
                              Database_customer.customersBySubArea[key].email!;
                          launch("mailto:$email?subject=''");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              size: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (10 / 490.9),
                            ),
                            Text(
                              Database_customer.customersBySubArea[key].email!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (15 / 1063.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          phone = Database_customer
                              .customersBySubArea[key].phone_1!;
                          launch("tel:$phone");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (10 / 490.9),
                            ),
                            Text(
                              Database_customer
                                  .customersBySubArea[key].phone_1!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (15 / 1063.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: MyColors.black,
                        height:
                            MyScreen.getScreenHeight(context) * (2 / 1063.6),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              if (await Database_customerBranch()
                                  .get_AllcustomerBranchesByCode(
                                      Database_customer
                                          .customersBySubArea[key].code!)) {
                                Navigator.pushNamed(context,
                                    MyRoutes.MyViewCustomerBranchScreen);
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View/Edit Branch",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (15 / 1063.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (120 / 490.9),
                          ),
                          InkWell(
                            onTap: () async {
                              print(Database_customer
                                  .customersBySubArea[key].party_Name);
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewCustomerDetail(
                                            customer: Database_customer
                                                .customersBySubArea[key],
                                          )));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View/Edit Customer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (15 / 1063.6),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
      ),
    ]);
  }
}
