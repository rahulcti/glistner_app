import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/appbar/appbarwidgetpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/styles/const.dart';
import '../../modal/MyProfile.dart';
import '../change_password/change_password.dart';
import '../change_password/change_password_new.dart';
import 'Edit.dart';
import 'package:http/http.dart'as http;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  String?   user_id = "";
  var status,message,data;
  var firstname,lastname,mobile,email;
  String? imgpic;

  @override
  void initState() {
    super.initState();

    setState(() {
      myprofile();

    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    setState(() {
      myprofile();

    });
    super.dispose();
  }

  @override
  void onResumed() {
    myprofile();
  }


  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

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
      content: new Row(
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


  Future<MyProfile_Model> myprofile() async {

    // initConnectivity();
    //
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // if (_connectionStatus != null) {
    //   // Internet Present Case
    //   showLoaderDialog(context);
    // }else{
    //   Fluttertoast.showToast(
    //       msg: "Please check your Internet connection!!!!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: colorbackmain,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }

    // No-Internet Case

    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id=prefs.getString('user_id');

    var response = await http.post(Uri.parse(BASE_URL+userProfileapi), body: toMap());
    showLoaderDialog(context);

    data=response.body;
    print("yyyyyyyyyyyyyyyyyy"+data);

    // print("aaaaaaaaaaaaaaaaa${response.body[userInfo().userinfo]}");
    print(MyProfile_Model.fromJson(json.decode(response.body)).success);
    print(MyProfile_Model.fromJson(json.decode(response.body)).message);
    print(MyProfile_Model.fromJson(json.decode(response.body)).status);
    status = (MyProfile_Model.fromJson(json.decode(response.body)).status);
    message = (MyProfile_Model.fromJson(json.decode(response.body)).message);

    setState((){
      firstname = MyProfile_Model.fromJson(json.decode(response.body)).data?.firstname;
      lastname = MyProfile_Model.fromJson(json.decode(response.body)).data?.lastname;
      mobile = MyProfile_Model.fromJson(json.decode(response.body)).data?.phone;
      email = MyProfile_Model.fromJson(json.decode(response.body)).data?.email;
      imgpic = MyProfile_Model.fromJson(json.decode(response.body)).data?.image;
      print("hhhhhhhhhhhhhhhhhhhhhhhhhh${imgpic}");

      // email="";

    });
    Navigator.pop(context);
    // print("bbbbbbbbbbbbbbaaaaaaaaaaaaaaaaa${alllist?.first.firstName}");


    if(status==200){


      //
      // Fluttertoast.showToast(
      //     msg: "message",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: colorbackmain,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }else{
      Navigator.pop(context);

      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor:Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return MyProfile_Model.fromJson(json.decode(response.body));
  }
  Map toMap() {
    var map = new Map<String, dynamic>();


    map["user_id"] = user_id.toString();
    print("email ====");
    // print(txt_email.text.toString());

    return map;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: colorappblack,
          leading: backbtnappbar(context),
          centerTitle: true,
          title: Text(
            'My Profile',
            style: textstyleHeading6(context)!.copyWith(color: colorWhite),
          ),
          bottom:  PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child:  Container(
                color: HexColor("#D9D9D9"),
                padding: const EdgeInsets.all(0.4),
              )),
          actions: [
            IconButton(onPressed: (){
              Get.off(() => Edit());
            },
                icon: SvgPicture.asset('assets/icons/edit.svg'))
          ],
      ),
      body: Container(
        height: deviceheight(context),
        width: deviceWidth(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sizedboxheight(deviceheight(context,0.05)),
              Card(
                
                color: colorlightblack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(

                  width: deviceWidth(context,0.8),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sizedboxheight(20.0),

                      // CircleAvatar(
                      //   radius: 60,
                      //   backgroundColor: colorgrey,
                      //   backgroundImage: AssetImage('assets/icons/image.png'),
                      // ),

                      // imgpic==null? Container(
                      //   // width: MediaQuery.of(context).size.width,
                      //   // alignment: Alignment.topCenter,
                      //   // margin: EdgeInsets.only(top: 33),
                      //
                      //
                      //   child:CircleAvatar(
                      //     radius: 60,
                      //
                      //     backgroundImage:AssetImage("assets/icons/image.png") ,
                      //     // child: Image.asset("assets/person.png",width: 150,height: 150,)
                      //   ),
                      //
                      // ):
                      Container(
                          // width: MediaQuery.of(context).size.width,
                          // alignment: Alignment.topCenter,
                          // margin: EdgeInsets.only(top: 33),

                          child:imgpic == "null" || imgpic == null ?


                              Stack(
                                children: [


                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.blueAccent,
                                    // backgroundColor: colorappblack,


                                    // backgroundImage: AssetImage("assets/new/apple.png"),
                                    // backgroundImage: AssetImage("assets/icons/image.png",),
                                  ),
                                  CircleAvatar(
                                      radius: 60,
                                      // backgroundImage:NetworkImage("${BASE_URL}profile/${myimage}"),
                                      backgroundColor: Colors.black.withOpacity(0.45),
                                      child: Center(child: Image.asset("assets/shadowimg.png",width: 25.5,height: 25.5,))

                                    // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                    // )
                                  ),

                                  // Container(
                                  //     margin: EdgeInsets.only(top: 45),
                                  //     child: Center(child: Image.asset("assets/shadowimg.png",width: 25.5,height: 25.5,))),

                                ],
                              )

                          :
                           CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blueGrey,

                             // backgroundImage:FileImage(imgpic),


                             // backgroundImage: AssetImage("assets/new/apple.png"),
                            backgroundImage:
                            // NetworkImage("$imgpic!"),

                             NetworkImage("${BASE_URL_img_upload}${imgpic}"),


                          )
                        // Image.network("${BASE_URL}profile/${alllist!.first.image}".toString(),width: 150,height: 150,),
                      ),




                      sizedboxheight(20.0),
                      Text('First Name',style: TextStyle(color: colortexthit  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 14,height: 1.5)),
                      Text(firstname=="" ?"":'${firstname}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                      sizedboxheight(20.0),
                      Text('Last Name',style: TextStyle(color: colortexthit  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                      Text(lastname=="" ?"":'${lastname}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                      sizedboxheight(20.0),
                      Text('Mobile Number',style: TextStyle(color: colortexthit  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 14,height: 1.5)),
                      Text(mobile=="" ?"" :'${mobile}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                      sizedboxheight(20.0),
                      Text('Email Address',style: TextStyle(color: colortexthit  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 14,height: 1.5)),
                      Text(email=="" ? "" :'${email}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                      sizedboxheight(20.0),
                    ],
                  ),
                ),
              ),
              sizedboxheight(50.0),
              signInBtn(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget signInBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'CHANGE PASSWORD',
        btnstyle: textstylesubtitle2(context)!.copyWith(fontSize: 14, fontWeight: FontWeight.w700,color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),

        btnWidth: deviceWidth(context,0.8),
        btnHeight: 60,
        borderColor: colorWhite,
        btnColor: colorscreenbackground,
        onPressed: () {
          Get.to(() => ChangePasswordNew());
        },
      ),
    );
  }
}
