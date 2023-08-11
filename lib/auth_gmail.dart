import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmailclass/snack_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';

class AuthGmail extends StatefulWidget {
  const AuthGmail({super.key});

  @override
  State<AuthGmail> createState() => _AuthGmailState();
}

class _AuthGmailState extends State<AuthGmail> {
  final _googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user=>_user!;

  Future<void>gmailLogin()async {
    try {
      final google_user = await _googleSignin.signIn();
      if (google_user == null) {
        return;
      }
      _user = google_user;
      final google_auth = await google_user.authentication;
      final credentials = GoogleAuthProvider.credential(
          idToken: google_auth.idToken,
          accessToken: google_auth.accessToken
      );
      await FirebaseAuth.instance.signInWithCredential(credentials).whenComplete(() =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())));
      showSnackBar(context, "logged in as ${user.email}");
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gmail Auth'),
      ),
      body: Center(
        child:  ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )
          ),
          onPressed: (){
            gmailLogin();
          },
          child: Icon(Icons.g_mobiledata, size: 40, color: Color(0xFFD32F2F),),),

      ),
    );
  }
}
