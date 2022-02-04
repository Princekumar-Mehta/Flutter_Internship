import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_project_v1/Extras/myColors.dart';

import '../routes.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async{
    if(_formKey.currentState!.validate()){
      await Future.delayed(Duration(seconds:1));
      await Navigator.pushNamed(context,MyRoutes.MySalesOrder);
    }
  }
  @override
  Widget build(BuildContext context) {
    File? _pickedImage;
    Future<void> _pickImage() async {
      final pickedImageFile = await ImagePicker().pickImage(source:ImageSource.camera);
      setState(() {
        _pickedImage = File(_pickedImage!.path);
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
    return MaterialApp(
      home: Scaffold(
          appBar:AppBar(
            leading: IconButton(
              icon:Icon(Icons.arrow_back,color:MyColors.scarlet,size:30),
              onPressed: (){Navigator.pop(context,true);},
            ),
            backgroundColor: MyColors.richBlackFogra,
          ),
          backgroundColor: MyColors.richBlackFogra,
          body: SingleChildScrollView(
            child:Container(
              alignment:Alignment.center,
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child:Stack(
                  children:[
                    Form(
                      key:_formKey,
                      child:Column(
                        children: [
                          SizedBox(height: 20),
                          Stack(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: _pickedImage != null
                                        ? FileImage(_pickedImage!)
                                        : null,
                                  ),
                                  onTap: _pickImage,
                                ),
                                Positioned(bottom: 0, right: 0, child: Icon(Icons
                                    .add_rounded, color: MyColors.pewterBlue,
                                    size: 30),)
                              ]
                          ),
                          SizedBox(height:10),
                          SizedBox(
                            width: 300,
                            height: 20,
                            child: Text(
                                "Full Name*", style: TextStyle(color: MyColors
                                .pewterBlue, fontSize: 20)),
                          ),
                          Container(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.pewterBlue)),
                              ),
                              style: TextStyle(color: MyColors.middleRed,
                                  fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Full Name";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height:10),
                          SizedBox(
                            width: 300,
                            height: 20,
                            child: Text(
                                "Email Address*", style: TextStyle(color: MyColors
                                .pewterBlue, fontSize: 20)),
                          ),
                          Container(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.pewterBlue)),
                                ),
                                style: TextStyle(color: MyColors.middleRed,
                                    fontSize: 20),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Email or Employee Id";
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(height:10),
                          SizedBox(
                              width: 300,
                              height: 20,
                              child: Row(
                                children: [
                                  Text("Password *", style: TextStyle(
                                      color: MyColors.pewterBlue, fontSize: 20)),
                                  SizedBox(width: 168),
                                  Icon(Icons.remove_red_eye,
                                      color: MyColors.pewterBlue, size: 30),
                                ],
                              )
                          ),
                          Container(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.pewterBlue)),
                              ),
                              style: TextStyle(color: MyColors.middleRed,
                                  fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Password";
                                }
                                else if (value.length < 6) {
                                  return "Password Length must be at least 6";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height:10),
                          SizedBox(
                              width: 300,
                              height: 20,
                              child: Row(
                                children: [
                                  Text("Confirm Password *", style: TextStyle(
                                      color: MyColors.pewterBlue, fontSize: 20)),
                                  SizedBox(width: 90),
                                  Icon(Icons.remove_red_eye,
                                      color: MyColors.pewterBlue, size: 30),
                                ],
                              )
                          ),
                          Container(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.pewterBlue)),
                              ),
                              style: TextStyle(color: MyColors.middleRed,
                                  fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Password";
                                }
                                else if (value.length < 6) {
                                  return "Password Length must be at least 6";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height:20),
                          SizedBox(
                            width: 300,
                            height: 20,
                            child: Text(
                                "Select Role*", style: TextStyle(color: MyColors
                                .pewterBlue, fontSize: 20)),
                          ),
                          SizedBox(height:10),
                          SizedBox(
                            width: 300,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if(value.toString()=="Select an Option")
                                  return "Please seleect you role";
                                return null;
                              },
                              style: TextStyle(color: MyColors.pewterBlue),
                              isExpanded: true,
                              isDense: true,
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    alignment: Alignment.centerLeft,
                                    color: MyColors.richBlackFogra,
                                    child: Text(items, style: TextStyle(
                                        color: MyColors.pewterBlue, fontSize: 20)),
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
                            width: 150,
                            height: 60,
                            child: InkWell(
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.middleRed,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text("Create Profile", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              onTap: () => moveToHome(context),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ]
              ),
            ),
          )
      ),
    );
  }
}
