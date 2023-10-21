import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../view_model/provider.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatRoom extends ConsumerStatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends ConsumerState<ChatRoom> {
  String myUid= FirebaseAuth.instance.currentUser!.uid;
  final List<types.Message> _messages = [];

  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  Widget build(BuildContext context) {
  final   _firestore= FirebaseFirestore.instance.collection('rooms').doc(ref.read(matchInformationProvider.notifier).state['roomID']).collection('messages');

    final  user =  types.User(id:myUid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/top');
              },
              icon: Icon(
                Icons.output,
                color: Colors.black,
              )),
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.orderBy('createdAt',descending: true).snapshots(),
        builder: (context,  snapshot) {

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('ta');
        }
          if (snapshot.data == null) {
            return const Text('empty');
          }


          else{
            print('hfasdf');
            print(snapshot.data!.docChanges.map((e) => e.doc.data()));
            if(snapshot.data!.docs.isNotEmpty){
              _handleSendPressedOpo(snapshot.data?.docs.first.data() ??{});

            }

        return  Chat(
          user: user,
          messages: _messages,
          onSendPressed: _handleSendPressed,
        );
        }}
      ),
    );
  }

  void _addMessage(types.Message message) {

      _messages.insert(0, message);

  }

  void _handleSendPressed(types.PartialText message) {
    final _firestore= FirebaseFirestore.instance.collection('rooms').doc(ref.read(matchInformationProvider.notifier).state['roomID']).collection('messages');

    _firestore.add({
      'uid': myUid,
      'message': message.text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }






  void _handleSendPressedOpo(Map<String, dynamic>? fields) {

    final textMessage = types.TextMessage(
      author:types.User(id: fields!['uid']),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: fields['message'],
    );
    _addMessage(textMessage);
  }
}
