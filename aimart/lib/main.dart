import 'package:aimart/config/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'bindings/bindings.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: KHALTIAPIKEY,
        builder: (context, navKey) {
          return GetMaterialApp(
            title: "Ai Mart",
            debugShowCheckedModeBanner: false,
            navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            initialBinding: InstanceBinding(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        });
  }
}
