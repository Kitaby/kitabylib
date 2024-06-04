class config {
  static String apiURL = "http://192.168.237.37:3000/api";
  //auth liks
  static String loginURL = "/bib/auth/login";
  static String signUpURL = "/bib/auth/signup";
  static String PhoneOTP = "/bib/auth/send_otp";
  static String VerifyOTP = "/bib/auth/verify_otp";
  static String VerifyEmail = "/bib/auth/verify_email";
  static String ForgotPassword = "/bib/auth/forgot_password";
  static String RessetPassword = "/bib/auth/reset_password";
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
}
