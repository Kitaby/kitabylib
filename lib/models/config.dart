class config {
  static String apiURL = "http://172.20.10.2:3000/api";
  //auth liks
  static String loginURL = "/auth/login";
  static String signUpURL = "/auth/signup";
  static String PhoneOTP = "/auth/send_otp";
  static String VerifyOTP = "/auth/verify_otp";
  static String VerifyEmail = "/auth/verify_email";
  static String ForgotPassword = "/auth/forgot_password";
  static String RessetPassword = "/auth/reset_password";
  //Homepage links
  static String GetCollection = '/home/getCollection/';
  static String GetWishList = '/home/getWishlist/';
  //profil links
  static String PostBookInCollection = '/profile/postBookInCollection';
  static String PostBookInWishlist = '/profile/postInWishList';
  //offers
  static String getbook="/home/getBook";
  static String getbooks="/home/getBooks";
  static String getallbooks="/home/getAllBooks";
  static String getreceivedoffers="/offers/getReceivedOffers/";
  static String getsentoffers="/offers//getSentOffers/";
  //bib
  static String getavailablebooks="/bib/getAvalaibleBooks/";
  static String getonholdbooks="/bib/getOnHoldBooks/";
  static String getrequestedbooks="/bib/getRequestedBooks/";
  static String getreservedbooks="/bib/getReservedBooks/";
  static String getexpiredbooks="/bib/getExpiredBooks/";
  static String getrenewrequests="/bib/getRenewRequests/";
  static String cancelreservation="/bib/cancaelReservation"; 
  static String acceptrequest="/bib/acceptBookRequest"; 
  static String refuserequest="/bib/refuseBookRequest"; 
  static String acceptrenewrequest="/bib/acceptRenewRequest";
  static String refuserenewrequest="/bib/refuseRenewRequest";
  static String Reportuser="/bib/reportUser"; 
  static String givebook="/bib/giveBook"; 
  static String returnbook="/bib/returnBook"; 
  static String addbook="/bib/addBook";
}
