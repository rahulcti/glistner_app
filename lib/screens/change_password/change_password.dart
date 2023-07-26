import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/formtextfield/mytextfield.dart';
import '../../common/styles/const.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool ischecked =false;

  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      appBar: appbartitlebackbtn(context, 'Change Password'),

      body: Container(
          alignment: Alignment.topCenter,
          width: deviceWidth(context),
          height: deviceheight(context),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hey Delvert,',style: TextStyle(
                                fontSize: 16,color: colorhintcolor,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w500
                            ),),
                            Text('Create  new password',style: TextStyle(
                                fontSize: 24,color: colorWhite,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700
                            ),),
                            sizedboxheight(30.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: colorlightblack,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [

                                    newpassword(),
                                    sizedboxheight(20.0),
                                    conformnewpass(),
                                    sizedboxheight(50.0),
                                    signInBtn(context),
                                    sizedboxheight(20.0),

                                    Text(
                                      "Please create a new strong password for your account.",
                                      style: TextStyle(
                                          fontSize: 14,color: colorWhite,
                                          fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w500

                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            sizedboxheight(100.0),
                            sizedboxheight(20.0),



                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          )

      ),
    );
  }
  Widget signInBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'UPDATE PASSWORD',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        btnColor: colorbutton,
        onPressed: () {
          // Get.to(() => LoginScreen());
        },
      ),
    );
  }




  bool pass_show = true;
  Widget newpassword() {
    return AllInputDesign(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'New Password',
      controller: txt_password,
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left:10,right: 10, top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/pass.svg',
            height: 0,
            width: 0,
          )
      ),
      obsecureText: pass_show,
      suffixIcon: TextButton(
          onPressed: () {
            setState((){
              pass_show = !pass_show;
            });
          },
          child:pass_show? Image.asset(
            'assets/icons/pass_hide.png',
            color: colorWhite,
          ):SvgPicture.asset(
            'assets/icons/pass_show.svg',
            color: colorWhite,
          )),

      keyBoardType: TextInputType.text,
      validatorFieldValue: 'password',
      validator: (value) {
        if (value.isEmpty) {
          return 'password is Required.';
        }
      },
    );
  }

  bool pass_show1 = true;
  Widget conformnewpass() {
    return AllInputDesign(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'New Password',
      controller: txt_password,
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left:10,right: 10,  top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/pass.svg',
            height: 0,
            width: 0,
          )
      ),
      obsecureText: pass_show1,
      suffixIcon: TextButton(
          onPressed: () {
            setState((){
              pass_show1 = !pass_show1;
            });
          },
          child:pass_show1? Image.asset(
            'assets/icons/pass_hide.png',
            color: colorWhite,
          ):SvgPicture.asset(
            'assets/icons/pass_show.svg',
            color: colorWhite,
          )),

      keyBoardType: TextInputType.text,
      validatorFieldValue: 'password',
      validator: (value) {
        if (value.isEmpty) {
          return 'password is Required.';
        }
      },
    );
  }
}
