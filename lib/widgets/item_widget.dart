import 'package:flutter/material.dart';
import 'package:flutter_app_crash_course_2/models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({required this.item}) : assert (item != null );
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          onTap: (){
            print('${item.name}');
          },
          leading: Image.asset("assets/images/hey_image.png"),
          title: Text(item.name),
          subtitle: Text(item.desc),
          trailing: Text(
              '\$${item.price}',
              textScaleFactor: 1.5,
              style: TextStyle(
                color:Colors.deepPurple,
                fontWeight: FontWeight.bold,
              )
          ),

        ),
    );
  }
}
