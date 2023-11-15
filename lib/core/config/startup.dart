import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:traka/core/data/local_storage.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/services/ably_service.dart';
import 'package:traka/features/home/cubit/home_cubit.dart';
import 'package:traka/firebase_options.dart';
import 'package:traka/features/auth/cubit/auth_cubit.dart';
import 'package:traka/features/auth/services/service.dart';

final GetIt locator = GetIt.I;

Future<void> initializeServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initAbly();

  locator.registerSingleton<AuthCubit>(AuthCubit(AuthService()));
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<HomeCubit>(HomeCubit(locator<AblyService>()));

  const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  locator.registerSingleton<LocalStorage>(
      LocalStorage(flutterSecureStorage: flutterSecureStorage));
}

Future<void> _initAbly() async {
  String ablyToken = const String.fromEnvironment("ABLY_TOKEN");
  final ably.ClientOptions clientOptions = ably.ClientOptions(key: ablyToken);
  ably.Realtime realtime = ably.Realtime(options: clientOptions);
  await realtime.connect();

  locator.registerSingleton<AblyService>(AblyService(realtime));
}
