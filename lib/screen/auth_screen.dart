import 'package:chat/widget/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  // this will give a example(instance) to firebase managed by the package
  void _submitAuthForm(
      String email, String password, String username, bool isLogin,BuildContext ctx) async {
    
    UserCredential authResult;

    try{
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
      authResult = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)) ;
    } else {
      authResult = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)
          );
         await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set(
            {'username':username,'email':email,} // this should be a map
          );
    }
    
    }
     on PlatformException catch (err){
      var message = "An error occurred, please check your credentials!";
      if(err.message != null){
        message = err.message!;
      }
     setState(() {
       _isLoading = false;
     });
    } catch (err){
      print(err);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthForm(_submitAuthForm,_isLoading,),
    );
  }
}
