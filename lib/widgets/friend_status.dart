import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant.dart';

Widget friendStatus(String name, String time, String foto, bool isSeen, int statusNum){
  return ListTile(
    leading: CustomPaint(
      painter: StatusPainter(isSeen: isSeen, statusNum: statusNum),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(foto),
        ),
      ),
    ),
    title: Text(name),
    subtitle: Text(time),
  ) ;
}

class StatusPainter extends CustomPainter{
  StatusPainter({this.isSeen, this.statusNum});
  bool? isSeen;
  int? statusNum;

  degreeToAngle(double value){
    return value * pi / 180 ;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..color = isSeen! ? Colors.grey : mainColor
      ..style = PaintingStyle.stroke;
    
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint){
      if(statusNum == 1){
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), degreeToAngle(0), degreeToAngle(360), false, paint);
      }else{
        double degree = -90;
        double arc = 360 / statusNum!;
        for(int i=0; i < statusNum!; i++){
          canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), degreeToAngle(degree + 4), degreeToAngle(arc - 6), false, paint);
          degree += arc;
        }
      }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}