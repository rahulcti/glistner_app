import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glistener/screens/auth/sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modal/MyProfile.dart';
import '../../screens/my_profile/my_profile.dart';
import '../../screens/notification/notification.dart';
import '../../screens/song_screen/songsettings.dart';
import 'appbarwidgetpage.dart';
import 'package:http/http.dart'as http;



String? myimage,name;
Future<void> imgdata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  name=prefs.getString('appbarname');
  myimage=prefs.getString('profileimg');
}
Widget myAppBarIcon(){
  return InkWell(
    onTap: (){
      Get.to(() => NotificationsScreen());
    },
    child: Container(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top:10),
            child: SvgPicture.asset('assets/icons/notification.svg', width: 20,
              height: 20,),
          ),
          Container(
            width: 14,

            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 12),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor('#00EA4F'),
             ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    1.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@override
AppBar appbartitlebackbtn(context, title) {
  return AppBar(

    elevation: 0,
    backgroundColor: colorappblack,
    leading: backbtnappbar(context),
    centerTitle: true,
    title: Text(
      title,
      style: textstyleHeading6(context)!.copyWith(color: colorWhite),
    ),
      bottom:  PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child:  Container(
              color: HexColor("#D9D9D9"),
              padding: const EdgeInsets.all(0.4),
            ))
  );
}
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String? appbartitel,firstname1,imgpic1 ;

AppBar appbarseting(context, title, firstname,  imgpic,) {
  switch(title) {
    case 0: {
      appbartitel = 'Welcome';
      firstname1=firstname;
      imgpic1=imgpic;
      // print("${BASE_URL_img_upload}${imgpic1}");
      print("yyyyyyyyyyyyyyyyyyy${imgpic1}");

    }
    break;
    case 1: {
      appbartitel = 'Search';
    }
    break;
    case 2: {
      appbartitel = 'Genre Library';
    }
    break;
    case 3: {

      appbartitel = 'My Mix';
    }
    break;
    case 4: {
      appbartitel = 'Settings';
    }
    break;

    default: {
      //statements;
    }
    break;
  }
  return AppBar(

      elevation: 0,
      backgroundColor: colorappblack,
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: InkWell(
        onTap: () {
          Get.to(() => MyProfile());
        },
        child:Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              imgpic1=="" ?CircleAvatar(
                backgroundColor: colorgrey,
                // backgroundImage:  NetworkImage("${BASE_URL_img_upload}${imgpic1}"),
                backgroundImage:  AssetImage("assets/icons/image.png"),
              ):
              CircleAvatar(
                backgroundColor: colorgrey,
                backgroundImage:  NetworkImage("${BASE_URL_img_upload}${imgpic1}"),
                // backgroundImage:  AssetImage("assets/icons/image.png"),
              ),
            ],
          ),
        )
      ),
    ),
    bottom: title!=0? PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child:  Container(
          color: HexColor("#D9D9D9"),
          padding: const EdgeInsets.all(0.4),
        )):PreferredSize(
        preferredSize: const Size.fromHeight(5.0),
        child:  Container(
          color: HexColor("#D9D9D9"),
          padding: const EdgeInsets.all(0.0),
        )),
      centerTitle:title==0?false :true,
      title:title==0?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appbartitel.toString(),
             style:  TextStyle(color: divider ,fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,fontSize: 12,),
         ),

          Text("${firstname1}",
           style: textstylesubtitle1(context)!.copyWith(color: colorWhite,),
          ),
        ],
      ) :Text(
        appbartitel.toString(),
        style: textstyleHeading6(context)!.copyWith(color: colorWhite),
      ),

    actions: [
      myAppBarIcon(),

      IconButton(
          icon: SvgPicture.asset('assets/icons/logout.svg',width: 20,height:20,),
          onPressed: () async {

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            prefs.setString('first',"1");
            prefs.setString('Welcome_value',"1");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute<Null>(
                    builder: (BuildContext context) {


                      return SignIn();

                    }));

            Fluttertoast.showToast(
                msg: "Logout Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);

            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return  AlertDialog(
            //       shape: RoundedRectangleBorder(borderRadius:
            //       BorderRadius.all(Radius.circular(15))),
            //     title: Text('Exit'),
            //     content: Text('Do You Want to Logout ? '),
            //     actions: <Widget>[
            //     ElevatedButton(
            //     onPressed: () {
            //     print("you choose no");
            //     Navigator.of(context).pop(false);
            //     },
            //     child: Text('No'),
            //     ),
            //     ElevatedButton(
            //     onPressed: () async {
            //       SharedPreferences prefs = await SharedPreferences.getInstance();
            //        prefs.clear();
            //       prefs.setString('first',"1");
            //        Navigator.of(context).pushReplacement(
            //            MaterialPageRoute<Null>(
            //                builder: (BuildContext context) {
            //
            //
            //                  return SignIn();
            //
            //                }));
            //
            //
            //
            //       print("yes");
            //     },
            //     child: Text('Yes'),
            //     ),
            //     ],
            //     );
            //
            //   },
            // ) ??
                false;





            //Get.back();
           // Get.to(() => SongSettings());
           //  SharedPreferences prefs = await SharedPreferences.getInstance();
           //  prefs.clear();
           //  Navigator.of(context).pushReplacement(
           //      MaterialPageRoute<Null>(
           //          builder: (BuildContext context) {
           //            prefs.setString('first',"1");
           //
           //            return SignIn();
           //
           //          }));


          }),
      sizedboxwidth(10.0),
    ],
  );


}

