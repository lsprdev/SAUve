import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  void makeRequest() async {
    // Create Dio instance
    Dio dio = Dio();

    // Set request URL and data
    String url = "https://captive-portal.araquari.ifc.edu.br:8003/index.php?zone=vlan_40_route_v4";
    FormData formData = FormData.fromMap({
      "auth_user": "",
      "auth_pass": "",
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
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
          child: MaterialButton(
                  height: 45.0,
                  minWidth: 250.0,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: const Text(
                    'Conectar ao Captive Portal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                )
        ),
    );
  }
}