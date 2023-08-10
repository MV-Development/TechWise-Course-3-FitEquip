// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'login.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  registerUser(email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('This account already exists');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Register'),
            leading: Image.asset('assets/FitEquipLogo.png')),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 150, // Set a minimum width
                      maxWidth: 350, // Set a maximum width
                    ),
                    child: Image.asset(
                      'assets/FitEquipLogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              InkWell(
                  child: Text('Click here to login'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage(title: 'FitEquip')));
                  }),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter valid password',
                      ))),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 500, vertical: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser(emailController.text, passController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(title: 'FitEquip')));
                      print('button pressed!');
                    },
                    child: const Text('Next'),
                  )),
            ])));
  }
}
