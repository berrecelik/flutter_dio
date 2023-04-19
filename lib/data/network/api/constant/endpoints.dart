class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://reqres.in/api";
  static final Duration receiveTimeout = Duration(milliseconds: 15000);
  static final Duration connectionTimeout = Duration(milliseconds: 15000);
  static const String users = '/users';
}
