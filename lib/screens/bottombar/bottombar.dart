import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:hexcolor/hexcolor.dart';

import 'package:glistener/common/styles/const.dart';
import 'package:glistener/screens/library/library.dart';
import 'package:glistener/screens/mymix/mymix.dart';
import 'package:glistener/screens/search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/appbar/appbarpage.dart';
import '../../modal/MyProfile.dart';
import '../home/home.dart';
import '../settings/settings.dart';
import 'ButtonNotch.dart';
import 'package:http/http.dart'as http;
import 'Model.dart';
import 'bottomappbar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
   Future? future;
  String?   user_id = "";
  var status,message,data;
  // var alllist2;
  var firstname,lastname,mobile,email,imgpic;
  String? imgpic1,name;

  @override
  void initState() {
    super.initState();

    setState(() {
      future= myprofile();

    });
  }
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    setState(() {

        future= myprofile();


    });
    super.dispose();
  }
  @override
  void onResumed() {
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
      name = MyProfile_Model.fromJson(json.decode(response.body)).data?.firstname;
      print("hhhhhhhhhhhhhhhhhhhhhhhhhh${imgpic}");

      prefs.setString("appbarname",firstname.toString());
      prefs.setString("appbarimage",imgpic.toString());



      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq${firstname}");
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqq${imgpic}");
      var aa=prefs.getString("appbarname");
      print("wwwwwwwww${aa}");

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
    var map =  Map<String, dynamic>();


    map["user_id"] = user_id.toString();
    print("email ====");
    // print(txt_email.text.toString());

    return map;
  }


  int selectBtn = 0;

  List tabscreen = [
    HomePage(),
    Search(),
    Library(type:0),
    MyMix(),
    Settings(),
  ];




  @override
  Widget build(BuildContext context) {
    print("rrrrrrrrrrrrrrrrr${imgpic}");
    return
      FutureBuilder(
        future: future,
        builder: (context, snapshot) {
            return imgpic==""
                ? const Center(
                child: Text('No Data'))
                :    Scaffold(
              appBar: appbarseting(context, selectBtn,firstname,imgpic),
              backgroundColor: colorappblack,
              body: Stack(
                children: [
                  Container(
                    width: deviceWidth(context),
                    height: deviceheight(context),
                    child: tabscreen[selectBtn],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              ),

            );


        },
        // future: postlist(),
      );



  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      width: deviceWidth(context),
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: colorbutton,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }
  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 40.0 : 0.0;
    var width = isActive ? 60.0 : 0.0;
    return SizedBox(
      width: 60.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,color: Colors.transparent,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                painter: ButtonNotch(),
              )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  navBtn[i].imagePath,
                  color: colorWhite,
                  width: 16,
                ),
                sizedboxheight(2.0),
                Text(
                  navBtn[i].name,
                  style: TextStyle(
                      fontSize: 10,color: colorWhite,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                  ) ,
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

