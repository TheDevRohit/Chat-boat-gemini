import 'dart:async';
import 'package:chat_bot_ai/home.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen>{


  @override
  void initState() {
     Timer(const Duration(seconds: 3) , (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatHome(),));
     });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/gemini.png',
              height: 100,
              width: 100,

            ),
          ),
          const SizedBox(height: 15,),
          const Center(child: Text("Gemini ChatBot",textAlign: TextAlign.center, style: TextStyle(fontSize: 25, color: Colors.blue ,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
