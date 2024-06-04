
import 'package:http/http.dart' as http;
import 'package:kitabylib/models/Get_all_books_responsemodel.dart';
import 'package:kitabylib/models/auth/message_model.dart';
import 'package:kitabylib/models/getBooksresponsemodel.dart';
import 'package:kitabylib/models/get_collection_responsemodel.dart';
import 'package:kitabylib/models/get_received_offer_responsemodel.dart';
import 'package:kitabylib/models/auth/send_otp_request.dart';
import 'package:kitabylib/models/auth/send_otp_response.dart';
import 'package:kitabylib/models/auth/verify_otp_request.dart';

import 'package:kitabylib/models/auth/signUp_request.dart';
import 'package:kitabylib/models/auth/login_response_model.dart';
import 'package:kitabylib/models/resset_password_request_model.dart';
import 'package:kitabylib/models/auth/verify_otp_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PostBookInCollection_request_model.dart';
import 'package:kitabylib/models/config.dart';
import 'forgot_password_request_model.dart';
import 'auth/login_request_model.dart';

class APISERVICES {
  var client = http.Client();
  Map<String, String> customHeaders = {"content-type": "application/json"};
  //auth apis
  Future<LoginResponseModel> login(LoginRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.loginURL);
    String codedobject = loginRequestModelToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    LoginResponseModel responsebody = loginResponseModelFromJson(response.body);
    if (response.statusCode == 200) {
      setToken(responsebody.token!);
    }
    return responsebody;
  }

  Future<MessageModel> signup(SignupRequest object) async {
    var url = Uri.parse(config.apiURL + config.signUpURL);
    String codedobject = signupRequestToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    MessageModel responsebody =
        messageModelFromJson(response.body);
    return responsebody;
  }

  Future<SendOtpResponse> sendotp(SendOtpRequest object) async {
    var url = Uri.parse(config.apiURL + config.PhoneOTP);
    String codedobject = sendOtpRequestToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    SendOtpResponse responsebody =
        sendOtpResponseFromJson(response.body);
    return responsebody;
  }

  Future<VerifyOtpResponse> verifyotp(
      VerifyOtpRequest object) async {
    var url = Uri.parse(config.apiURL + config.VerifyOTP);
    String codedobject = verifyOtpRequestToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    VerifyOtpResponse responsebody =
        verifyOtpResponseFromJson(response.body);
    return responsebody;
  }

  Future<MessageModel> forgetPassword(
      ForgotPasswordRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.ForgotPassword);
    String codedobject = forgotPasswordRequestModelToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    MessageModel responsebody =
        messageModelFromJson(response.body);
    return responsebody;
  }

  Future<MessageModel> ressetPassword(
      RessetPasswordRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.RessetPassword);
    String codedobject = ressetPasswordRequestModelToJson(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    MessageModel responsebody =
        messageModelFromJson(response.body);
    return responsebody;
  }

  //homepage api
  Future<Getcollectionresponsemodel> getCollection(String id,int page) async {
    var url = Uri.parse(config.apiURL + config.GetCollection + id+"?page=$page");
    var response = await client.get(url);
    Getcollectionresponsemodel responsebody = getcollectionresponsemodelFromJson(response.body);
    return responsebody;
  }
   Future<Getcollectionresponsemodel> getWishlist(String id,int page) async {
    var url = Uri.parse(config.apiURL + config.GetWishList + id+"?page=$page");
    var response = await client.get(url);
    Getcollectionresponsemodel responsebody = getcollectionresponsemodelFromJson(response.body);
    return responsebody;
  }

  

  //profile api
  Future<dynamic> PostBookInCollectionAPI(String id, String isbn) async {
    PostBookInCollection object = PostBookInCollection(id: id, isbn: isbn);
    var url = Uri.parse(config.apiURL + config.PostBookInCollection);
    var codedobject = postBookInCollectionToJson(object);
    var response = await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

   Future<dynamic> PostBookInWishlist(String id, String isbn) async {
    PostBookInCollection object = PostBookInCollection(id: id, isbn: isbn);
    var url = Uri.parse(config.apiURL + config.PostBookInWishlist);
    var codedobject = postBookInCollectionToJson(object);
    var response = await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }
    //offers api
  Future<Getallbooksresponse> getallbooks(String page) async {
    var url = Uri.parse(config.apiURL + config.getallbooks+"?page=$page&limit=8");
    var response = await client.get(url);
    Getallbooksresponse responsebody = getallbooksresponseFromJson(response.body);
    return responsebody;
  }
  //getreceivedoffers
  Future<ReceivedOffersResponseModel ?> getreceivedoffers(String id ,int page) async {
    var url = Uri.parse(config.apiURL + config.getreceivedoffers+"$id?page=$page&limit=8");
    var response = await client.get(url);
    ReceivedOffersResponseModel responsebody=receivedOffersResponseModelFromJson(response.body);
    if(response.statusCode==200){
      return responsebody;
    }else{
      return null;
    }
  }

  Future<Getbooksresponsemodel ?> getBooks(String name,int page) async {
    var url = Uri.parse(config.apiURL + config.getbooks+"?page=$page&limit=8&name=$name");
    var response = await client.get(url);
    Getbooksresponsemodel  responsebody=getbooksresponsemodelFromJson(response.body);
    if(response.statusCode==200){
      return responsebody;
    }else{
      return null;
    }
  }
}

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
