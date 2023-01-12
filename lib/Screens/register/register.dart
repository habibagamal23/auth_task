// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../components/buttons.dart';
import '../../constants.dart';
import '../../routes.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var myusername, mypassword, myemail;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog (
              context: context,
              title: "Error",
              body: const Text("Password is to weak"))
              .show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("The account already exists for that email"))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  Widget getIntroRegister() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: const [
      Text(
        "Register Now!",
        style: TextStyle(color: ColorManager.black, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        "Create an Account,Its free",
        style: TextStyle(color: ColorManager.lightGrey, fontSize: 15),
        textAlign: TextAlign.center,
      ),
    ]);
  }


  Widget getFormFeildRegister() {
    var empty = false;
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
             myusername = val;
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
                labelText: "User Name",
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
            myemail = val;
          },
          validator: (val) {
            if (val!.isEmpty) {
              empty = true;
              return "empty";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
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
                      getIntroRegister(),
                      const SizedBox(
                        height: 100,
                      ),
                      getFormFeildRegister(),
                      const SizedBox(
                        height: 70,
                      ),
                      BlueButton(text: "Register", onTap: () async{
                        UserCredential response = await signUp();
                        if (response != null) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .add({"username": myusername, "email": myemail});
                          Navigator.pushReplacementNamed(
                              context, RouteGenerator.homepage);
                        }else{

                          print("Sign Up Faild");
                        }

                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Already have an account ?",
                        style: (TextStyle(
                            color: ColorManager.black, fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RouteGenerator.login);
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
