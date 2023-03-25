import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  void makeRequest(String auth_user, String auth_pass) async {
    // Create Dio instance
    Dio dio = Dio();

    // Set request URL and data
    String url = "https://captive-portal.araquari.ifc.edu.br:8003/index.php?zone=vlan_40_route_v4";
    FormData formData = FormData.fromMap({
      "auth_user": auth_user,
      "auth_pass": auth_pass,
      "accept": "True",
    });

    // Make request
    try {
      Response response = await dio.post(url, data: formData);
      print(response.data);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Image.asset(
              "assets/logo.png",
              fit: BoxFit.contain,
              height: 52,
            ),
        elevation: 4,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
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
                    print(username.toString() + " " + password.toString());
                    // print(pref.getString("password").toString());
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
    );
  }
}