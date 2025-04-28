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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF342e37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Text("Sign Up",
                  style: kTextStyle(size: 40, color: Color(0xFFfafffd))),
              const SizedBox(height: 30),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                cursorColor: Color(0xFFA2D729),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color(0xFFA2D729)),
                  hintText: 'E.g. John Doe',
                  hintStyle: TextStyle(color: Color(0xFFfafffd)),
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
                controller: emailController,
                cursorColor: Color(0xFFA2D729),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFFA2D729)),
                  hintText: 'example123@gmail.com',
                  hintStyle: TextStyle(color: Color(0xFFfafffd)),
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
                cursorColor: Color(0xFFA2D729),
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFFA2D729)),
                  hintText: 'xxxxxx',
                  hintStyle: TextStyle(color: Color(0xFFfafffd)),
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
                    backgroundColor: Color(0xFFA2D729),
                    minimumSize: Size(width, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text("Sign Up", style: kTextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: kTextStyle(size: 15, color: Color(0xFFfafffd)),
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
