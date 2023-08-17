import 'package:workout_program/login.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final emailController = TextEditingController();
  var alertMessage = '';
  sendReset(email) async {
    try {
      final resEmail =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-notfound') {
        setState(() {
          alertMessage = 'No user found for that email.';
        });
      }
    }
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
            'Reset Password',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 500, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  print('button pressed!');
                  sendReset(emailController.text);
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(color: Colors.black),
                ),
              )),
          InkWell(
              child: Text(
                "Click here to login",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(title: 'FitEquip')));
              })
        ])));
  }
}
