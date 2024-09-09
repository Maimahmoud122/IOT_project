import 'package:flutter/material.dart';
import 'package:a/reusable_widgets/reusable_widgets.dart';
import 'package:a/screens/homescreen.dart';
import 'package:a/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
                        
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,
              end: Alignment.bottomCenter,colors: [
    const Color.fromRGBO(254, 254, 253, 0.659),
    const Color.fromARGB(68, 0, 0, 0),
    const Color.fromARGB(255, 0, 0, 0),],
   
    )),
     child:SingleChildScrollView(
      child: Padding(
        padding:EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.08,50,0) ,
        child:Column(
          children: <Widget>[
            logoWidget("assets/images/logo1.jpeg"),
            SizedBox(height: 20)
           ,reusableTextField("enter your email", Icons.person_outline, false
           ,_emailTextController),
           
            SizedBox(height: 20)
           ,reusableTextField("enter password", Icons.lock_outline, false
           ,_passwordTextController),
           SigninSignupButton(context, true,() {
            FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, 
            password:_passwordTextController.text).then((value){
                Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen()));
           }).onError((error,StackTrace){
            print("Error ${error.toString()}");
           });
            }),
           signUpOption()],
        ) ,),
    )),);
  }
 Row signUpOption (){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("don't have account ?",style: TextStyle(color: Colors.white70),),
      GestureDetector(
        onTap:() {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen() ));
        },
        child: const Text(
          "sign up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
 }
  
  

 
}