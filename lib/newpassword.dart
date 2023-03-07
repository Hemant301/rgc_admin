import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cpwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFB800),
        centerTitle: true,
        title: const Text('Change Password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: pwdController,
              decoration: const InputDecoration(hintText: 'New Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: cpwdController,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (emailController.text == "" ||
                    pwdController.text == "" ||
                    cpwdController.text == "") {
                  showTextToast(text: "Enter all fields", context: context);
                  return;
                } else if (pwdController.text != cpwdController.text) {
                  showTextToast(
                      text: "Password does not match", context: context);
                  return;
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                child: const Center(child: Text("Submit")),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
