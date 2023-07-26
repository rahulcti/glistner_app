import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../common/styles/const.dart';
import '../screens/auth/sign_in.dart';
import '../screens/auth/sign_up.dart';

class Itro3 extends StatefulWidget {
  const Itro3({Key? key}) : super(key: key);

  @override
  State<Itro3> createState() => _Itro3State();
}

class _Itro3State extends State<Itro3> {
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(
        height: deviceheight(context),
        width: deviceWidth(context),
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              width: deviceWidth(context),
              child: Container(
                height: deviceheight(context,),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: deviceheight(context,0.4),
                      width: deviceWidth(context, 0.9),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                      margin: EdgeInsets.only(left: 25,right: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Download and share your favorite mix',
                            style: TextStyle(
                                fontSize: 18,color: colorblacktext,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),

                          Text('You can download your created mixed songs and share them with your friends.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,color: colortextgrea,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w400
                            ),),
                          SvgPicture.asset("assets/new/intro3.svg",color: colorblack,),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacement(createRoute(SignIn()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:  HexColor("#E0B32E"),
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child:   Padding(
                                padding: const EdgeInsets.only(left: 40,right: 40,top: 12,bottom: 12),
                                child: Text('Next',
                                  style: TextStyle(
                                    fontSize: 14,color: colorWhite,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: deviceheight(context,0.35),
                      child: Image.asset('assets/new/introimage3.png',
                        height: deviceheight(context,0.4),),
                    ),
                  ],
                ),
              ),),

          ],
        ),
      ),
    );
  }
}
