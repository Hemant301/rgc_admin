import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:rgc_admin/apicall/api.dart';
import 'package:rgc_admin/util/userCred.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController pwdCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/RGC logo golden real.png",
                height: 80,
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome !",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailCon,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pwdCon,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(
                      Icons.password,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              GradientButtonFb4(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (emailCon.text == "" || pwdCon.text == "") {
                    showTextToast(
                        text: "Enter email and password", context: context);
                    return;
                  }
                  HomeApi api = HomeApi();
                  Map data = await api.login(context,
                      email: emailCon.text, pwd: pwdCon.text);
                  if (data['status'].toString() == "200") {
                    userCred.addUserId(data['user']['_id'].toString());
                    Navigator.pushNamed(context, '/gest_approval');
                  }
                },
                text: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GradientButtonFb4 extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GradientButtonFb4(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  final double borderRadius = 25;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: const LinearGradient(
                colors: [Colors.amber, Color.fromARGB(255, 255, 191, 0)])),
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                alignment: Alignment.center,
                padding: MaterialStateProperty.all(const EdgeInsets.only(
                    right: 75, left: 75, top: 15, bottom: 15)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                )),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(color: Colors.black),
            )));
  }
}
