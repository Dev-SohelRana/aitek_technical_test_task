// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
const String url = "https://suggession.impronay.xyz/api";

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

final class Endpoints {
  Endpoints._();
  //backend_url
  static String register() => "/auth/register";
  static String registerOtpVerify() => "/auth/email-verify";
  static String registerResendOtp() => "/auth/resend-otp";
  static String login() => "/auth/login";
  static String logout() => "/auth/logout";
  static String deleteAccount() => "/auth/delete";

  static String forgotPassword() => "/password/forget";
  static String forgotPasswordVerifyOtp() => "/password/verify-email";
  static String forgotChangePassword() => "/password/new";
  static String getProfileDetails() => "/user/profile";
  static String profileDetailsUpdate() => "/user/update";
  static String updatePassword() => "/user/update/password";
  static String getClassList() => "/class/list";
  static String updateClass() => "/user/update/class";
  static String subjectList() => "/subject/list";
  static String subjectChaptersList({required int subjectId}) =>
      "/subject/chapters/$subjectId";
  static String suggestionDetailsList({required int chapterId}) =>
      "/subject/suggessions/$chapterId";
  static String getFreeCourseList() => "/courses";
  static String getPremiumCourseList() => "/courses/paid";
  static String getImportantSuggestionList() =>
      "/subject/important/suggessions";
  static String getCourseTopicList({required int courseId}) =>
      "/courses/videos/$courseId";
  static String getHomeDashboard() => "/quiz/dashboard";

  // static String myListingDetailsInfoById(int id) =>
  //     "/sell-or-rent/information/$id";
}
