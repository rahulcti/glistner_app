import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/styles/const.dart';
import '../privacy_policy/privacy_policy.dart';
import '../terms_use/terms_use.dart';
import 'artist_selection.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _HomeState();
}

class _HomeState extends State<Settings> {
  bool isToggled = false;
  bool isToggled1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 45,
                width: deviceWidth(context),
                color: colorWhite,
                padding: EdgeInsets.all(10),
                child: Text('PERMISSION',style: TextStyle(color: colorblacktext  ,fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,fontSize: 12,height: 1.5)),
              ),
              Container(
                height: 45,
                width: deviceWidth(context),
                color: colorscreenbackground,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location Permission',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
                    FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: colorbutton,
                      inactiveColor: colorWhite,
                      toggleColor: colorgrey,
                    activeToggleColor: colorWhite,
                      value: isToggled,
                      onToggle: (value) {
                        setState(() {
                          isToggled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1,color: colorWhite,),
              Container(
                height: 45,
                width: deviceWidth(context),
                color: colorscreenbackground,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notification Permission',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
                    FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: colorbutton,
                      inactiveColor: colorWhite,
                      toggleColor: colorgrey,
                      activeToggleColor: colorWhite,
                      value: isToggled1,
                      onToggle: (value) {
                        setState(() {
                          isToggled1 = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 45,
                width: deviceWidth(context),
                color: colorWhite,
                padding: EdgeInsets.all(10),
                child: Text('ACCOUNT',style: TextStyle(color: colorblacktext  ,fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,fontSize: 12,height: 1.5)),
              ),
              InkWell(
                onTap: (){
                  Get.to(() => SelectionArtist());
                },
                child: Container(
                  height: 45,
                  width: deviceWidth(context),
                  color: colorscreenbackground,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change Artist Selection',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
                      SvgPicture.asset('assets/icons/beackicon.svg',height: 10,)
                    ],
                  ),
                ),
              ),
              Divider(height: 1,color: colorWhite,),
              InkWell(
                onTap: (){
                  Get.to(() => PrivacyPolicy());
                },
                child: Container(
                  height: 45,
                  width: deviceWidth(context),
                  color: colorscreenbackground,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Privacy Policy',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
                      SvgPicture.asset('assets/icons/beackicon.svg',height: 10,)
                    ],
                  ),
                ),
              ),
              Divider(height: 1,color: colorWhite,),
              InkWell(
                onTap: (){
                  Get.to(() =>  TermsUse());
                },
                child: Container(
                  height: 45,
                  width: deviceWidth(context),
                  color: colorscreenbackground,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Terms Of Use',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
                      SvgPicture.asset('assets/icons/beackicon.svg',height: 10,)

                    ],
                  ),
                ),
              ),
              Divider(height: 1,color: colorWhite,),
            ],
          ),
        ),
      ),
    );
  }
}