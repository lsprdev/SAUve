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
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      userController.text = prefs.getString("username") ?? "";
      passwordController.text = prefs.getString("password") ?? "";
    });
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                obscureText: !_passwordVisible,
                autofocus: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                   suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                        color: Colors.black,
                        ),
                      onPressed: () {
                        setState(() {
                            _passwordVisible = !_passwordVisible;
                        });
                      }),
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
              const SizedBox(height: 270.0),
              const Center(
                child: Text("Desenvolvido por: Gabriel L. P."),
              ),
            ]
          ),
        ),
      ),
    );
  }
}