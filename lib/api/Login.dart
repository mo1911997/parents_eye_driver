import 'package:http/http.dart' as http;
import 'package:parentseye_driver/utilities/Constants.dart';
class Login 
{
  String url;
  Login()
  {

  }
  Future<http.Response> loginFunc(String contact,String password) async
  {
    this.url = Constants.BASE_URL+"";
    http.Response response = await http.post( 
      this.url,
      body: {
         'contact':contact,
        'password' :password
      },      
      headers: {
        'Accept': 'application/json'
      }
    );
    print(response.body);
    return response;
  }
}