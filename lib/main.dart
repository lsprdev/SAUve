import 'package:auto_captive/views/button_page.dart';
import 'package:auto_captive/views/form_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoCaptive',
      initialRoute: "/",
      routes: {
        "/": (context) => const FormPage(),
        "/button": (context) => const ButtonPage(),
      },
    );
  }
}