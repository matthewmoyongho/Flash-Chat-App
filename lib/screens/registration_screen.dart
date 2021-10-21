import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/contant.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flash_chat_app/widgets/button.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            Button(
              onPressed: () async {
                try {
                  final user = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);

                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on AuthCredential catch (e) {
                  print(e);
                }
              },
              btnText: 'Register',
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
