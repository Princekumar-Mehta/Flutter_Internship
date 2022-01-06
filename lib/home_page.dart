import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:Text("Catalog App"),
        ),
        body: Center(
          child: Container(
            child: Text("Welcome"),
          )
        )

      )
    );
  }
}
