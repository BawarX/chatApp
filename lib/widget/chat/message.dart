import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx,chatSnapshots){
        if(chatSnapshots.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshots.data!.docs;
          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder:(ctx,index)=> Text(chatDocs[index]['text']));
      },
    );
  }
}