import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/screens/individu_chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({ Key? key, required this.chat }) : super(key: key);
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> IndividuChat(chat: chat,)));
    },
    child: Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 25,
          ),
          trailing: Text(chat.time.toString()),
          title: Text(chat.name.toString()),
          subtitle: Row(
            children:  [
              const Icon(Icons.done_all, size: 18.0,),
              const SizedBox(width: 5),
              Text(chat.currentMessage.toString())
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 70, right: 20),
          child: Divider(thickness: 1,),
        )
      ],
    ),
  );
  }
}