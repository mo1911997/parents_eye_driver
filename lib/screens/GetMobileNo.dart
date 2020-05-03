import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parentseye_driver/animations/FadeRoute.dart';
import 'package:parentseye_driver/screens/ExitConfirmationDialog.dart';
import 'package:parentseye_driver/screens/GetOTPAfterGetContact.dart';
import 'package:parentseye_driver/utilities/Constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class GetMobileNo extends StatefulWidget
{
  @override
  _GetMobileNo createState() => new _GetMobileNo();    
}
class _GetMobileNo extends State<GetMobileNo>
{  
  var contactController = TextEditingController();
  var url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = Constants.BASE_URL+"drivers/check_contact";
  }
  void checkContact() async 
  {
    http.Response response = await http.post( 
      url,
      body:{
        'contact': contactController.text
      },
      headers: {
        "Accept":"application/json"
      }
    );
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = convert.json.decode(response.body);
      if(decodedResponse['state'] == true)
      {
          Navigator.push(context, 
          FadeRoute(page: GetOTPAfterGetContact(contactController.text)));
          contactController.clear();
      }
      else 
      {
          Fluttertoast.showToast(
              msg: "Contact number is not registered !",
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
                      TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,                      
                        inputFormatters: <TextInputFormatter>[                          
                        WhitelistingTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                          decoration: InputDecoration(
                            labelText: 'Enter your contact number',
                            
                          ),
                        ),
                        Container( 
                          margin: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(                    
                          textColor : Colors.white,    
                          onPressed: () {
                              checkContact();
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
    ),
    );           
  }
}

