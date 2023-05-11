import 'package:awsome_app/pages/home_page.dart';
import 'package:awsome_app/pages/home_page_with_fb.dart';
import 'package:awsome_app/pages/login_page.dart';
import 'package:awsome_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs   =await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Awsome app",
    home: Constants.prefs.getBool("loggedIn")==true
    ? HomePageWithFB()
    :LoginPage(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    routes: {
      "/login": (context) => LoginPage(),
      "/home": (context) => HomePage()
    },
  ));
}
