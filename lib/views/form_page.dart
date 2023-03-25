import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {

  FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
                height: 72,
              ),
              const SizedBox(height: 20.0),
             TextField(
                controller: userController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Usuário',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center, 
                child: MaterialButton(
                  height: 45.0,
                  minWidth: 300.0,
                  color: Colors.black,
                  onPressed: () async {
                    Navigator.pushNamed(context, "/button");
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isData", true);
                    prefs.setString("username", userController.text);
                    prefs.setString("password", passwordController.text);
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}