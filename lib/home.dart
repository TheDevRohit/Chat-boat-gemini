import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {


  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Rohit',
    lastName: 'Kumar',
  );

  ChatUser gemini = ChatUser(
    id: '2',
    firstName: 'Gemini',
    lastName: '',
  );

  var ApiKey = "AIzaSyCicOLgbVIdKyzvlM3PsmECNZDeFg71H7A";
  var url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCicOLgbVIdKyzvlM3PsmECNZDeFg71H7A";


  List<ChatUser> typing = [];



 getAllMessages(ChatMessage msg) async {
   typing.add(gemini);
   setState(() {
      messages.insert(0, msg);
    });

    var bodyData = {
      "contents": [{"parts":[{"text": msg.text}]}]};
      await http.post(Uri.parse(url),
      headers:  {
        "Content-Type" : "application/json",
      },
      body: jsonEncode(bodyData),
    ).then((value){
      if(value.statusCode == 200){
        var result = jsonDecode(value.body);
        print(result["candidates"][0]["content"]["parts"][0]["text"]);

        ChatMessage chatBot = ChatMessage(
            text: result["candidates"][0]["content"]["parts"][0]["text"],
            user: gemini, createdAt: DateTime.now(),
        );

        messages.insert(0, chatBot);


      }else{
        print("error");
      }
    }
    ).catchError((error){
      print(error);
    });
   typing.remove(gemini);
   setState(() {

   });
 }





  // curl \
  // -H 'Content-Type: application/json' \
  // -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
  // -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY

  List<ChatMessage> messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.orange.,
        scrolledUnderElevation: 0,
        title :  ListTile(
          leading: Image.asset('assets/gemini.png',
           height: 40,
            width: 40,
          ),
          title: const Text('Gemini',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          subtitle: const Text('Online',style: TextStyle(color: Colors.green),),
        ),
       leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new) , onPressed: (){}),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.call)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],

      ),
      body: DashChat(
         quickReplyOptions: QuickReplyOptions(),
         scrollToBottomOptions: ScrollToBottomOptions(),
         typingUsers: typing,
         currentUser: user,
         onSend: (ChatMessage msg) {
             getAllMessages(msg);
        },
        messages: messages,
      ),
    );
  }
}
