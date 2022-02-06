import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_project_v1/Database/db_SignUp.dart';
import 'package:intern_project_v1/Extras/myColors.dart';
import '../routes.dart';
import 'package:path_provider/path_provider.dart';


class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _pickedImage;
  bool _isObscure = true;
  String dropdownvalue = 'Select an Option';
  var items = [
    'Salesperson',
    'Regional Manager',
    'Area Manager',
    'General Manager',
  ];
  Future<void> showMessage(BuildContext context,String message)async {
    showDialog<bool>(
      context:context,
      builder: (c)=> AlertDialog(
        title:Text('Alert'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: ()=> Navigator.pop(c,false),
          ),
        ],
      ),
    );
  }
  Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(source:ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
      print(_pickedImage);
    });
  }
  moveToHome(BuildContext context) async{
    if(_pickedImage == null){
      showMessage(context,'Please Select or Upload Image');
      return;
    }
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(_formKey.currentState!.value['password_1']!=_formKey.currentState!.value['password_2']){
        showMessage(context,"Both Password should match");
        return;
      }

      await Database_signUp.addEmp(
          profile_pic: _pickedImage!.path,
          name: _formKey.currentState!.value['full_name'],
          email: _formKey.currentState!.value['email'],
          password: _formKey.currentState!.value['password_1'],
          role: _formKey.currentState!.value['role'],
          status:"Email Pending",
      );
      String? email = _formKey.currentState?.value['email'].toString();
      Employee? emp = await Database_signUp.getEmp(email: email!, id: 0);
      await showMessage(context,"Your Employee Id is : "+emp!.id.toString());
      await Future.delayed(Duration(seconds:5));
      await Navigator.pushNamed(context,MyRoutes.MyLogin);
    }
  }
  /*
    This is code load image from asset in case user doesn't select image, this will be used as default image
    but it is not working.*/

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/DIMS.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> LoadImage() async {
    _pickedImage = await getImageFileFromAssets('images/DIMS.png');
    print(_pickedImage);
  }


  @override
  Widget build(BuildContext context) {
    if (_pickedImage == null) {
      LoadImage();
    }
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
                    FormBuilder(
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
                          SizedBox(height:20),
                          Container(
                            width: 300,
                            height: 30,
                            child: FormBuilderTextField(
                              name:'full_name',
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
                          SizedBox(height:20),
                          Container(
                            width: 300,
                            height: 30,
                            child: FormBuilderTextField(
                                name:'email',
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.pewterBlue)),
                                ),
                                style: TextStyle(color: MyColors.middleRed,
                                    fontSize: 20),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Email Id";
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(height:10),
                          SizedBox(
                              width:300,
                              height:20,
                              child: Row(
                                children:[
                                  Text("Password *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                                  SizedBox(width:150),
                                  // IconButton(
                                  //   icon: Icon(
                                  //       _isObscure ? Icons.visibility : Icons.visibility_off,
                                  //       color:MyColors.pewterBlue,size:30
                                  //   ),
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       _isObscure = !_isObscure;
                                  //     });
                                  //   },
                                  // ),
                                ],
                              )
                          ),
                          SizedBox(height: 20),
                          Container(
                            width:300,
                            height:30,
                            child:FormBuilderTextField(
                              name:'password_1',
                              obscureText: _isObscure,
                              style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Password";
                                }
                                else if (value.length < 6) {
                                  return "Password Length must be at least 6";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                              ),

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
                                ],
                              )
                          ),
                          SizedBox(height:20),
                          Container(
                            width: 300,
                            height: 30,
                            child: FormBuilderTextField(
                              name:'password_2',
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
                            child: FormBuilderDropdown(
                              name:'role',
                              validator: (value) {
                                if(value.toString()=="Select an Option")
                                  return "Please seleect you role";
                                return null;
                              },
                              style: TextStyle(color: MyColors.pewterBlue),
                              isExpanded: true,
                              isDense: true,
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
