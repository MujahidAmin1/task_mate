import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/auth/auth.dart';
import 'package:task_mate/providers/auth_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  context.read<AuthProvider>().logout(context);
                },
                child: Text("logout"))
          ],
        ),
        body: Center());
  }
}
