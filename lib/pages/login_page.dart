import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:catalog_app/utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  String name ="";
  bool changeButton = false;
  final  _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async{
      if(_formKey.currentState!.validate()){
        setState(() {
          changeButton=true;
        });
        await Future.delayed(Duration(seconds:1));
        await Navigator.pushNamed(context,MyRoutes.HomeRoute);
        setState(() {
          changeButton=false;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:AppBar(title:Text('Login Page')),
        body:
        SingleChildScrollView(
          child: Center(
              child: Form(
                  key:_formKey,
                  child:Column(
                  children: [
                    Image.asset("assets/images/hey_image.png"),
                    SizedBox(height:20.0),
                    Text("Welcome $name",style: TextStyle(fontSize: 30)),
                    SizedBox(height:20.0),
                    Padding(
                        padding : const EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
                        child:  Column(
                                children :[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText:"Enter Username",
                                      labelText:"Username",
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        name=value;
                                      });
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Username can't be empty";
                                      }else{
                                        return null;
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    obscureText:true,
                                    decoration: InputDecoration(
                                      hintText:"Enter Password",
                                      labelText:"Password",
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Password can't be empty";
                                      }else if(value.length <6 ){
                                        return "Password Length msut be at least 6";
                                      }
                                      else
                                        return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Material(
                                    color: Colors.purple,
                                    borderRadius: changeButton?BorderRadius.circular(50):BorderRadius.circular(10),
                                    child: InkWell(
                                      onTap: ()=>moveToHome(context),
                                      child:AnimatedContainer(
                                        //  onTap:
                                        duration: Duration(seconds:1),
                                        height: 50,
                                        width:changeButton?50:150,
                                        alignment: Alignment.center,
                                        child: changeButton?Icon(Icons.done):Text('Enter',style:TextStyle(color:Colors.white)),
                                      ),
                                    ),
                                  ),
                                  // ElevatedButton(
                                  //   child: Text('Enter'),
                                  //   style:TextButton.styleFrom(backgroundColor: Colors.blue,minimumSize: Size(150,50)),
                                  //   onPressed: (){
                                  //
                                  //     //  Navigator.pushNamed(context,MyRoutes.HomeRoute);
                                  //   },
                                  // )
                                ]
                            )
                        ),
                  ]
              )
          )
          )
        )
      )
    );
  }
}
