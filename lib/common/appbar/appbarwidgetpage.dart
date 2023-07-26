import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:glistener/screens/bottombar/bottombar.dart';
import '../styles/const.dart';

Text appbartitlewidget(title, context) {
  return Text(
    title,
    style: textstyleHeading6(context),
  );
}


IconButton backbtnappbar(context) => IconButton(
    icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
    onPressed: () {
      // Get.back();
      Get.off(BottomBar());
    });


IconButton settingappbar(context) => IconButton(
    icon: SvgPicture.asset('assets/icons/setting.svg',width: 25,height:25,),
    onPressed: () {
      //Get.back();

    });
IconButton saveappbar(context) => IconButton(
    icon: SvgPicture.asset('assets/icons/seva file.svg',width: 25,height:25,),
    onPressed: () {
      //Get.back();

    });
Widget appbSearchWidget() {
  return Icon(
    Icons.search,
    color: colorWhite,
    size: 23,
  );
}
