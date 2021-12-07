import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant.dart';

Widget myStatus(){
  return ListTile(
    leading: Stack(
      children: const [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/foto1.jpg"),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: mainColor,
            child: Icon(Icons.add, size: 15,),
          ),
        )
      ],
    ),
    title: const Text("My Status"),
    subtitle: const Text("Tap to add status update"),
  ) ;
}