import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_2/Extras/myColors.dart';
import 'dart:io';
class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  File _pickedImage = File('assets/images/DIMS.png');
  Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(source:ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }
// Initial Selected Value
  String dropdownvalue = 'Select an Option';

// List of items in our dropdown menu
  var items = [
    'Select an Option',
    'Regional Manager',
    'Area Manager',
    'General Manager',
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
        child:SingleChildScrollView(
          child: Container(
            width:MediaQuery.of(context).size.height,
            decoration:BoxDecoration(
              color:MyColors.richBlackFogra,
            ),
            child:Container(
              child:Column(
                //crossAxisAlignment: CrossAxisAlignment.baseline,
                children:[
                  SizedBox(height:50),
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
                  SizedBox(height:50),
                  Stack(
                      children:[
                        InkWell(
                          child:CircleAvatar(
                            radius:40,
                            backgroundImage: _pickedImage != null? FileImage(_pickedImage):null,
                          ),
                          onTap: _pickImage,
                        ),
                        Positioned(bottom:0,right:0,child: Icon(Icons.add_rounded,color:MyColors.pewterBlue,size:30),)
                      ]
                  ),
                  SizedBox(
                    width:300,
                    height:20,
                    child:Text("Full Name*",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width:300,
                    height:20,
                    child:TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                      ),
                      style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width:300,
                    height:20,
                    child:Text("Email Address*",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width:300,
                    height:20,
                    child:TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                      ),
                      style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                    ),
                  ),
                  SizedBox(
                      width:300,
                      height:20,
                      child: Row(
                        children:[
                          Text("Password *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                          SizedBox(width:168),
                          Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                        ],
                      )
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      width:300,
                      height:20,
                      child: Row(
                        children:[
                          SizedBox(
                            width:300,
                            height:20,
                            child:TextFormField(
                              obscureText:true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                              ),
                              style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                      width:300,
                      height:20,
                      child: Row(
                        children:[
                          Text("Confirm Password *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                          SizedBox(width:90),
                          Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                        ],
                      )
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      width:300,
                      height:20,
                      child: Row(
                        children:[
                          SizedBox(
                            width:300,
                            height:20,
                            child:TextFormField(
                              obscureText:true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                              ),
                              style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                    width:300,
                    height:20,
                    child:Text("Select Role*",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width:300,
                    child: DropdownButton(
                      style: TextStyle(color:MyColors.pewterBlue),
                      isExpanded:true,
                      isDense: true,
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child:Container(
                            width:MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            color:MyColors.richBlackFogra,
                            child: Text(items,style:TextStyle(color:MyColors.pewterBlue,fontSize:20)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height:30),
                  SizedBox(
                    width:150,
                    height:60,
                    child:  InkWell(
                      child:Stack(
                        children:[
                          Opacity(
                            opacity:0.8,
                            child:Container(
                              alignment:Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:MyColors.middleRed,
                              ),
                            ),
                          ),
                          Center(
                            child:Text("Create Profile",style:TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      onTap:(){} ,
                    ),
                  ),
                  SizedBox(height:34),
                ],
              ),
            ),
          ),
        )
    );
  }
}
