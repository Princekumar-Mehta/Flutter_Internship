import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class View_Users extends StatefulWidget {
  const View_Users({Key? key}) : super(key: key);

  @override
  _View_UsersState createState() => _View_UsersState();
}

class _View_UsersState extends State<View_Users> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('View User'),
        ),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                padding: EdgeInsets.all(10),
                child:
                  ListTile(
                    leading: Image.network(document['photo_url']),
                    subtitle: Text(document['gmail_id']),
                    trailing: Text(document['full_name']),
                  ),
              );
            }).toList(),
          );
        },
      ),
      ),
    );
  }
}
// class AddData extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text("Prince GFG Tut"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('data').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           return ListView(
//             children: snapshot.data!.docs.map((document) {
//               return Container(
//                 child: Center(child: Text(document['text']+"HELLOO")),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }