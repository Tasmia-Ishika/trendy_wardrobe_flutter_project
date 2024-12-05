class API{
  static const hostConnect = "http://192.168.0.102/api_clothes_store";
  static const hostConnectUser = "$hostConnect/user";

  //signup user
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";
}
