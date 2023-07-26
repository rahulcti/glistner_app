import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/commonwidgets/button.dart';
import '../bottombar/bottombar.dart';
import 'choose_instrument.dart';

// class Welcome extends StatelessWidget {
//    Welcome({Key? key}) : super(key: key);
//


class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


var userfirst,userlast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }
  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
    userfirst=prefs.getString("userfirst");
    userlast=prefs.getString("userlast");
  });
    // print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(
        width: deviceWidth(context,1),
        height: deviceheight(context,1),
        child: Stack(
          children: [
            Container(
              width: deviceWidth(context,1),
              height: deviceheight(context,1),
              child: Image.asset('assets/icons/celibretion_screen.png',fit: BoxFit.fill,),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(

                width: deviceWidth(context,1),
                height: deviceheight(context,1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/new/applogo.png',
                    width: deviceWidth(context,0.6),),
                    sizedboxheight(30.0),
                    Text("Welcome,${userfirst}  ${userlast}",
                        style: TextStyle(
                            fontSize: 20,color: colorWhite,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700
                        )
                    ),
                    sizedboxheight(5.0),
                    Text("Enjoy unlimited music & create \nyour own music",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,color: colorhintcolor,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w400
                        )
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 50,
                child: Container(
                  width: deviceWidth(context),
                    child: Center(child: continueBtn(context))))
          ],
        ),
      ),
    );
  }


  Widget continueBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'CONTINUE',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context,0.8),
        btnHeight: 60,
        btnColor: colorbutton,
        onPressed: () async {

          Get.off(() => Choose_Instrument());
        },
      ),
    );
  }
}
