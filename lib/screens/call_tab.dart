import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/call_list.dart';

class CallTab extends StatefulWidget {
  const CallTab({ Key? key }) : super(key: key);

  @override
  _CallTabState createState() => _CallTabState();
}

class _CallTabState extends State<CallTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            callList("Palli", "Today, 08:32", true, true,photo: "assets/images/foto2.jpeg"),
            callList("Palli", "Today, 08:32", false, false,photo: "assets/images/foto2.jpeg"),
            callList("Palli", "Today, 08:32", false, true,photo: "assets/images/foto2.jpeg"),
          ],
        ),
      ),
    );
  }
}