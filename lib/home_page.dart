import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_gmail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future logout() async{
    final FirebaseAuth auth = await FirebaseAuth.instance;
    print(_googleSignIn.currentUser);
    if(await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    }
    auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthGmail()));
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gmail Auth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            Text(user.displayName.toString()),
            Text(user.email.toString()),
            TextButton(onPressed: (){
              logout();
            },
                child: Text('LOGOUT'))
          ],
        ),
      ),
    );
  }
}
