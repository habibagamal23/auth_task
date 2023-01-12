// ignore_for_file: avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:auth_task/components/buttons.dart';
import 'package:auth_task/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mypassword, myemail;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  var empty = false;

  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: const Text("No user found for that email"))
              .show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: const Text("Wrong password provided for that user"))
              .show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  Widget getIntroText() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Login!",
            style: TextStyle(color: ColorManager.black, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Welcome back ! Login with your credentials",
            style: TextStyle(color: ColorManager.lightGrey, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ]);
  }

  Widget getFormFeild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: TextFormField(
            onSaved: (val) {
              myemail = val;
            },
            validator: (val) {
              if (val!.isEmpty) {
                empty = true;
                return "empty";
              }
              return null;
            },
            autofocus: true,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
                labelText: "Email",
                labelStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: ColorManager.black, fontSize: 15),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: ColorManager.black,
                ),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: (val) {
            mypassword = val;
          },
          validator: (val) {
            if (val!.isEmpty) {
              empty = true;
              return "empty";
            }
            return null;
          },
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
                color: ColorManager.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            hintStyle: TextStyle(color: ColorManager.black, fontSize: 15),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: ColorManager.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formstate,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getIntroText(),
                      const SizedBox(
                        height: 100,
                      ),
                      getFormFeild(),
                      const SizedBox(
                        height: 100,
                      ),
                      BlueButton(
                          text: "Log in",
                          onTap: () async {
                            var user = await signIn();
                            if (user != null) {
                              Navigator.pushReplacementNamed(
                                  context, RouteGenerator.homepage);
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Do not have an account ?",
                        style: (TextStyle(
                            color: ColorManager.black, fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RouteGenerator.register);
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
