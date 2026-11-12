import 'package:aitek_task/features/auth/data/rx.dart';
import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
import 'package:aitek_task/features/signals/data/rx.dart';
import 'package:aitek_task/features/signals/model/signals_response_model.dart';
import 'package:rxdart/rxdart.dart';

AuthenticationRX authenticationRXObj = AuthenticationRX(
  empty: AuthenticationResponseModel(),
  dataFetcher: BehaviorSubject<AuthenticationResponseModel>(),
);

SignalsRX signalsRXObj = SignalsRX(
  empty: SignalsResponseModel(),
  dataFetcher: BehaviorSubject<SignalsResponseModel>(),
);
