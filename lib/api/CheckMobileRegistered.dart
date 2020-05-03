import 'package:http/http.dart' as http;
import 'package:parentseye_driver/utilities/Constants.dart';
class CheckMobileRegistered 
{
  String url;
  CheckMobileRegistered()
  {

  }
  Future<http.Response> checkMobileRegisteredFunc(String contact) async
  {
    this.url = Constants.BASE_URL+"";
    http.Response response = await http.post( 
      this.url,
      body: {
         'contact':contact,        
      },      
      headers: {
        'Accept': 'application/json'
      }
    );
    print(response.body);
    return response;
  }
}