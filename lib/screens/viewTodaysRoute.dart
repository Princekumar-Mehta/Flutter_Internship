import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_route.dart';

class ViewTodaysRoute extends StatefulWidget {
  @override
  _ViewTodaysRouteState createState() => _ViewTodaysRouteState();
}

class _ViewTodaysRouteState extends State<ViewTodaysRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Route"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListView.builder(
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              itemCount: Database_Route.routeBranches.length,
              itemBuilder: (context, index) {
                return Container(
                  child: _row(index),
                );
              }),
        ],
      ),
    );
  }

  _row(key) {
    return Text(Database_Route.routeBranches[key].branch_Name!);
  }
}
