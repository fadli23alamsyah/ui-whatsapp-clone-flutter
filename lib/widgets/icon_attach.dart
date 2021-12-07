import 'package:flutter/material.dart';

Widget iconAttach(IconData? icon, String? title, Color? color){
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, size: 25,color: Colors.white,),
        radius: 25,
      ),
      const SizedBox(height: 5,),
      Text(
        title!,
        style: const TextStyle(
          fontSize: 12
        ),
      )
    ],
  );
}