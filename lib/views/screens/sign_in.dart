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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF342e37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Text("Sign in",
                  style: kTextStyle(size: 40, color: Color(0xFFfafffd))),
              const SizedBox(height: 25),
              TextField(
                cursorColor: Color(0xFFA2D729),
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFFA2D729)),
                  hintText: 'example123@gmail.com',
                  hintStyle: TextStyle(color: Color(0xFFfafffd)),
                  focusColor: Color(0xFFA2D729),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFFfafffd)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFFA2D729), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                cursorColor: Color(0xFFA2D729),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFFA2D729)),
                  hintText: 'xxxxxx',
                  hintStyle: TextStyle(color: Color(0xFFfafffd)),
                  focusColor: Color(0xFFA2D729),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Color(0xFFfafffd)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Color(0xFFA2D729), width: 2),
                  ),
                ),
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
                    backgroundColor: Color(0xFFA2D729),
                    minimumSize: Size(width, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  "Sign in",
                  style: kTextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Dont have an account? ",
                  style: kTextStyle(size: 15, color: Color(0xFFfafffd)),
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
