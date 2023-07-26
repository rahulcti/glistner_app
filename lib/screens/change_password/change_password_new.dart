import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glistener/common/formtextfield/validations_field.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:glistener/screens/auth/sign_in.dart';
import 'package:glistener/screens/auth/sign_up.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/commonwidgets/button.dart';
import '../../common/formtextfield/mytextfield.dart';
import '../../modal/Login_Model.dart';

class ChangePasswordNew extends StatefulWidget {
  String? user_id;
  ChangePasswordNew({Key? key,
    this.user_id}) : super(key: key);

  @override
  State<ChangePasswordNew> createState() => _ChangePasswordNewState(user_id:user_id);
}

class _ChangePasswordNewState extends State<ChangePasswordNew> {
  final _formKey = GlobalKey<FormState>();
  bool ischecked =false;
  String? user_id;
  _ChangePasswordNewState(
      { Key? key,
        this.user_id
      });


  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TextEditingController txt_New = TextEditingController();
  TextEditingController txt_Cpassword = TextEditingController();

  String? image, first_name="", last_name="",gmail,type;
  var status,message,id,emailad,user;


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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content:  Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<LoginModel> resetpassword() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id=prefs.getString('user_id');

    print("CLICKED 123 ==");
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      // Internet Present Case
      showLoaderDialog(context);
    }else{
      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // No-Internet Case
    var response = await http.post(Uri.parse(BASE_URL+resetPasswordapi), body: toMap());
    print(LoginModel.fromJson(json.decode(response.body)).success);
    print(LoginModel.fromJson(json.decode(response.body)).message);
    print(LoginModel.fromJson(json.decode(response.body)).status);
    status = (LoginModel.fromJson(json.decode(response.body)).status);
    message = (LoginModel.fromJson(json.decode(response.body)).message);

    if(status==200){
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Password Changed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      // user = (Signup_Model.fromJson(json.decode(response.body)).userinfo![0].firstName.toString());
      // user = (LoginModel.fromJson(json.decode(response.body)).userinfo?.firstname.toString());
      // user_id = (Forgot_Model.fromJson(json.decode(response.body)).userinfo![0].id.toString());
      // user_id = (LoginModel.fromJson(json.decode(response.body)).userinfo!.id.toString());
      // emailad = (LoginModel.fromJson(json.decode(response.body)).userinfo!.email.toString());

      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // prefs.setString('user',user);
      // prefs.setString('user_id',user_id.toString());
      // prefs.setString('email',emailad.toString());
      // print(emailad);

      // prefs.setString('login_status',"true");
      // prefs.setString('type',"0");


      if(message=="Password Changed Successfully"){

        Navigator.of(context).pushReplacement(
            MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return SignIn();
                }));
      }else{
        // Fluttertoast.showToast(
        //     msg: "Please enter registered email address",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

      }

    }else{
      Navigator.pop(context);
      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return LoginModel.fromJson(json.decode(response.body));
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    // map["user_id"] = int.parse(user_id);
    map["user_id"] = user_id;

    map["password"] = txt_Cpassword.text.toString();
    // map["password"] = txt_password.text.toString();


    print("email ====");
    print(txt_New.text.toString());
    // print("password ====");
    // print(txt_password.text.toString());

    return map;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("USER_ID");
    print(user_id.toString());
    print("USER_ID");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Stack(
        children: [


          Container(
              alignment: Alignment.topCenter,
              width: deviceWidth(context),
              height: deviceheight(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: deviceheight(context,0.1)),
                      child: Container(
                        child: Image.asset("assets/new/applogo.png",
                          width: deviceWidth(context,0.55),),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            padding: EdgeInsets.only(top: 30),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hey Delvert,,',style: TextStyle(
                                    fontSize: 18,color: colorhintcolor,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w500
                                ),),
                                SizedBox(
                                  height: 11,
                                ),
                                Text('Create new password',style: TextStyle(
                                    fontSize: 24,color: colorWhite,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700
                                ),),
                                SizedBox(
                                  height: 25,
                                ),

                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: colorlightblack,
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: 20,left: 20),
                                    child: Column(
                                      children: [

                                        sizedboxheight(30.0),
                                        password(),
                                        sizedboxheight(30.0),
                                        conform_password(),
                                        sizedboxheight(60.0),
                                        signInBtn(context),
                                        sizedboxheight(24.0),

                                        Text(
                                          "Please create a new strong password for your account.",
                                          style: TextStyle(
                                              fontSize: 14,color: colorWhite,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w500

                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        sizedboxheight(22.0),


                                      ],
                                    ),
                                  ),
                                ),

                                sizedboxheight(100.0),

                                sizedboxheight(20.0),
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: Text.rich(
                                //     TextSpan(
                                //       children: [
                                //         TextSpan(text: 'Go back to ',style:TextStyle(color: colorhintcolor ,fontFamily: 'Poppins',
                                //             fontWeight: FontWeight.w400,fontSize: 16)),
                                //         TextSpan(
                                //             text: 'Login?',
                                //             style:TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                                //                 fontWeight: FontWeight.w400,fontSize: 16),
                                //             recognizer: TapGestureRecognizer()
                                //               ..onTap = () {
                                //                 print('///////');
                                //                 Get.to(() => SignIn());
                                //               }
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              )

          ),
        ],
      ),
    );
  }

  Widget signInBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'Update password',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        btnColor: colorbutton,
        onPressed: () {
          // Get.to(() => LoginScreen());

          if(_formKey.currentState!.validate()){

            resetpassword();


          }

        },
      ),
    );
  }

  bool pass_show = true;
  Widget password() {
    return AllInputDesign(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'New Password',
      controller: txt_New,
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 15),
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
      validator: validatePassword,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'password is Required.';
      //   }
      // },
    );
  }

  bool pass_show1 = true;
  Widget conform_password() {
    return AllInputDesign(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Confirm New Password',
      controller: txt_Cpassword,
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 15),
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
        if (value!=txt_New.text.toString()) {
          return 'password did  not matched.';
        }
      },
    );
  }




  // bool pass_show = true;
  // Widget password() {
  //   return AllInputDesign(
  //     floatingLabelBehavior: FloatingLabelBehavior.never,
  //     hintText: 'New Password',
  //     controller: txt_New,
  //     textInputAction: TextInputAction.next,
  //
  //     prefixIcon: Padding(
  //         padding: const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 15),
  //         child: SvgPicture.asset(
  //           'assets/icons/pass.svg',
  //           height: 0,
  //           width: 0,
  //         )
  //     ),
  //     obsecureText: pass_show,
  //     suffixIcon: TextButton(
  //         onPressed: () {
  //           setState((){
  //             pass_show = !pass_show;
  //           });
  //         },
  //         child:pass_show? Image.asset(
  //           'assets/icons/pass_hide.png',
  //           color: colorWhite,
  //         ):SvgPicture.asset(
  //           'assets/icons/pass_show.svg',
  //           color: colorWhite,
  //         )),
  //
  //     keyBoardType: TextInputType.text,
  //     validatorFieldValue: 'password',
  //     validator: validatePassword,
  //     // validator: (value) {
  //     //   if (value.isEmpty) {
  //     //     return 'password is Required.';
  //     //   }
  //     // },
  //   );
  // }
  //
  // bool pass_show1 = true;
  // Widget conform_password() {
  //   return AllInputDesign(
  //     floatingLabelBehavior: FloatingLabelBehavior.never,
  //     hintText: 'Confirm New Password',
  //     controller: txt_Cpassword,
  //     textInputAction: TextInputAction.next,
  //
  //     prefixIcon: Padding(
  //         padding: const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 15),
  //         child: SvgPicture.asset(
  //           'assets/icons/pass.svg',
  //           height: 0,
  //           width: 0,
  //         )
  //     ),
  //     obsecureText: pass_show,
  //     suffixIcon: TextButton(
  //         onPressed: () {
  //           setState((){
  //             pass_show = !pass_show;
  //           });
  //         },
  //         child:pass_show? Image.asset(
  //           'assets/icons/pass_hide.png',
  //           color: colorWhite,
  //         ):SvgPicture.asset(
  //           'assets/icons/pass_show.svg',
  //           color: colorWhite,
  //         )),
  //
  //     keyBoardType: TextInputType.text,
  //     validatorFieldValue: 'password',
  //     validator: (value) {
  //       if (value!=txt_New.text.toString()) {
  //         return 'password did  not matched.';
  //       }
  //     },
  //   );
  // }


}
