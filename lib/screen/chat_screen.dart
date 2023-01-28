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
      body: StreamBuilder(
        builder: (ctx, streamSnapshot) {
          if (ConnectionState.waiting == streamSnapshot.connectionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                    child: Text(documents[index]['text']),
                    padding: EdgeInsets.all(8),
                  ));
        },
        stream: FirebaseFirestore.instance
            .collection('chats/zkvGWT6e7Oz3GQcS84my/messages')
            .snapshots(),
      ),
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
