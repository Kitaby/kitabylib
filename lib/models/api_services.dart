import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitabylib/models/Get-onHold-Books-Response-model.dart';
import 'package:kitabylib/models/GetExpiredBooksResponseModel.dart';
import 'package:kitabylib/models/GetRenewRequestResponseModel.dart';
import 'package:kitabylib/models/Get_all_books_responsemodel.dart';
import 'package:kitabylib/models/acceptrequest-requestmodel.dart';
import 'package:kitabylib/models/addbooklibrequestmodel.dart';
import 'package:kitabylib/models/addbooklibresponsemodel.dart';
import 'package:kitabylib/models/get-requested-books-response-model.dart';
import 'package:kitabylib/models/getBooksresponsemodel.dart';
import 'package:kitabylib/models/get_collection_responsemodel.dart';
import 'package:kitabylib/models/get_received_offer_responsemodel.dart';
import 'package:kitabylib/models/getavailablebooksmodel.dart';
import 'package:kitabylib/models/getreservedBooksResponseModel.dart';
import 'package:kitabylib/models/givebookrequestmodel.dart';
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


   //bib api
  Future<Getavailablebooksresponsemodel> getAvalaibleBooks(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getavailablebooks +"?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },
    );
    Getavailablebooksresponsemodel responsebody = getavailablebooksresponsemodelFromJson(response.body);
    return responsebody;
  }


  Future<GetOnHoldBooksResponseModel> getOnholdBooks(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getonholdbooks +"?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },
    );
    GetOnHoldBooksResponseModel responsebody = getOnHoldBooksResponseModelFromJson(response.body);
    return responsebody;
  }

  Future<GetRequestedBooksResponseModel> getRequestedBooks(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getrequestedbooks +"?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },
    );
    GetRequestedBooksResponseModel responsebody = getRequestedBooksResponseModelFromJson(response.body);
    return responsebody;
  }


  Future<GetReservedBooksResponseModel> getReservedBooks(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getreservedbooks +"?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },);
    GetReservedBooksResponseModel responsebody = getReservedBooksResponseModelFromJson(response.body);//response same type as requestedbooks
    return responsebody;
  }

  Future<GetExpiredBooksResponseModel> getExpiredBooks(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getexpiredbooks + "?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },);
    GetExpiredBooksResponseModel responsebody = getExpiredBooksResponseModelFromJson(response.body);//response same type as requestedbooks
    return responsebody;
  }

  Future<GetRenewRequestResponseModel> getrenewRequests(int page,String name) async {
    // String? token = await getToken();
    var url = Uri.parse(config.apiURL + config.getrenewrequests +"?page=$page"+"&name="+name);
    var response = await client.get(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',
      },);
    GetRenewRequestResponseModel responsebody = getRenewRequestResponseModelFromJson(response.body);//response same type as requestedbooks
    return responsebody;
  }

  Future<dynamic> Addbooktolib( String isbn,String quantity) async {
    // String? token = await getToken();
    Addbooklibrequestmodel object =Addbooklibrequestmodel(isbn:isbn,quantity:quantity);
    var url = Uri.parse(config.apiURL + config.addbook);
    var codedobject = addbooklibrequestmodelToJson(object);
    var response = await client.post(url,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      },
     body: codedobject);
    return response.body;
  }

  Future<dynamic> acceptrequest(String id) async {
    // String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id);
    var url = Uri.parse(config.apiURL + config.acceptrequest);
    var codedobject = acceptrequestRequestModelToJson(object);
    var response = await client.patch(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> cancelreservation(String id) async {
    // String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id);
    var url = Uri.parse(config.apiURL + config.cancelreservation);
    var codedobject = acceptrequestRequestModelToJson(object);
    var response = await client.put(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> refuserequest(String id) async {
    // String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id);
    var url = Uri.parse(config.apiURL + config.refuserequest);
    var codedobject = acceptrequestRequestModelToJson(object);
    var response = await client.put(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> acceptrenewrequest(String id) async {
    // String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id);
    var url = Uri.parse(config.apiURL + config.acceptrenewrequest);
    var codedobject = acceptrequestRequestModelToJson(object);//we can use acceptrequestrequestmodel because it uses reservationId
    var response = await client.put(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> refuserenewrequest(String id) async {
    // String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id);
    var url = Uri.parse(config.apiURL + config.refuserenewrequest);//we can use acceptrequestrequestmodel because it uses reservationId
    var codedobject = acceptrequestRequestModelToJson(object);
    var response = await client.put(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }


  Future<dynamic> Reportuser(String id) async {
// String? token = await getToken();
    AcceptrequestRequestModel object =AcceptrequestRequestModel(reservationId:id); //we can use acceptrequestrequestmodel because it uses reservationId
    var url = Uri.parse(config.apiURL + config.Reportuser);
    var codedobject = acceptrequestRequestModelToJson(object);
    var response = await client.post(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> givebook(String id,String code) async {
    // String? token = await getToken();
    Givebookrequestmodel object =Givebookrequestmodel(reservationId:id,code: code); //we can use acceptrequestrequestmodel because it uses reservationId
    var url = Uri.parse(config.apiURL + config.givebook);
    var codedobject = givebookrequestmodelToJson(object);
    var response = await client.put(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }

  Future<dynamic> returnbook(String id,String code) async {
    // String? token = await getToken();
    Givebookrequestmodel object =Givebookrequestmodel(reservationId:id,code: code); //we can use acceptrequestrequestmodel because it uses reservationId
    var url = Uri.parse(config.apiURL + config.returnbook);
    var codedobject = givebookrequestmodelToJson(object);
    var response = await client.put(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiaWJJZCI6IjY2NWUzYjQxOGRhN2Q3MzdkYmJkZjVjMSIsImlhdCI6MTcxNzYwNjg4MSwiZXhwIjoxNzQzNTI2ODgxfQ.MblvDBEMfRqbIxiTcbjBWpLJWPrWRuBKj26aF0ckTac',//benhammadi lokmane
      }, body: codedobject);
    return response.body;
  }
}
