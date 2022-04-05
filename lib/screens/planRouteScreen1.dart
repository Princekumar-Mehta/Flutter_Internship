import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_route.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/customer_branch.dart';
import 'package:project_v3/screens/planRouteScreen2.dart';
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
    for (int i = 0; i < Database_Route.allBranchesBySubArea.length; i++) {
      selected[Database_Route.allBranchesBySubArea[i].branch_Code.toString()] =
          false;
    }
  }

  addRoute() async {
    if (selectedBranches.length < 1) {
      Utility.showMessage(
          context, "Please select at least one branch to add to route.");
      return;
    }
    String route = "";
    for (int i = 0; i < selectedBranches.length; i++) {
      if (i == 0) {
        route += selectedBranches[i]['branch'].branch_Code;
      } else {
        route += "-" + selectedBranches[i]['branch'].branch_Code;
      }
    }
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlanRouteScreen2(
                  route: route,
                )));
  }

  viewOnMap() async {
    if (selectedBranches.length < 1) {
      Utility.showMessage(context,
          "Please select the shops for which you would like to see the route on map.");
      return;
    }
    String route = "";
    List<CustomerBranch> locations = [];
    for (int i = 0; i < selectedBranches.length; i++) {
      // print(selectedBranches[i]['branch'].branch_Name +
      //     selectedBranches[i]['distance'].toString());
      locations.add(selectedBranches[i]['branch']);
      if (i == 0) {
        route += selectedBranches[i]['branch'].branch_Code;
      } else {
        route += "-" + selectedBranches[i]['branch'].branch_Code;
      }
    }
    // print(route);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RouteMapScreen(
                  locations: locations,
                )));
  }

  formOptimalRoute() async {
    List<List<double>> distance = [];
    int no_of_branches = Database_Route.allBranchesBySubArea.length;
    if (selectedBranches.length != 1) {
      Utility.showMessage(context,
          "Please only select the branch from which you would like to start.");
      return;
    }
    for (int i = 0; i < no_of_branches; i++) {
      distance.add([]);
      for (int j = 0; j < no_of_branches; j++) {
        distance[i].add(0);
      }
    }
    for (int i = 0; i < no_of_branches; i++) {
      for (int j = 0; j < no_of_branches; j++) {
        distance[i][j] = double.parse(Utility.calculateDistance(
          Database_Route.allBranchesBySubArea[i].latitude,
          Database_Route.allBranchesBySubArea[i].longitude,
          Database_Route.allBranchesBySubArea[j].latitude,
          Database_Route.allBranchesBySubArea[j].longitude,
        ));
      }
    }
    int selected = Database_Route.allBranchesBySubArea
        .indexWhere((element) => element == selectedBranches.first['branch']);
    List<CustomerBranch> locations = [];
    while (locations.length < Database_Route.allBranchesBySubArea.length) {
      locations.add(Database_Route.allBranchesBySubArea[selected]);
      //    print(Database_Route.allBranchesBySubArea[selected].branch_Name);
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
        child: Column(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
                    ? MyColors.middleRed
                    : MyColors.scarlet,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (0 / 490.9),
                    0,
                    MyScreen.getScreenWidth(context) * (0 / 490.9),
                    MyScreen.getScreenWidth(context) * (10 / 490.9)),
                child: Container(
                  width: MyScreen.getScreenWidth(context) * (440 / 490.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Total Distance : " +
                                totalDistance.toStringAsFixed(2) +
                                " km",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (18 / 1063.3),
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
                          itemCount: Database_Route.allBranchesBySubArea.length,
                          itemBuilder: (context, index) {
                            return selected[Database_Route
                                    .allBranchesBySubArea[index].branch_Code
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MyScreen.getScreenWidth(context) * (15 / 490.9)),
              child: Row(
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
                        addRoute();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _row(int key, bool isSelected) {
    return isSelected
        ? Row(
            children: [
              Container(
                width: MyScreen.getScreenWidth(context) * (350 / 490.9),
                child: CheckboxListTile(
                  checkColor: MyColors.white,
                  activeColor: MyDrawer.emp.darkTheme == 1
                      ? MyColors.middleRed
                      : MyColors.scarlet,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                      /*selectedBranches[key]['branch'].branch_Code.toString() +
                          "\t" +*/
                      selectedBranches[key]['branch'].branch_Name.toString() +
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
                        initialBranch = Database_Route.allBranchesBySubArea
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
                      // print(initialBranch);
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
                width: MyScreen.getScreenWidth(context) * (350 / 490.9),
                child: CheckboxListTile(
                  checkColor: MyColors.white,
                  activeColor: MyDrawer.emp.darkTheme == 1
                      ? MyColors.middleRed
                      : MyColors.scarlet,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                      /*Database_Route.allBranchesBySubArea[key].branch_Code
                              .toString() +
                          "\t" +*/
                      Database_Route.allBranchesBySubArea[key].branch_Name
                              .toString() +
                          "\n" +
                          (Utility.calculateDistance(
                                Database_Route
                                    .allBranchesBySubArea[initialBranch == -1
                                        ? key
                                        : initialBranch]
                                    .latitude,
                                Database_Route
                                    .allBranchesBySubArea[initialBranch == -1
                                        ? key
                                        : initialBranch]
                                    .longitude,
                                Database_Route
                                    .allBranchesBySubArea[key].latitude,
                                Database_Route
                                    .allBranchesBySubArea[key].longitude,
                              ) +
                              " km"),
                      style: TextStyle(
                          fontSize: 13,
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black)),
                  value: selected[Database_Route
                      .allBranchesBySubArea[key].branch_Code
                      .toString()],
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        double currentDistance =
                            double.parse(Utility.calculateDistance(
                          Database_Route
                              .allBranchesBySubArea[
                                  initialBranch == -1 ? key : initialBranch]
                              .latitude,
                          Database_Route
                              .allBranchesBySubArea[
                                  initialBranch == -1 ? key : initialBranch]
                              .longitude,
                          Database_Route.allBranchesBySubArea[key].latitude,
                          Database_Route.allBranchesBySubArea[key].longitude,
                        ));
                        totalDistance += currentDistance;
                        selectedBranches.add({
                          "branch": Database_Route.allBranchesBySubArea[key],
                          "distance": currentDistance
                        });
                        initialBranch = key;
                      }
                      // print(initialBranch);
                      selected[Database_Route
                          .allBranchesBySubArea[key].branch_Code
                          .toString()] = value;

                      bool noneSelected = true;
                      for (int i = 0;
                          i < Database_Route.allBranchesBySubArea.length;
                          i++) {
                        if (selected[Database_Route
                                .allBranchesBySubArea[i].branch_Code
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
