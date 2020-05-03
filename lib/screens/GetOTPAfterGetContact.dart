import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parentseye_driver/animations/FadeRoute.dart';
import 'package:parentseye_driver/screens/ExitConfirmationDialog.dart';
import 'package:parentseye_driver/screens/SetPassword.dart';
import 'package:parentseye_driver/utilities/Constants.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:http/http.dart' as http;

class GetOTPAfterGetContact extends StatefulWidget
{
  String contactno;
  GetOTPAfterGetContact(this.contactno);
  @override
  _GetOTPAfterGetContact createState() => new _GetOTPAfterGetContact();    
}
class _GetOTPAfterGetContact extends State<GetOTPAfterGetContact>
{  
  var url;
  var otp;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = Constants.BASE_URL+"drivers/verify_otp";
  }
  void checkOTP() async
  {
    http.Response response = await http.post(
      url,
      body : {
        'otp' : otp,
        'contact':widget.contactno
      },headers: {
        "Accept" : "application/json"
      }
    );
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == true)
      {
          Navigator.push(context, 
          FadeRoute(page: SetPassword(widget.contactno)));
      }
      else 
      {
        Fluttertoast.showToast(
              msg: "Invalid OTP",
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
    
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      Text('Enter OTP : '),
                      PinEntryTextField(                        
                        onSubmit: (String pin){
                            setState(() {
                              otp = pin;
                            });
                        }, // end onSubmit
                      ),
                        Container( 
                          margin: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(                    
                          textColor : Colors.white,    
                          onPressed: () {
                              checkOTP();
                          },
                          child: Text("Check",
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
    );         
  }
}

