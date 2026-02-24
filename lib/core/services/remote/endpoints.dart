
class EndPoint {

  static String localUrl = "http://lcoalhost/api/";
  static String remoteUrl = "https://IP_ADDRESS/api/";

  static String baseUrl = remoteUrl;  
  
    // auth 
  static String login = "auth/login";
  static String register = "auth/register";
  static String logout = "auth/logout";
  static String forgotPassword = "auth/forgot-password";


  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }

}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String name = "name";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";
}