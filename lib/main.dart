import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/style.dart';
import 'package:prawitama_care_admin/pages/donation_page.dart';
import 'package:prawitama_care_admin/pages/login_page.dart';
import 'package:prawitama_care_admin/pages/home_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/program_image_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePathUrl(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: textTheme,
        ),
        initialRoute: LoginPage.id,
        routes: {
          HomePage.id: (_) => HomePage(),
          Donation.id: (_) => Donation(),
          LoginPage.id: (_) => LoginPage(),
        },
      ),
    );
  }
}
