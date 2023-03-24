import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AutoCaptive'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Conectar ao Captive Portal'),
            onPressed: makeRequest,
          ),
        ),
      ),
    );
  }
}