import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/widgets/icon_attach.dart';

class IndividuChat extends StatefulWidget {
  const IndividuChat({ Key? key, required this.chat }) : super(key: key);
  final ChatModel chat;

  @override
  _IndividuChatState createState() => _IndividuChatState();
}

class _IndividuChatState extends State<IndividuChat> {
  bool emotShow = false;
  bool sendMsg = false;
  FocusNode focusNode = FocusNode();
  TextEditingController cMsg = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          emotShow = false;
        }); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: mainColor,
        leadingWidth: 65,
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            onTap: (){
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(Icons.arrow_back),
                CircleAvatar(
                  radius: 18,
                ),
              ],
            ),
          ),
        ),
        title: Text(widget.chat.name.toString()),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.videocam),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.call),
            splashRadius: 20,
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return const [
                PopupMenuItem(child: Text("View Contact"),),
                PopupMenuItem(child: Text("Search"),),
                PopupMenuItem(child: Text("More"),),
              ];
            },
          )
        ],
      ),
      body: WillPopScope(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: TextFormField(
                              onChanged: (value){
                                setState(() {
                                  sendMsg = (value.isNotEmpty)? true : false;
                                });
                              },
                              controller: cMsg,
                              focusNode: focusNode,
                              cursorColor: mainColor,
                              textAlignVertical: TextAlignVertical.center,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                  onPressed: (){
                                    focusNode.unfocus();
                                    // focusNode.canRequestFocus = false;
                                    setState(() {
                                      emotShow = !emotShow;
                                    });
                                  }, 
                                  color: mainColor,
                                  splashRadius: 20,
                                  icon: const Icon(Icons.emoji_emotions_outlined)
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        focusNode.unfocus();
                                        setState(() {
                                          emotShow = false;
                                        });
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context, 
                                          builder: (BuildContext context){
                                          return Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                            margin: const EdgeInsets.only(right: 8, left: 8, bottom: 60),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    iconAttach(Icons.insert_drive_file, "Document", Colors.indigo),
                                                    // const SizedBox(width: 30,),
                                                    iconAttach(Icons.camera_alt, "Camera", Colors.red),
                                                    // const SizedBox(width: 30,),
                                                    iconAttach(Icons.photo, "Gallery", Colors.purple),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    iconAttach(Icons.headphones_rounded, "Audio", Colors.orange),
                                                    // const SizedBox(width: 30,),
                                                    iconAttach(Icons.location_on, "Location", Colors.green),
                                                    // const SizedBox(width: 30,),
                                                    iconAttach(Icons.person, "Contact", Colors.blue),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      }, 
                                      color: mainColor,
                                      splashRadius: 20,
                                      icon: const Icon(Icons.attach_file_outlined)
                                    ),
                                    IconButton(
                                      onPressed: (){}, 
                                      color: mainColor,
                                      splashRadius: 20,
                                      icon: const Icon(Icons.camera_alt)
                                    ),
                                  ],
                                ) 
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: mainColor,
                          radius: 25,
                          child: IconButton(
                            onPressed: (){}, 
                            splashRadius: 20,
                            color: Colors.white,
                            icon: (sendMsg)? const Icon(Icons.send) : const Icon(Icons.mic)
                          ),
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: !emotShow,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji){
                          cMsg
                            ..selection = TextSelection.fromPosition(TextPosition(offset: cMsg.text.length))
                            ..text += emoji.emoji;
                            setState(() {
                              sendMsg = (cMsg.text.isNotEmpty)? true : false;
                            });
                        },
                        onBackspacePressed: (){
                          cMsg.text = cMsg.text.characters.skipLast(1).toString();
                          setState(() {
                            sendMsg = (cMsg.text.isNotEmpty)? true : false;
                          });
                        },
                        config: const Config(
                          columns: 8,
                          emojiSizeMax: 28,
                          backspaceColor: Colors.green,
                          indicatorColor: mainColor,
                          progressIndicatorColor: mainColor,
                          iconColorSelected: mainColor
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        onWillPop: (){
          if(emotShow){
            setState(() {
              emotShow = false;
            });
          }else{
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }
}