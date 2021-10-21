import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/contant.dart';
import 'package:flash_chat_app/widgets/bubble_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  late String typedMessage;
  TextEditingController messageController = TextEditingController();

  void getCurrentUser() async {
    try {
      final User? user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
      print('LoggedIn user is null');
    }
  }

  // void getmessages() async {
  //   final messages = await firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void steamMessages() async {
    await for (var snapshot in firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // steamMessages();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('messages').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ));
                }
                final messages = snapshot.data!.docs.reversed;

                List<BubbleMessage> messageBubbles = [];
                for (var message in messages) {
                  final text = message.get('text');
                  final sender = message.get('sender');
                  final currentUser = loggedInUser.email;

                  final messageBubble = BubbleMessage(
                    text: text,
                    sender: sender,
                    isMe: currentUser == sender,
                  );

                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: messageBubbles,
                  ),
                );
              },
            ),
            // StreamBuilder<QuerySnapshot>(
            //   stream: firestore.collection('messages').snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Something went wrong');
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator(color: Colors.lightBlue);
            //     }
            //     final messages = snapshot.data!.docs;
            //     return ListView(
            //       children:
            //           snapshot.data!.docs.map((DocumentSnapshot document) {
            //         Map<String, dynamic> data =
            //             document.data()! as Map<String, dynamic>;
            //         return ListTile(
            //           title: Text(data['full_name']),
            //           subtitle: Text(data['company']),
            //         );
            //       }).toList(),
            //     );
            //   },
            // ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        typedMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageController.clear();
                      firestore.collection('messages').add(
                          {'text': typedMessage, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
