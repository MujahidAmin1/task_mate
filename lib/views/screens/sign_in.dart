import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/auth/auth.dart';
import 'package:task_mate/providers/auth_provider.dart';
import 'package:task_mate/utils/kTextStyle.dart';
import 'package:task_mate/utils/namedrouting.dart';

import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthServices _auth = AuthServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
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
              Text("Sign in", style: kTextStyle(size: 40)),
              TextField(
                cursorColor: Color(0xFF565264),
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    focusColor: Color(0xFF565264),
                    hintText: 'example123@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                cursorColor: Color(0xFF565264),
                decoration: InputDecoration(
                  focusColor: Color(0xFF565264),
                    labelText: 'Password',
                    hintText: 'xxxxxx',
                    border: OutlineInputBorder(
                      
                      borderRadius: BorderRadius.circular(6),
                    )),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthProvider>().signIn(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF071E22),
                  minimumSize: Size(400, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                child: Text("Sign in", style: kTextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Dont have an account? ",
                  style: kTextStyle(size: 15, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: kTextStyle(color: Colors.blue, size: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          kNavigate(context, SignupPage());
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
