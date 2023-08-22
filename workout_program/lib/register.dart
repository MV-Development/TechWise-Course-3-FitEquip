import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  var alertMessage = '';
  registerUser(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      setState(() {
        alertMessage = 'Success!';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          alertMessage = 'Password is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          alertMessage = 'Email already in use.';
        });
      }
    } catch (e) {
      setState(() {
        alertMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
            'Register',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: 15),
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: 15),
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
                  EdgeInsets.symmetric(horizontal: screenWidth*0.25, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  registerUser(emailController.text, passController.text);
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(color: Colors.black),
                ),
              )),
          InkWell(
              child: Text(
                'Already have an account? Click here to login',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(title: 'FitEquip')));
              }),
        ])));
  }
}
