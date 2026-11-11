import 'dart:developer';

import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/features/auth/data/api.dart';
import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:aitek_task/networks/dio/dio.dart';
import 'package:aitek_task/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class AuthenticationRX
    extends RxResponseInt<AuthenticationResponseModel> {
  final api = AuthenticationApi.instance;

  AuthenticationRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  // Login / Re-authentication
  Future<bool> authenticationRX({
    required String login,
    required String password,
  }) async {
    try {
      // Peanut Authentication
      AuthenticationResponseModel peanutData = await api.authenticationApi(
        login: login,
        password: password,
      );

      if (peanutData.result != true ||
          peanutData.token == null ||
          peanutData.token!.isEmpty) {
        throw Exception('Invalid account credentials');
      }

      // Partner Token
      String partnerToken = await api.partnerTokenApi(
        login: login,
        password: password,
      );

      if (partnerToken.isEmpty || partnerToken == 'null') {
        throw Exception('Partner token not found');
      }

      // Save tokens separately
      await appData.write(kKeyPeanutToken, peanutData.token);

      await appData.write(kKeyPartnerToken, partnerToken);

      // Existing access token uses Partner token
      await appData.write(kKeyAccessToken, partnerToken);

      await appData.write(kKeyIsLoggedIn, true);

      // Update Dio with Partner token
      DioSingleton.instance.update(partnerToken);

      handleSuccessWithReturn(peanutData);

      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  // Restore session when app starts
  Future<bool> restoreSessionRX() async {
    try {
      final String? peanutToken = appData.read(kKeyPeanutToken);

      final String? partnerToken = appData.read(kKeyPartnerToken);

      final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;

      if (!isLoggedIn ||
          peanutToken == null ||
          peanutToken.isEmpty ||
          partnerToken == null ||
          partnerToken.isEmpty) {
        await logoutRX();
        return false;
      }

      DioSingleton.instance.update(partnerToken);

      return true;
    } catch (error) {
      log('Session restore error: $error');
      await logoutRX();
      return false;
    }
  }

  // Logout / clear session
  Future<void> logoutRX() async {
    await appData.remove(kKeyPeanutToken);
    await appData.remove(kKeyPartnerToken);
    await appData.remove(kKeyAccessToken);
    await appData.write(kKeyIsLoggedIn, false);

    // Reset Dio without an authenticated token
    DioSingleton.instance.create();

    dataFetcher.sink.add(empty);
  }

  @override
  handleSuccessWithReturn(AuthenticationResponseModel data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}

////
// import 'dart:developer';

// import 'package:aitek_task/constants/app_constants.dart';
// import 'package:aitek_task/features/auth/data/api.dart';
// import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
// import 'package:aitek_task/helpers/di.dart';
// import 'package:aitek_task/networks/dio/dio.dart';
// import 'package:aitek_task/networks/rx_base.dart';
// import 'package:rxdart/rxdart.dart';

// final class AuthenticationRX
//     extends RxResponseInt<AuthenticationResponseModel> {
//   final api = AuthenticationApi.instance;

//   AuthenticationRX({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> authenticationRX({
//     required String login,
//     required String password,
//   }) async {
//     try {
//       // Peanut Authentication
//       AuthenticationResponseModel data = await api.authenticationApi(
//         login: login,
//         password: password,
//       );

//       if (data.result != true || data.token == null || data.token!.isEmpty) {
//         throw Exception('Invalid account credentials');
//       }

//       // Partner Token
//       String partnerToken = await api.partnerTokenApi(
//         login: login,
//         password: password,
//       );

//       if (partnerToken.isEmpty) {
//         throw Exception('Partner token not found');
//       }

//       handleSuccessWithReturn(data);

//       // Save both tokens separately
//       appData.write(kKeyPeanutToken, data.token);
//       appData.write(kKeyPartnerToken, partnerToken);

//       // Keep existing access token for Partner API
//       appData.write(kKeyAccessToken, partnerToken);
//       appData.write(kKeyIsLoggedIn, true);

//       // Update Dio with Partner token
//       DioSingleton.instance.update(partnerToken);

//       return true;
//     } catch (error) {
//       return handleErrorWithReturn(error);
//     }
//   }

//   @override
//   handleSuccessWithReturn(AuthenticationResponseModel data) {
//     dataFetcher.sink.add(data);
//     return data;
//   }

//   @override
//   handleErrorWithReturn(dynamic error) {
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//     return false;
//   }
// }

// import 'dart:developer';

// import 'package:aitek_task/constants/app_constants.dart';
// import 'package:aitek_task/features/auth/data/api.dart';
// import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
// import 'package:aitek_task/helpers/di.dart';
// import 'package:aitek_task/networks/dio/dio.dart';
// import 'package:aitek_task/networks/rx_base.dart';
// import 'package:rxdart/rxdart.dart';

// final class AuthenticationRX
//     extends RxResponseInt<AuthenticationResponseModel> {
//   final api = AuthenticationApi.instance;

//   AuthenticationRX({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;
//   Future<bool> authenticationRX({
//     required String login,
//     required String password,
//   }) async {
//     try {
//       AuthenticationResponseModel data = await api.authenticationApi(
//         login: login,
//         password: password,
//       );

//       String partnerToken = await api.partnerTokenApi(
//         login: login,
//         password: password,
//       );

//       if (partnerToken.isEmpty) {
//         throw Exception('Partner token not found');
//       }

//       appData.write(kKeyAccessToken, partnerToken);
//       appData.write(kKeyIsLoggedIn, true);

//       DioSingleton.instance.update(partnerToken);

//       handleSuccessWithReturn(data);
//       return true;
//     } catch (error) {
//       return handleErrorWithReturn(error);
//     }
//   }

//   // Future<bool> authenticationRX({
//   //   required String login,
//   //   required String password,
//   // }) async {
//   //   try {
//   //     // Peanut Authentication
//   //     await api.authenticationApi(login: login, password: password);

//   //     // Partner Token
//   //     AuthenticationResponseModel data = await api.partnerTokenApi(
//   //       login: login,
//   //       password: password,
//   //     );

//   //     final String partnerToken = data.data.toString();

//   //     if (partnerToken.isEmpty || partnerToken == 'null') {
//   //       throw Exception('Partner token not found');
//   //     }

//   //     handleSuccessWithReturn(data);
//   //     return true;
//   //   } catch (error) {
//   //     return handleErrorWithReturn(error);
//   //   }
//   // }

//   @override
//   handleSuccessWithReturn(AuthenticationResponseModel data) {
//     final String partnerToken = data.data.toString();

//     appData.write(kKeyAccessToken, partnerToken);
//     appData.write(kKeyIsLoggedIn, true);

//     DioSingleton.instance.update(partnerToken);

//     dataFetcher.sink.add(data);
//     return data;
//   }

//   @override
//   handleErrorWithReturn(dynamic error) {
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//     return false;
//   }
// }

// // import 'dart:developer';

// // import 'package:aitek_task/constants/app_constants.dart';
// // import 'package:aitek_task/features/auth/data/api.dart';
// // import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
// // import 'package:aitek_task/helpers/di.dart';
// // import 'package:aitek_task/networks/rx_base.dart';
// // import 'package:rxdart/rxdart.dart';

// // final class AuthenticationRX
// //     extends RxResponseInt<AuthenticationResponseModel> {
// //   final api = AuthenticationApi.instance;

// //   AuthenticationRX({required super.empty, required super.dataFetcher});

// //   ValueStream get getFileData => dataFetcher.stream;

// //   Future<bool> authenticationRX({
// //     required String login,
// //     required String password,
// //   }) async {
// //     try {
// //       AuthenticationResponseModel data = await api.authenticationApi(
// //         login: login,
// //         password: password,
// //       );

// //       handleSuccessWithReturn(data);
// //       return true;
// //     } catch (error) {
// //       return handleErrorWithReturn(error);
// //     }
// //   }

// //   @override
// //   handleSuccessWithReturn(AuthenticationResponseModel data) {
// //     appData.write(kKeyAccessToken, partnerToken);
// //     appData.write(kKeyIsLoggedIn, true);
// //     DioSingleton.instance.update(partnerToken);
// //     dataFetcher.sink.add(data);
// //     return data;
// //   }

// //   @override
// //   handleErrorWithReturn(dynamic error) {
// //     log(error.toString());

// //     dataFetcher.sink.addError(error);

// //     return false;
// //   }
// // }
