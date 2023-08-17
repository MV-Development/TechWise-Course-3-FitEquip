import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'muscle_select.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  var alertMessage = '';
  loginUser(email, password) async {
    try {
      /*final credential =*/ await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      nextPage();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          alertMessage = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          alertMessage = 'Wrong password provided for that user.';
        });
      }
    }
  }

  nextPage() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('user signed in');
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PartSelect()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 150,
                maxWidth: 350,
              ),
              child: Image.asset(
                'assets/FitEquipLogo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Log In',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 300, vertical: 15),
              child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email, ex: abcd@gmail.com',
                  ))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 300, vertical: 15),
              child: TextField(
                  controller: passController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter valid password',
                  ))),
          Text(alertMessage),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 500, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  print('button pressed!');
                  loginUser(emailController.text, passController.text);
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(color: Colors.black),
                ),
              )),
          InkWell(
              child: Text(
                "Don't have an account? Register here!",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              }),
        ])));
  }
}
