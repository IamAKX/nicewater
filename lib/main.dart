import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_water/screens/home_container/home_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'utils/router.dart';

late SharedPreferences prefs;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nice Water',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
        textTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme.apply()),
      ),
      home: const HomeContainer(),
      navigatorKey: navigatorKey,
      onGenerateRoute: NavRoute.generatedRoute,
    );
  }
}
