import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/database/database.dart';
import 'package:task_mate/providers/auth_provider.dart';
import 'package:task_mate/utils/kTextStyle.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    FirebaseAuth _auth = FirebaseAuth.instance;
    var username = databaseService.fetchUsername(_auth.currentUser!.uid);
    return Scaffold(
      backgroundColor: Color(0xFF342e37),
      appBar: AppBar(
        backgroundColor: Color(0xFF342e37),
        foregroundColor: Colors.white,
        title: const Text('My Profile'),
      ),
      body: FutureBuilder(
          future: username,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data!;
              return Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      child: Text(user.substring(0, 1),
                          style: kTextStyle(size: 35, isBold: true)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      user,
                      style: kTextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            } else {
              return Text('no username');
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Color(0xFF342e37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFfafffd),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                content: Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(
                    color: Color(0xD9fafffd),
                    fontSize: 16,
                  ),
                ),
                actionsPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFFA2D729),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      context.read<AuthProvider>().logout(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFA2D729),
                      foregroundColor: Color(0xFF342e37),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          },
          child: Text("logout")),
    );
  }
}
