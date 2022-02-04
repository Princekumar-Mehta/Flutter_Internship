import 'package:flutter/material.dart';
import 'package:intern_project_v1/Extras/myColors.dart';
import '../routes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  moveToHome(BuildContext context) async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      final form_data = _formKey.currentState?.value;
      if(_formKey.currentState?.value['email_emp'].toString()=="Prince@gmail.com"&&_formKey.currentState?.value['password'].toString()=='123456'){
        await Future.delayed(Duration(seconds:1));
        await Navigator.pushNamed(context,MyRoutes.MySalesOrder);
        _formKey.currentState!.reset();
      }else{
        showDialog<bool>(
          context:context,
          builder: (c)=> AlertDialog(
            title:Text('Alert'),
            content: Text('Either Password is incorrect or email/employee id doesn\'t exist'),
            actions: [
              FlatButton(
                child: Text('Okay'),
                onPressed: ()=> Navigator.pop(c,false),
              ),
            ],
          ),
        );
      }

    }
  }
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.richBlackFogra,
          body: SingleChildScrollView(
            child:Container(
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child:Stack(
                  children:[
                    Positioned(
                      child:Container(
                        width:MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:AssetImage("assets/images/Abstract_2.png"),
                              fit:BoxFit.fill,
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      child: Center(
                        child:Opacity(
                          opacity:0.5,
                          child:Container(
                            width:MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height,
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child:Opacity(
                          opacity:1,
                          child:Container(
                            width:320,
                            height:500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color:MyColors.richBlackFogra,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top:10,
                                  left:20,
                                  child:Text("Welcome!",style:TextStyle(color:MyColors.pewterBlue,fontSize: 30)),
                                ),
                                Positioned(
                                  top:50,
                                  left:10,
                                  child: FormBuilder(
                                    key:_formKey,
                                    child:Column(
                                      children: [
                                        SizedBox(height: 50),
                                        SizedBox(
                                          width:300,
                                          height:20,
                                          child:Text("Email/Employee ID *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                                        ),
                                        SizedBox(height: 20),

                                        Container(
                                          width:300,
                                          height:30,
                                          child:FormBuilderTextField(
                                              name:'email_emp',
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                              ),
                                              style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                                              validator:(value){
                                                if(value!.isEmpty){
                                                  return "Please Enter Email or Employee Id";
                                                }
                                                return null;
                                              }
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        SizedBox(
                                            width:300,
                                            height:20,
                                            child: Row(
                                              children:[
                                                Text("Password *",style:TextStyle(color:MyColors.pewterBlue,fontSize: 20)),
                                                SizedBox(width:150),
                                                Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                                              ],
                                            )
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          width:300,
                                          height:30,
                                          child:FormBuilderTextField(
                                              name:'password',
                                              obscureText:true,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyColors.pewterBlue)),
                                                // suffixIcon: Padding(
                                                //   padding: EdgeInsets.fromLTRB(0,0,0,40),
                                                //   child: Icon(Icons.remove_red_eye,color:MyColors.pewterBlue,size:30),
                                                // ),
                                              ),
                                              style:TextStyle(color:MyColors.middleRed,fontSize: 20),
                                              validator:(value){
                                                if(value!.isEmpty){
                                                  return "Please Enter Password";
                                                }
                                                return null;
                                              }
                                          ),
                                        ),

                                        SizedBox(
                                            width:300,
                                            height:30,
                                            child: Row(
                                              children:[
                                                SizedBox(width: 130),
                                                Text("Forgot Password?",style:TextStyle(color:MyColors.middleRed,fontSize: 20)),
                                              ],
                                            )
                                        ),
                                        SizedBox(height:30),
                                        SizedBox(
                                          width:300,
                                          height:30,
                                          child:  InkWell(
                                            child:Stack(
                                              children:[
                                                Opacity(
                                                  opacity:0.6,
                                                  child:Container(
                                                    alignment:Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color:MyColors.scarlet,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child:Text("Login",style:TextStyle(color:Colors.white,fontSize: 17)),
                                                )
                                              ],
                                            ),
                                            onTap: ()=>moveToHome(context),
                                          ),
                                        ),
                                        Container(
                                          width:300,
                                          height:10,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:MyColors.pewterBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height:20),
                                        Row(
                                          children:[
                                            Container(
                                                width: 120,
                                                height:50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  color:MyColors.pewterBlue,
                                                ),
                                                child: InkWell(
                                                    child:Stack(
                                                      children:[
                                                        Positioned(
                                                          left:7,
                                                          top:9,
                                                          child:Icon(Icons.mail,size: 35,),
                                                        ),
                                                        Positioned(
                                                          left:50,
                                                          top:15,
                                                          child:Text("Sign Up",style:TextStyle(fontSize: 17)),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap:()=>Navigator.pushNamed(context, MyRoutes.MySignUpEmail)
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
