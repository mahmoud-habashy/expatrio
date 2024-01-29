class AppConfig {
  static const String baseUrl = "https://dev-api.expatrio.com";

  static const String loginUrl = "$baseUrl/auth/login";
  static const String getUserUrl = "$baseUrl/portal/users";
  static const String getTaxDataUrl = "$baseUrl/v3/customers";
  static const String updateTaxDataUrl = "$baseUrl/v3/customers";
}

class AppSecureStorageKey {
  static const String loginAuthDataKey = "auth_login_data";
  static const String loginTokenKey = "token_data";
  static const String userDataKey = "user_data";
  static const String taxDataKey = "tax_data";
}

class AppRoutes {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String dashboardScreen = "/dashboard";
}
