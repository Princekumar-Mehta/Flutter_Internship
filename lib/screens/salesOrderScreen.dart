import 'package:flutter/material.dart';
import 'package:project_2/Extras/myColors.dart';
import 'package:flutter/cupertino.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({Key? key}) : super(key: key);

  @override
  _SalesOrderScreenState createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  DateTime ? _dateTime;
  double _animatedHeight=100.0;
  var quantity = ['','Qty','Packet','1','Patti','5','Box','10','Total','210'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child:Column(
            children:[
              Padding(
                padding:EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:Material(
                        child:InkWell(
                          child:Container(
                            decoration: BoxDecoration(
                              color: MyColors.richBlackFogra,
                              border:Border.all(color:MyColors.richBlackFogra),
                            ),
                            child:Icon(Icons.arrow_back,color:MyColors.scarlet,size:30),
                          ),
                          onTap:(){Navigator.pop(context,true);},
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child:Text("Place Sales Order",style:TextStyle(color:MyColors.scarlet,fontSize:25)),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child:Material(
                        child:InkWell(
                          child:Container(
                            decoration: BoxDecoration(
                              color: MyColors.richBlackFogra,
                              border:Border.all(color:MyColors.richBlackFogra),
                            ),
                            child:Icon(Icons.more_vert,color:MyColors.scarlet,size:30),
                          ),
                          onTap:(){Navigator.pop(context,true);},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                decoration: BoxDecoration(
                  border:Border(
                    bottom:BorderSide(color:MyColors.scarlet),
                  ),
                ),
              ),
              Padding(
                  padding:EdgeInsets.fromLTRB(15, 20, 15, 5),
                  child:Stack(
                    children:[
                      Container(
                        alignment: Alignment.centerLeft,
                        child:Text("Code: SO-XXXXXX",style:TextStyle(color:MyColors.pewterBlue)),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child:Text("Date: DD/MM/YYYY",style:TextStyle(color:MyColors.pewterBlue)),
                      ),
                    ],
                  )
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
                child:Column(
                  children:[
                    SizedBox(height: 30),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Text("Customer *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                        ),
                        style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Text("Customer *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                        ),
                        style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Text("Billing Address *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                        ),
                        style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Text("Shipping Address *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                        ),
                        style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Row(
                          children:[
                            Text("Phone *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                            Container(
                              width:200,
                              child:TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                ),
                                style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Row(
                          children:[
                            Text("Email *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                            Container(
                              width:200,
                              child:TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                ),
                                style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:Text("Manufacturing Branch *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:15,
                      child:TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                        ),
                        style:TextStyle(color:MyColors.middleRed,fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:17,
                      child:Text("Order Required By *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width:300,
                      height:20,
                      child:
                      // RaisedButton(
                      //   child:Text(_dateTime == null ?"Pick a date":_dateTime.toString()),
                      //   onPressed: (){
                      //     print('date_picker should be displayed');
                      //     showDatePicker(
                      //         context: context,
                      //         initialDate: DateTime.now(),
                      //         firstDate: DateTime(2001),
                      //         lastDate: DateTime(2022)
                      //     ).then((date){
                      //       setState(() {
                      //         _dateTime =date!;
                      //       });
                      //     });
                      //   },
                      // ),
                      CupertinoDatePicker(
                        backgroundColor: MyColors.grullo,
                        mode:CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(2022,1,29),
                        onDateTimeChanged: (DateTime newDateTime){
                          print(newDateTime);
                        },
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child:Stack(
                        children:[
                          Container(
                            alignment:Alignment.centerLeft,
                            child:Text("Item List",style:TextStyle(color:MyColors.pewterBlue)),
                          ),
                          Container(
                            alignment:Alignment.centerRight,
                            child:Text("Add Item +",style:TextStyle(color:MyColors.pewterBlue)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child:Column(
                        children:[
                          Container(
                            decoration:BoxDecoration(
                              border:Border.all(color:MyColors.pewterBlue),
                              borderRadius:BorderRadius.circular(10),
                            ),
                            width:300,
                            child:Padding(
                              padding:EdgeInsets.all(5),
                              child:Column(
                                  children:[
                                    Stack(
                                        children:[
                                          Container(
                                            alignment:Alignment.centerLeft,
                                            child: Text("1",style:TextStyle(color:MyColors.pewterBlue)),
                                          ),
                                          Positioned.fill(
                                            child:Align(
                                              alignment:Alignment.topCenter,
                                              child:Container(
                                                alignment:Alignment.center,
                                                width:200,
                                                decoration: BoxDecoration(
                                                  border:Border(
                                                    bottom:BorderSide(color:MyColors.pewterBlue),
                                                  ),
                                                ),
                                                child: Text("Item: Balaji Masala Wafers",style:TextStyle(color:MyColors.pewterBlue)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right:0,
                                            child: Container(
                                              height:40,
                                              alignment:Alignment.topRight,
                                              child: GestureDetector(
                                                onTap:(){
                                                  setState(() {
                                                    _animatedHeight!=0.0?_animatedHeight=0.0:_animatedHeight=100.0;
                                                  });
                                                },
                                                child:Icon(Icons.keyboard_arrow_down,color:MyColors.pewterBlue,size:20),
                                              ),
                                            ),
                                          ),
                                        ],
                                    ),
                                    AnimatedContainer(
                                        duration: Duration(milliseconds: 120),
                                        height:_animatedHeight,
                                        child:Stack(
                                            children:[
                                              Row(
                                                children:[
                                                  SizedBox(width:50),
                                                  Text("Price: \$ XX.XX",style:TextStyle(color:MyColors.pewterBlue)),
                                                  SizedBox(width:30),
                                                  Text("Unit: Packet",style:TextStyle(color:MyColors.pewterBlue)),
                                                ],
                                              ),
                                              Positioned(
                                                top:30,
                                                left:100,
                                                child:Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 100,
                                                    maxWidth: 100,
                                                  ),
                                                  color:MyColors.richBlackFogra,
                                                  child:GridView.count(
                                                    padding:EdgeInsets.all(0),
                                                    crossAxisCount:2,
                                                    crossAxisSpacing: 4,
                                                    mainAxisSpacing: 8,
                                                    childAspectRatio: 2,
                                                    children:List.generate(quantity.length, (index){
                                                      return Text(quantity[index],style:TextStyle(color:MyColors.pewterBlue));
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    