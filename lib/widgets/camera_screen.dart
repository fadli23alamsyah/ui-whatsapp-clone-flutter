import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/constant.dart';
import 'package:whatsapp_clone/screens/preview_camera.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({ Key? key }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cCamera;
  bool recordVideo = false;
  int cameraIndex = 0;
  bool flash = false;
  Future<void>? cameraValue;

  @override
  void initState() {
    super.initState();
    cCamera = CameraController(cameras![cameraIndex], ResolutionPreset.high);
    cameraValue = cCamera.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    cCamera.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return CameraPreview(cCamera);
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(            
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            flash = !flash;
                          });
                          (flash)? cCamera.setFlashMode(FlashMode.torch) : cCamera.setFlashMode(FlashMode.off);
                        }, 
                        splashRadius: 20,
                        splashColor: mainColor,
                        icon: Icon(
                          (flash)? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        )
                      ),
                      GestureDetector(
                        onLongPress: () {
                          cCamera.startVideoRecording().then((_){
                            setState(() {
                              recordVideo = true;
                            });
                          });
                        },
                        onLongPressUp: (){
                          handleCamera(context, "video");
                          setState(() {
                            recordVideo = false;
                          });
                        },
                        onTap: (){
                          if(!recordVideo) handleCamera(context, "photo");
                        },
                        child: (recordVideo)? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 70,
                          ) : const Icon(
                          Icons.panorama_fish_eye, 
                          color: Colors.white,
                          size: 65,
                          ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {});
                          cameraIndex = (cameraIndex == 1 )? 0 : 1; 
                          cCamera = CameraController(cameras![cameraIndex], ResolutionPreset.high);
                          cameraValue = cCamera.initialize();
                        }, 
                        splashRadius: 20,
                        splashColor: mainColor,
                        icon: const Icon(Icons.flip_camera_ios, color: Colors.white)
                      ),
                    ],
                  ),
                  const Text(
                    "Hold for video, Tap for photo",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  void handleCamera(BuildContext context, String type) async{
    // String nameFile = (type == "photo")? "WhyApp_photo_${DateTime.now()}.jpeg" : "WhyApp_video_${DateTime.now()}.mp4";
    // final path = join((await getTemporaryDirectory()).path, nameFile);
    // if(type == "photo"){
    //   cCamera.takePicture().then((photo) {
    //     photo.saveTo(path);
    //     Navigator.push(context, MaterialPageRoute(builder: (builder)=>PreviewCamera(path: path, type: type)));
    //   });
    // }else{
    //   await cCamera.stopVideoRecording().then((video) async {
    //     await video.saveTo(path);
    //     Navigator.push(context, MaterialPageRoute(builder: (builder)=>PreviewCamera(path: path, type: type)));
    //   });
    // }
    XFile data = (type == "photo") ? await cCamera.takePicture() : await cCamera.stopVideoRecording();
    
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>PreviewCamera(path: data.path, type: type)));
    
  }
}