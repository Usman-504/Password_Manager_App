import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/ui/screens/add_password/add_password_provider.dart';
import 'package:password_manager/ui/screens/home_screen/home_provider.dart';
import 'package:password_manager/ui/screens/login_screen/login_provider.dart';
import 'package:password_manager/ui/screens/signup_screen/signup_provider.dart';
import 'package:password_manager/ui/screens/splash_screen/splash_screen.dart';
import 'package:password_manager/ui/screens/update_screen/update_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => SignupProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => AddPasswordProvider()),
      ChangeNotifierProvider(create: (_) => UpdateProvider()),

    ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

