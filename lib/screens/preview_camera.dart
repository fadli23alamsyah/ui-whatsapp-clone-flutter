import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_clone/constant.dart';

class PreviewCamera extends StatefulWidget {
  const PreviewCamera({ Key? key, this.path, this.type}) : super(key: key);
  final String? path;
  final String? type;

  @override
  _PreviewCameraState createState() => _PreviewCameraState();
}

class _PreviewCameraState extends State<PreviewCamera> {
  late VideoPlayerController cVideo;

  @override
  void initState() {
    super.initState();
    if(widget.type == "video"){
      cVideo = VideoPlayerController.file(File(widget.path.toString()))
      ..initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.type == "video") cVideo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.close)
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.crop_rotate)
          ),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.emoji_emotions_outlined)
          ),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.title)
          ),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.edit_outlined)
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            (widget.type == "photo") 
              ? Image.file(
                  File(widget.path.toString()),
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                )
              : cVideo.value.isInitialized
                ? SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: cVideo.value.aspectRatio,
                    child: Stack(
                      children:[
                        VideoPlayer(cVideo),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  cVideo.value.isPlaying
                                    ? cVideo.pause()
                                    : cVideo.play();
                                });
                              }, 
                              iconSize: 25,
                              icon: cVideo.value.isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow,)
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ): Container(),
              Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            hintText: "Add a caption..",
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){}, 
                              color: mainColor,
                              splashRadius: 20,
                              icon: const Icon(Icons.photo_library)
                              ),
                            suffixIcon: IconButton(
                              onPressed: (){}, 
                              color: mainColor,
                              splashRadius: 20,
                              icon: const Icon(Icons.one_x_mobiledata_sharp)
                              ),
                          )
                        ),
                      )
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: mainColor,
                      child: IconButton(
                        onPressed: (){}, 
                        color: Colors.white,
                        splashRadius: 20,
                        icon: const Icon(Icons.check)
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}