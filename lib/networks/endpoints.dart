// ignore_for_file: constant_identifier_names

const String url = ForexEndpoints.partnerBaseUrl;

final class NetworkConstants {
  NetworkConstants._();

  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class ForexEndpoints {
  ForexEndpoints._();

  static const String peanutBaseUrl = "https://peanut.ifxdb.com";

  static const String partnerBaseUrl = "https://client-api.contentdatapro.com";

  static String isAccountCredentialsCorrect() =>
      "$peanutBaseUrl/api/ClientCabinetBasic/IsAccountCredentialsCorrect";

  static String requestMobileCabinetApiToken() =>
      "$partnerBaseUrl/api/Authentication/RequestMoblieCabinetApiToken";

  static String getAccountInformation() =>
      "$peanutBaseUrl/api/ClientCabinetBasic/GetAccountInformation";

  static String getLastFourNumbersPhone() =>
      "$peanutBaseUrl/api/ClientCabinetBasic/GetLastFourNumbersPhone";

  static String getAnalyticSignals(String login) =>
      "$partnerBaseUrl/clientmobile/GetAnalyticSignals/${Uri.encodeComponent(login)}";

  static const String cabinetMicroServiceUrl =
      "https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc";
}
