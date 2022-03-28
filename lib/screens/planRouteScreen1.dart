import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/customer_branch.dart';
import 'package:project_v3/screens/viewRouteScreen.dart';

class PlanRouteScreen1 extends StatefulWidget {
  PlanRouteScreen1();

  @override
  _PlanRouteScreen1State createState() => _PlanRouteScreen1State();
}

class _PlanRouteScreen1State extends State<PlanRouteScreen1> {
  Map<String, double> dataMap = {};
  Map<String, bool> selected = {};
  List<Map<String, dynamic>> selectedBranches = [];
  double totalDistance = 0.0;
  int initialBranch = -1;
  @override
  void initState() {
    for (int i = 0; i < Database_customerBranch.all_branches.length; i++) {
      selected[Database_customerBranch.all_branches[i].branch_Code.toString()] =
          false;
    }
  }

  viewOnMap() async {
    String route = "";
    List<CustomerBranch> locations = [];
    for (int i = 0; i < selectedBranches.length; i++) {
      print(selectedBranches[i]['branch'].branch_Name +
          selectedBranches[i]['distance'].toString());
      locations.add(selectedBranches[i]['branch']);
      if (i == 0) {
        route += selectedBranches[i]['branch'].branch_Code;
      } else {
        route += "-" + selectedBranches[i]['branch'].branch_Code;
      }
    }
    print(route);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RouteMapScreen(
                  locations: locations,
                )));
  }

  formOptimalRoute() async {
    List<List<double>> distance = [];
    int no_of_branches = Database_customerBranch.all_branches.length;
    for (int i = 0; i < no_of_branches; i++) {
      distance.add([]);
      for (int j = 0; j < no_of_branches; j++) {
        distance[i].add(0);
      }
    }
    for (int i = 0; i < no_of_branches; i++) {
      for (int j = 0; j < no_of_branches; j++) {
        distance[i][j] = double.parse(Utility.calculateDistance(
          Database_customerBranch.all_branches[i].latitude,
          Database_customerBranch.all_branches[i].longitude,
          Database_customerBranch.all_branches[j].latitude,
          Database_customerBranch.all_branches[j].longitude,
        ));
      }
    }
    int selected = Database_customerBranch.all_branches
        .indexWhere((element) => element == selectedBranches.first['branch']);
    List<CustomerBranch> locations = [];
    while (locations.length < Database_customerBranch.all_branches.length) {
      locations.add(Database_customerBranch.all_branches[selected]);
      print(Database_customerBranch.all_branches[selected].branch_Name);
      double minDist = 0.0;
      int index = -1;
      for (int i = 0; i < no_of_branches; i++) {
        distance[i][selected] = -1;
        if (distance[selected][i] != -1) {
          if (index == -1 || minDist > distance[selected][i]) {
            minDist = distance[selected][i];
            index = i;
          }
        }
      }
      selected = index;
    }

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RouteMapScreen(
                  locations: locations,
                )));
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
        title: Text("Select Shop to Add",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
                ? MyColors.middleRed
                : MyColors.scarlet,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Total Distance : " +
                        totalDistance.toStringAsFixed(2) +
                        " km",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MyScreen.getScreenHeight(context) * (18 / 1063.3),
                      color: MyDrawer.emp.darkTheme == 1
                          ? MyColors.middleRed
                          : MyColors.scarlet,
                    )),
              ),
              Divider(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
                indent: 15,
                endIndent: 15,
                thickness: 1,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: Database_customerBranch.all_branches.length,
                  itemBuilder: (context, index) {
                    return selected[Database_customerBranch
                            .all_branches[index].branch_Code
                            .toString()]!
                        ? Container()
                        : Container(
                            child: _row(index, false),
                          );
                  }),
              Divider(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
                indent: 15,
                endIndent: 15,
                thickness: 1,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: selectedBranches.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index, true),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (105 / 294),
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
                                    MyScreen.getScreenHeight(context) *
                                        (10 / 1063.6)),
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                              ),
                            ),
                          ),
                          Center(
                            child: Text("Form Optimal Route",
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
                        formOptimalRoute();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (85 / 294),
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
                                    MyScreen.getScreenHeight(context) *
                                        (10 / 1063.6)),
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                              ),
                            ),
                          ),
                          Center(
                            child: Text("View on Map",
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
                        viewOnMap();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (85 / 294),
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
                                    MyScreen.getScreenHeight(context) *
                                        (10 / 1063.6)),
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                              ),
                            ),
                          ),
                          Center(
                            child: Text("Add Route",
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
                        Navigator.pushNamed(
                            context, MyRoutes.MyPlanRouteScreen2);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key, bool isSelected) {
    return isSelected
        ? Row(
            children: [
              Container(
                width: 300,
                child: CheckboxListTile(
                  checkColor: MyColors.white,
                  activeColor: MyDrawer.emp.darkTheme == 1
                      ? MyColors.middleRed
                      : MyColors.scarlet,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                      selectedBranches[key]['branch'].branch_Code.toString() +
                          "\t" +
                          selectedBranches[key]['branch']
                              .branch_Name
                              .toString() +
                          "\n" +
                          selectedBranches[key]['distance'].toString() +
                          " km",
                      style: TextStyle(
                          fontSize: 13,
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black)),
                  value: selected[selectedBranches[key]['branch'].branch_Code],
                  onChanged: (value) {
                    setState(() {
                      selected[selectedBranches[key]['branch'].branch_Code] =
                          value!;

                      selectedBranches.removeAt(key);
                      if (selectedBranches.isNotEmpty) {
                        totalDistance = 0;
                        selectedBranches[0] = {
                          'branch': selectedBranches[0]['branch'],
                          'distance': 0.00
                        };
                        initialBranch = Database_customerBranch.all_branches
                            .indexWhere((element) =>
                                element == selectedBranches.last['branch']);
                      }
                      if (selectedBranches.length > 1) {
                        for (int i = 1; i < selectedBranches.length; i++) {
                          var distance = double.parse(Utility.calculateDistance(
                            selectedBranches[i - 1]['branch'].latitude,
                            selectedBranches[i - 1]['branch'].longitude,
                            selectedBranches[i]['branch'].latitude,
                            selectedBranches[i]['branch'].longitude,
                          ));
                          totalDistance += distance;
                          selectedBranches[i] = {
                            'branch': selectedBranches[i]['branch'],
                            'distance': distance
                          };
                        }
                      }
                      print(initialBranch);
                      if (selectedBranches.isEmpty) initialBranch = -1;
                    });
                  },
                ),
              )
            ],
          )
        : Row(
            children: [
              Container(
                width: 300,
                child: CheckboxListTile(
                  checkColor: MyColors.white,
                  activeColor: MyDrawer.emp.darkTheme == 1
                      ? MyColors.middleRed
                      : MyColors.scarlet,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                      Database_customerBranch.all_branches[key].branch_Code
                              .toString() +
                          "\t" +
                          Database_customerBranch.all_branches[key].branch_Name
                              .toString() +
                          "\n" +
                          (Utility.calculateDistance(
                                Database_customerBranch
                                    .all_branches[initialBranch == -1
                                        ? key
                                        : initialBranch]
                                    .latitude,
                                Database_customerBranch
                                    .all_branches[initialBranch == -1
                                        ? key
                                        : initialBranch]
                                    .longitude,
                                Database_customerBranch
                                    .all_branches[key].latitude,
                                Database_customerBranch
                                    .all_branches[key].longitude,
                              ) +
                              " km"),
                      style: TextStyle(
                          fontSize: 13,
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black)),
                  value: selected[Database_customerBranch
                      .all_branches[key].branch_Code
                      .toString()],
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        double currentDistance =
                            double.parse(Utility.calculateDistance(
                          Database_customerBranch
                              .all_branches[
                                  initialBranch == -1 ? key : initialBranch]
                              .latitude,
                          Database_customerBranch
                              .all_branches[
                                  initialBranch == -1 ? key : initialBranch]
                              .longitude,
                          Database_customerBranch.all_branches[key].latitude,
                          Database_customerBranch.all_branches[key].longitude,
                        ));
                        totalDistance += currentDistance;
                        selectedBranches.add({
                          "branch": Database_customerBranch.all_branches[key],
                          "distance": currentDistance
                        });
                        initialBranch = key;
                      }
                      print(initialBranch);
                      selected[Database_customerBranch
                          .all_branches[key].branch_Code
                          .toString()] = value;

                      bool noneSelected = true;
                      for (int i = 0;
                          i < Database_customerBranch.all_branches.length;
                          i++) {
                        if (selected[Database_customerBranch
                                .all_branches[i].branch_Code
                                .toString()] ==
                            true) {
                          noneSelected = false;
                        }
                      }
                      if (noneSelected) initialBranch = -1;
                    });
                  },
                ),
              )
            ],
          );
  }
}
