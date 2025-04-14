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
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      body: Center(),
      floatingActionButton: MaterialButton(
        minWidth: screenWidth * 0.8,
        onPressed: (){

        }
        ),
    );
  }
}
