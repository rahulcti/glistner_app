import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/styles/const.dart';
import '../../introscreens/intro1.dart';
import 'mixing_screen.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorscreenbackground,
      appBar: appbartitlebackbtn(context, 'Songs'),
      body: Container(
        width: deviceWidth(context),
        height: deviceheight(context),
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Image.asset('assets/pngicons/guitar-white.png',
                 height: deviceheight(context,0.1),scale: 1.5,),
              Text('Songs with guitar instrument',
              style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,fontSize: 20,height: 2),),
              Text('40 Songs',style: TextStyle(color: divider ,fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,fontSize: 10,height: 2)),

              sizedboxheight(10.0),
              GridView.count(
                shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: (1 / 1.35),
                  children: List.generate(14, (int index) {
                    return InkWell(
                      onTap: (){
                      //  Get.to(() => Mixing());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#313131"),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sizedboxheight(5.0),
                              CircleAvatar(
                                radius: deviceWidth(context,0.1),
                                backgroundColor: colorgrey,
                                backgroundImage: AssetImage('assets/icons/image.png'),
                              ),

                              Text('Earth Song',style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,fontSize: 14,height: 1.5)),

                              Text('Robert Will',style: TextStyle(color: HexColor("#909090") ,fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,fontSize: 10,height: 1.5)),

                              Text('Guitar Version : Medium',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,fontSize: 10,height: 1.5)),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      SvgPicture.asset('assets/icons/play.svg',width: deviceWidth(context,0.1),),
                                      sizedboxheight(deviceheight(context,0.002)),
                                      Text('Pause',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,fontSize: 8,height: 2)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset('assets/icons/version.svg',width: deviceWidth(context,0.1)),
                                      sizedboxheight(deviceheight(context,0.002)),
                                      Text('Version',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,fontSize: 8,height: 2)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset('assets/icons/exit.svg',width: deviceWidth(context,0.1)),
                                      sizedboxheight(deviceheight(context,0.002)),
                                      Text('Mix',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,fontSize: 8,height: 2)),
                                    ],
                                  ),
                                ],
                              ),
                            )

                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
