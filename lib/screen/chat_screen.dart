import 'package:chat/widget/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(child: Column(children: <Widget>[
        Expanded(
          child: Messages(),
          ),
      ],),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/zkvGWT6e7Oz3GQcS84my/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
