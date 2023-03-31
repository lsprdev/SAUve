// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;
  late BannerAd _bannerAd3;

  @override
  void initState() {
    super.initState();
    // Initialize banner ad
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-9983012827228298/2281220772', // Banner
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    // Initialize banner ad
    _bannerAd2 = BannerAd(
      adUnitId: 'ca-app-pub-9983012827228298/1016202577', // Banner 2
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    
    // Initialize banner ad
    _bannerAd3 = BannerAd(
      adUnitId: 'ca-app-pub-9983012827228298/5498496777', // Banner 3
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    // Load banner ad
    _bannerAd.load();
    _bannerAd2.load();
    _bannerAd3.load();
  }

  @override
  void dispose() {
    // Dispose banner ad
    _bannerAd.dispose();
    _bannerAd2.dispose();
    _bannerAd3.dispose();

    super.dispose();
  }

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
      print(response.data);
    } catch (error) {
      print(error.toString());
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
        elevation: 4,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushReplacementNamed(context, "/form");
        },
        child: Icon(Icons.person),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              height: _bannerAd2.size.height.toDouble(),
              width: _bannerAd2.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd2),
          ),
          const SizedBox(height: 260.0),
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
            const SizedBox(height: 270.0), 
            SizedBox(
              height: _bannerAd3.size.height.toDouble(),
              width: _bannerAd3.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd3),
            ),
            SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}