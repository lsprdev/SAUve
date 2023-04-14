// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {

  @override
  Widget build(BuildContext context) {

    Future<void> makeRequest(String authUser, String authPass) async {
    // Create Dio instance
    Dio dio = Dio();

    // Set request URL and data
    String url = "https://captive-portal.araquari.ifc.edu.br:8003/index.php?zone=vlan_40_route_v4";
    FormData formData = FormData.fromMap({
      "auth_user": authUser,
      "auth_pass": authPass,
      "accept": "True",
    });

    // Make request
    try {
      Response response = await dio.post(url, data: formData);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Image.asset(
              "assets/logo.png",
              fit: BoxFit.contain,
              height: 52,
            ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () {
              Navigator.pushNamed(context, "/classes");
            },
          ),
          // IconButton(
          //   onPressed: () {}, 
          //   icon: const Icon(Icons.restaurant_menu)
          // ),
          // IconButton(
          //   icon: const Icon(Icons.favorite_border), 
          //   onPressed: () {},
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushReplacementNamed(context, "/form");
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.person),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: MaterialButton(
                      height: 55.0,
                      minWidth: 250.0,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? username = prefs.getString("username");
                        String? password = prefs.getString("password");
                        makeRequest(username.toString(), password.toString());
                        try {
                          final result = await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                            const snackbar = SnackBar(content: Text('Conectado à internet'), backgroundColor: Colors.green);
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                        } on SocketException catch (_) {
                          const snackbar = SnackBar(content: Text('Não foi possível conectar à internet'), backgroundColor: Colors.red); 
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }

                      },
                      child: const Text(
                        'Conectar à internet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        )
                      ),
                    )
            ),
            const SizedBox(height: 10.0),
            
            
        ],
      ),
    );
  }
}