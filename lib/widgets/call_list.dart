import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant.dart';

Widget callList(String name, String time, bool isCallOut, bool answer,{String photo = ""}){
  return ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey,
      backgroundImage: photo != "" ? AssetImage(photo) : null,
      child: photo == "" ? const Icon(Icons.person, color: Colors.white,): null,
    ),
    title: Text(name),
    subtitle: Row(
      children: [
        Icon(
          isCallOut ? Icons.call_made : Icons.call_received, 
          size: 18, 
          color: isCallOut || answer ? mainColor : Colors.red,
        ),
        const SizedBox(width: 5,),
        Text(time)
      ],
    ),
    trailing: InkWell(
      onTap: (){}, 
      child: const SizedBox(
        height: 200,
        width: 50,
        child: Icon(Icons.call)
      )
    ),
  ) ;
}