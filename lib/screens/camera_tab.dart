import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/camera_screen.dart';

class CameraTab extends StatefulWidget {
  const CameraTab({ Key? key }) : super(key: key);

  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  @override
  Widget build(BuildContext context) {
    return const CameraScreen();
  }
}