import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/route/generate_route.dart';
import 'package:traka/core/route/keys.dart';

import 'core/route/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          title: 'Traka',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RouteKeys.auth,
          onGenerateRoute: generateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
        );
      },
    );
  }
}
