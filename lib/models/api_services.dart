import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitabylib/models/config.dart';
import 'package:kitabylib/models/phone_otp_request_model.dart';
import 'package:kitabylib/models/phone_verify_otp_request_model.dart';
import 'package:kitabylib/models/register_request_model.dart';
import 'package:kitabylib/models/resset_password_request_model.dart';
import 'PostBookInCollection_request_model.dart';

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
  Future<List> getmybooks(String id) async {
    var url = Uri.parse(config.apiURL + config.GetCollection + id);
    var response = await client.get(url);
    List responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future<List> getwishlist(String id) async {
    var url = Uri.parse(config.apiURL + config.GetWishList + id);
    var response = await client.get(url);
    List responsebody = jsonDecode(response.body);
    return responsebody;
  }

  //profile api
  Future<dynamic> PostBookInCollectionAPI(String id, String isbn) async {
    PostBookInCollection object = PostBookInCollection(id: id, isbn: isbn);
    var url = Uri.parse(config.apiURL + config.PostBookInCollection);
    var codedobject = jsonEncode(object);
    var response =
        await client.post(url, headers: customHeaders, body: codedobject);
    return response.body;
  }
}
