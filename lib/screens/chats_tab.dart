import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({ Key? key }) : super(key: key);

  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  List<ChatModel> chats = [
    ChatModel("Palli", "10:00", "Apa bikin?"),
    ChatModel("Palpal", "08:01", "GGMU"),
    ChatModel("Nur", "22:00", "Begitumi"),
    ChatModel("Alamsyah", "16:00", "Nestedscrollview"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index){
                return ChatList(chat: chats[index]);
              },
              childCount: chats.length
            )
          ),
        ]
      ),
    );
  }
}