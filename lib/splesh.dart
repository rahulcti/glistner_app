import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glistener/screens/auth/sign_in.dart';
import 'package:glistener/screens/auth/welcome.dart';
import 'package:glistener/screens/bottombar/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'common/styles/const.dart';
import 'introscreens/intro1.dart';


class Splesh extends StatefulWidget {
  const Splesh({Key? key}) : super(key: key);

  @override
  State<Splesh> createState() => _SpleshState();
}

class _SpleshState extends State<Splesh> {

  var user_id;
  String? status,message,click,first,isselected;
  @override
  getValuesSF() async {
    Timer(
      Duration(seconds: 3),() {

       // first=="1" ?
      status=="true" ?
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => BottomBar())):

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SignIn()));
        //     :
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => Itro1()));





            // Get.off(() => Itro1());
           // Get.off(() => BottomBar());
       // Navigator.push(context, MaterialPageRoute(builder: (_)=>Itro3()));
        // status ? Get.offAll(() => BottomNavBarPage()) : Get.offAll(() => IntroductionPage());
        //
        //     ? Get.offAll(() => BottomNavBarPage())
        //     : Get.offAll(() => LoginScreen());
      },
    );
  }
  @override
  void initState() {
    getValuesSF();
    // TODO: implement initState
    super.initState();
    getValues();
  }
  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      first=prefs.getString('first');
      status=prefs.getString('login_status');
      click=prefs.getString('click');
      isselected=prefs.getString('isselected');

      // first=prefs.getString('first');
      print('name=============='+status.toString());
      print('click=============='+click.toString());


      // first==1 ?
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn(),))
      //     :
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Itro1(),));




    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(

       child: Center(
       child: Image.asset("assets/new/applogo.png",width: deviceWidth(context,0.6),),
      ),

      ),
    );
  }
}
