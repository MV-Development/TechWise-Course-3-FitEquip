import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'register.dart';

import 'database_functionality.dart';
import 'muscle_select.dart';
import 'equip_select.dart';
import 'exercises.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Login'),
            leading: Image.asset('assets/FitEquipLogo.png')),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              InkWell(
                  child: Text('Register'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  }),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 300, vertical: 15),
                  child: TextField(
                      decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email, ex: abcd@gmail.com',
                  ))),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 300, vertical: 15),
                  child: TextField(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PartSelect()));
                      print('button pressed!');
                    },
                    child: const Text('Next'),
                  )),
            ])));
  }
}
