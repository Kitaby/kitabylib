import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitabylib/models/Get_all_books_responsemodel.dart';
import 'package:kitabylib/models/getBooksresponsemodel.dart';
import 'package:kitabylib/models/get_collection_responsemodel.dart';
import 'package:kitabylib/models/get_received_offer_responsemodel.dart';
import 'package:kitabylib/models/phone_otp_request_model.dart';
import 'package:kitabylib/models/phone_verify_otp_request_model.dart';

import 'package:kitabylib/models/register_request_model.dart';
import 'package:kitabylib/models/resset_password_request_model.dart';
import 'PostBookInCollection_request_model.dart';
import 'package:kitabylib/models/config.dart';
import 'forgot_password_request_model.dart';
import 'login_request_model.dart';

class APISERVICES {
  var client = http.Client();
  Map<String, String> customHeaders = {"content-type": "application/json"};
  //auth apis
  Future<dynamic> login(LoginRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.loginURL);
    var codedobject = jsonEncode(object);
    var response =await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

  Future<dynamic> signup(RegisterRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.signUpURL);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

  Future<dynamic> sendotp(PhoneOtpRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.PhoneOTP);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

  Future<dynamic> verifyotp(PhoneVerifyOtpRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.VerifyOTP);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

  Future<dynamic> forgetPassword(ForgotPasswordRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.ForgotPassword);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }

  Future<dynamic> RessetPassword(RessetPasswordRequestModel object) async {
    var url = Uri.parse(config.apiURL + config.RessetPassword);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
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
