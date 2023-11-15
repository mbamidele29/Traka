import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:traka/core/services/ably_service.dart';
// import 'package:traka/features/auth/cubit/auth_cubit.dart';
// import 'package:traka/features/auth/services/service.dart';

final GetIt locator = GetIt.I;

Future<void> initializeServices() async {
  // await Firebase.initializeApp();
  await _initAbly();

  // locator.registerSingleton<AuthCubit>(AuthCubit(AuthService()));
}

Future<void> _initAbly() async {
  String ablyToken = const String.fromEnvironment("ABLY_TOKEN");
  final ably.ClientOptions clientOptions = ably.ClientOptions(key: ablyToken);
  ably.Realtime realtime = ably.Realtime(options: clientOptions);
  await realtime.connect();

  locator.registerSingleton<AblyService>(AblyService(realtime));
}
