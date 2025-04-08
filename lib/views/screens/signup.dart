
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/auth/auth.dart';
import 'package:task_mate/providers/auth_provider.dart';
import 'package:task_mate/utils/namedrouting.dart';
import 'package:task_mate/views/screens/home.dart';
import 'package:task_mate/views/screens/sign_in.dart';

import '../../utils/kTextStyle.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthServices _auth = AuthServices();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Text("Sign Up", style: kTextStyle(size: 40)),
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'E.g. John Doe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example123@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'xxxxxx',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  context.read<AuthProvider>().createAcct(
                    context,
                        usernameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(400, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text("Sign Up"),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: kTextStyle(size: 15, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: kTextStyle(color: Colors.blue, size: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          kNavigate(context, SignInPage());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
