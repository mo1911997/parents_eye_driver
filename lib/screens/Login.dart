import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parentseye_driver/animations/FadeRoute.dart';
import 'package:parentseye_driver/screens/ExitConfirmationDialog.dart';
import 'package:parentseye_driver/screens/GetOTPAfterGetContact.dart';
import 'package:parentseye_driver/utilities/Constants.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget
{
  @override
  _Login createState() => new _Login();    
}
class _Login extends State<Login>
{  
  var contactController = TextEditingController();
  var passwordController = TextEditingController();
  var url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = Constants.BASE_URL+"drivers/login";
  }
  void login() async 
  {
    http.Response response =  await http.post(
      url,
      body: {
        'contact' : contactController.text,
        'password' : passwordController.text
      },
      headers: {
        "Accept":"application/json"
      }
    );
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {
        contactController.clear();
        passwordController.clear();
      }
      else 
      {
        Fluttertoast.showToast(
              msg: "Invalid Credentials !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
      }
    }
    else 
    {
      Fluttertoast.showToast(
              msg: "Something went wrong !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
    }
    
  }
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope( 
      onWillPop: (){
        showDialog(
    context: context,
    builder: (BuildContext context) {
      return ExitConfirmationDialog();
    },
  );
      },
      child: Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView( 
        child: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container( 
                margin: EdgeInsets.only(top:20.0,bottom: 20.0),
                child: Icon(Icons.memory,size: 100.0,),
              ),
              
              new Card(
                child: new Container(                  
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      TextField(
                        controller: contactController,
                        keyboardType: TextInputType.text,                                                   
                          decoration: InputDecoration(
                            labelText: 'Username',
                            
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                        keyboardType: TextInputType.text,                        
                          decoration: InputDecoration(
                            labelText: 'Password',
                            
                          ),
                        ),
                        Container( 
                          margin: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(                    
                          textColor : Colors.white,    
                          onPressed: () {
                          //   Navigator.push(context, 
                          //  FadeRoute(page: GetOTPAfterGetContact()));
                          },
                          child: Text("Login",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                          color: Colors.lightBlueAccent,
                        ),
                      ),                                            
                    ],
                  ),
                ),
              ),              
            ],
          ),
        ),
      ),
      )
    ),
    );           
  }
}

