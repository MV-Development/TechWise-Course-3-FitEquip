import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'login.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
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
              InkWell(
                  child: Text('Login'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage(title: 'FitEquip')));
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
                              builder: (context) =>
                                  const LoginPage(title: 'FitEquip')));
                      print('button pressed!');
                    },
                    child: const Text('Next'),
                  )),
            ])));
  }
}
