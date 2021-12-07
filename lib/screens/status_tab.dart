import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/friend_status.dart';
import 'package:whatsapp_clone/widgets/my_status.dart';
// import 'package:whatsapp_clone/widgets/chat_list.dart';

class StatusTab extends StatefulWidget {
  const StatusTab({ Key? key }) : super(key: key);

  @override
  _StatusTabState createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            myStatus(),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: const Text("Recent Update"),
            ),
            friendStatus("Palli","Today 14.00", "assets/images/foto2.jpeg", false, 3),
            friendStatus("Alamsyah","Today 09.00", "assets/images/foto3.JPG", false, 5),
          ],
        ),
      ),
    );
  }
}