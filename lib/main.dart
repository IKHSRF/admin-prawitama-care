import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/style.dart';
import 'package:prawitama_care_admin/pages/home_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: textTheme,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (_) => HomePage(),
      },
    );
  }
}
