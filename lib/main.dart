import 'package:auto_captive/views/button_page.dart';
import 'package:auto_captive/views/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance(); 
  var isData = prefs.getBool("isData");
  var username = prefs.getString("username");
  var password = prefs.getString("password");
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp(isData: isData, username: username, password: password)));
}

class MyApp extends StatelessWidget {
  final bool? isData;
  final String? username;
  final String? password;
  const MyApp({super.key, required this.isData, this.username, this.password});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAUve',
      initialRoute: isData == true ? '/button' : '/',
      routes: {
        "/": (context) => FormPage(),
        "/button": (context) => const ButtonPage(),
      },
    );
  }
}