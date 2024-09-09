import 'package:flutter/material.dart';
import 'package:a/reusable_widgets/reusable_widgets.dart';
import 'package:a/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
  TextEditingController _userNameTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true,
    appBar:AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text("sign up",
      style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
    ),
    body: Container(width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,
              end: Alignment.bottomCenter,colors: [
    const Color.fromRGBO(254, 254, 253, 0.659),
    const Color.fromARGB(68, 0, 0, 0),
    const Color.fromARGB(255, 0, 0, 0),],)),
    child:SingleChildScrollView(
      child: Padding(
        padding:EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.08,50,0) ,
        child:Column(
          children: <Widget>[
            logoWidget("assets/images/logo1.jpeg"),
            SizedBox(height: 20)
           ,reusableTextField("enter user name", Icons.person_outline, false
           ,_userNameTextController),
            SizedBox(height: 20)
           ,reusableTextField("enter your email", Icons.person_outline, false
           ,_emailTextController),
           
            SizedBox(height: 20)
           ,reusableTextField("enter password", Icons.lock_outline, false
           ,_passwordTextController),
           SigninSignupButton(context, false,() {
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text).then((value){
                  print("Created New Account");
                  Navigator.push(context,
                       MaterialPageRoute(builder: (context) => HomeScreen()));

                }
            ).onError((error,StackTrace){
              print("Error ${error.toString()}");
            });
           
           }),

         ],
        ) ,),
    )));

  }
}