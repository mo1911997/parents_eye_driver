import 'package:http/http.dart' as http;
import 'package:parentseye_driver/utilities/Constants.dart';
class VerifyOTPForMobileValidation 
{
  String url;
  VerifyOTPForMobileValidation()
  {

  }
  Future<http.Response> verifyOTPForMobileValidationFunc(String contact,int otp) async
  {
    this.url = Constants.BASE_URL+"";
    http.Response response = await http.post( 
      this.url,
      body: {
         'contact' :contact,       
         'otp' : otp
      },      
      headers: {        
        'Accept': 'application/json'
      }
    );
    print(response.body);
    return response;
  }
} 