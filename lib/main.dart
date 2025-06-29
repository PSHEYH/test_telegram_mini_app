import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_telegram_mini_app/components/dismiss_keyboard.dart';
import 'package:test_telegram_mini_app/modules/home/home_screen.dart';
import 'package:test_telegram_mini_app/services/connectivity_service.dart';

import 'app/routes.dart';

String get initialRoute => '/main';

Future<void> initApp() async {
  // await Firebase.initializeApp(
  //   name: "SkyRadar",
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<ConnectivityService>(
      () async => await ConnectivityService().init());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomeScreen.routeName,
      getPages: AppRoutes.routes,
      onGenerateTitle: (context) {
        return 'Test telegram mini app';
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) => DismissKeyboard(child: child),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
